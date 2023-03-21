-- drop function if exists audit.fn_track_change;
create or replace function audit.fn_track_change() 
	returns trigger
	language 'plpgsql'
	security definer
	parallel restricted
	as $function$

declare
    v_row audit.change_queue;
    -- v_include_values boolean;
    -- log_diffs boolean;
    h_old hstore;
    h_new hstore;
    v_excluded_cols text[] := array[]::text[];
    
    TRG_FIRE_AFTER         constant varchar(5) := 'AFTER';
    TRG_LEVEL_ROW          constant varchar(10) := 'ROW';
    TRG_LEVEL_STATEMENT    constant varchar(10) := 'STATEMENT';
    TRG_OPERATION_INSERT   constant varchar(8) := 'INSERT';
    TRG_OPERATION_UPDATE   constant varchar(8) := 'UPDATE';
    TRG_OPERATION_DELETE   constant varchar(8) := 'DELETE';
    TRG_OPERATION_TRUNCATE constant varchar(8) := 'TRUNCATE';

    APPLICATION constant varchar(20) := 'application_name';

begin
    if tg_when <> TRG_FIRE_AFTER then
        raise exception 'audit.fn_track_change() may only run as an AFTER trigger';
    end if;

    v_row := row(
          1                             -- dummy
        , current_timestamp             -- time_tx
        , txid_current()                -- transaction ID
        , txid_current_if_assigned()    -- transaction ID if assigned
        , TG_RELID                      -- relation OID for much quicker searches
        , false                         -- statement_only
        , TG_TABLE_SCHEMA::text         -- schema_name
        , TG_TABLE_NAME::text           -- table_name
        , 'table'::text                 -- object_type
        , session_user::text            -- user_name
        , txid_status(txid_current())   -- transaction status
        , current_setting(APPLICATION)  -- client application
        , inet_client_addr()            -- client_addr
        , inet_client_port()            -- client_port
        , left(TG_OP, 1)                -- operation
        , null                          -- old_data
        , null                          -- new_data
        , current_query()               -- top-level query or queries (if multistatement) from client
        );

    if not TG_ARGV[0]::boolean is distinct from 'f'::boolean then
        v_row.client_query := null;
    end if;

    if TG_ARGV[1] is not null then
        v_excluded_cols := TG_ARGV[1]::text[];
    end if;
    
    if (TG_OP = TRG_OPERATION_UPDATE and TG_LEVEL = TRG_LEVEL_ROW) then
        v_row.old_data := hstore(old.*) - v_excluded_cols;
        v_row.new_data :=  (hstore(new.*) - v_row.old_data) - v_excluded_cols;
        if (v_row.new_data = hstore('')) then
            -- All changed fields are ignored. Skip this update
            return null;
        end if;
    elsif (TG_OP = TRG_OPERATION_DELETE and TG_LEVEL = TRG_LEVEL_ROW) then
        v_row.old_data := hstore(old.*) - v_excluded_cols;
    elsif (TG_OP = TRG_OPERATION_INSERT and TG_LEVEL = TRG_LEVEL_ROW) then
        v_row.new_data := hstore(new.*) - v_excluded_cols;
    elsif (TG_LEVEL = TRG_LEVEL_STATEMENT and TG_OP in (TRG_OPERATION_INSERT, TRG_OPERATION_UPDATE, TRG_OPERATION_DELETE, TRG_OPERATION_TRUNCATE)) then
        v_row.statement_only := 't';
    else
        raise exception '%[audit.fn_track_change] - Trigger func added as trigger for unhandled case: %, %'
       		, chr(10), TG_OP, TG_LEVEL;
        return null;
    end if;
    
    insert 
   		into audit.change_queue (time_tx, tx_id, tx_id_assigned
                                    , object_id, statement_only
                                    , schema_name, object_name, object_type
                                    , user_name, tx_status, app_name, client_addr, client_port
                                    , operation, old_data, new_data, client_query
                                )
   		values (  v_row.time_tx, v_row.tx_id, v_row.tx_id_assigned
                , v_row.object_id, v_row.statement_only
                , v_row.schema_name, v_row.object_name, v_row.object_type
                , v_row.user_name, v_row.tx_status, v_row.app_name, v_row.client_addr, v_row.client_port
                , v_row.operation, v_row.old_data, v_row.new_data, v_row.client_query
                );
    return null;
end;
$function$
;

comment on function audit.fn_track_change() is '
Track changes to a table at the statement and/or row level.
Optional parameters to trigger in CREATE TRIGGER call:
param 0: boolean, whether to log the query text. Default true.
param 1: text[], columns to ignore in updates. Default [].
         Updates to ignored cols are omitted from new_data.
         Updates with only ignored cols changed are not inserted
         into the audit log.
         Almost all the processing work is still done for updates
         that ignored. If you need to save the load, you need to use
         WHEN clause on the trigger instead.
         No warning or error is issued if p_ignored_cols contains columns
         that do not exist in the target table. This lets you specify
         a standard set of ignored columns.
There is no parameter to disable logging of values. Add this trigger as
a FOR EACH STATEMENT rather than FOR EACH ROW trigger if you do not
want to log row values.
Note that the user name logged is the login role for the session. The audit trigger
cannot obtain the active role because it is reset by the SECURITY DEFINER invocation
of the audit trigger its self.';

--
-- Success
-- No explicit checking function
--



-- drop function if exists audit.fn_track_table_set(regclass, boolean, boolean, text);
create or replace function audit.fn_track_table_set(p_target_table regclass
                                                    , p_track_rows boolean
                                                    , p_track_query_text boolean
                                                    , p_ignored_cols text[]
                                                    ) 
	returns varchar 
	language 'plpgsql'
	as $function$

declare
	v_stm_targets varchar(40) := 'insert or update or delete or truncate';
	v_sql text;
	v_ignored_cols_snip text := '';
	
    TRG_OPERATION_TRUNCATE constant varchar(8) := 'truncate';
    TRG_ROW_NAME constant varchar(18) := 'change_trigger_row';
    TRG_STM_NAME constant varchar(18) := 'change_trigger_stm';

begin
	execute format($$
	               drop trigger if exists %s on %s
	               $$
                    , TRG_ROW_NAME
                    ,p_target_table
                    )
    ;
    execute format($$
                   drop trigger if exists %s on %s
                   $$
                    , TRG_STM_NAME
                    ,p_target_table
                    )
    ;

    if p_track_rows then
        if array_length(p_ignored_cols,1) > 0 then
            v_ignored_cols_snip := ', ' || quote_literal(p_ignored_cols);
        end if;
        v_sql := format($$
                        create trigger %s 
                            after insert or update or delete on %s 
                            for each row execute procedure audit.fn_track_change(%L%s);
                        $$
                        , TRG_ROW_NAME
                        , p_target_table 
                        , p_track_query_text
                        , v_ignored_cols_snip
                        );
        execute v_sql;
        v_stm_targets := TRG_OPERATION_TRUNCATE;
    end if;

    v_sql := format($$
                    create trigger %s 
                        after %s on %s 
                        for each statement execute procedure audit.fn_track_change(%L);
                    $$
                    , TRG_STM_NAME
                    , v_stm_targets 
                    , p_target_table
                    , p_track_query_text
                    );
    execute v_sql;

	return v_sql;
end;
$function$
;

comment on function audit.fn_track_table_set(regclass, boolean, boolean, text[]) is '
Add auditing support to a table.
Arguments:
   p_target_table:     Table name, schema qualified if not on search_path
   p_track_rows:       Record each row change, or only audit at a statement level
   p_track_query_text: Record the text of the client query that triggered the audit event?
   p_ignored_cols:     Columns to exclude from update diffs, ignore updates that change only ignored cols.';

--
-- Success
--
--select * from audit.fn_track_table_set('stage_dmo.all_taxrule_status', true, true, null);



--drop procedure if exists audit.fn_track_table_drop();
create or replace procedure audit.fn_track_table_drop(p_target_table regclass) 
	language 'plpgsql'
	as $procedure$

declare
	TRG_ROW_NAME constant varchar(18) := 'change_trigger_row';
    TRG_STM_NAME constant varchar(18) := 'change_trigger_stm';

begin
    execute format($$
                   drop trigger if exists %s on %s
                   $$
                    , TRG_ROW_NAME
                    ,p_target_table
                    )
    ;
    execute format($$
                   drop trigger if exists %s on %s
                   $$
                    , TRG_STM_NAME
                    ,p_target_table
                    )
    ;
end;
$procedure$
;

comment on procedure audit.fn_track_table_drop is '
Drop auditing support for a table.
Arguments:
   p_target_table:     Table name, schema qualified if not on search_path';

--
-- Success
--
--call audit.fn_track_table_drop('stage_dmo.all_taxrule_status');



-- drop function if exists audit.fn_track_table_set(regclass, boolean, boolean);
create or replace function audit.fn_track_table_set(p_target_table regclass
                                                , p_track_rows boolean
                                                , p_track_query_text boolean
                                                ) 
	returns varchar 
	language 'plpgsql'
	as $function$

declare 
	v_sql varchar;

begin 
	select audit.fn_track_table_set(p_target_table, p_track_rows, p_track_query_text, array[]::text[])
		into v_sql
	;
	return v_sql;
end;
$function$ 
;

--
-- Success
--
--select * from audit.fn_track_table_set('stage_dmo.all_taxrule_status', true, true);



-- drop function if exists audit.fn_track_table_set(regclass);
create or replace function audit.fn_track_table_set(p_target_table regclass) 
	returns varchar 
	language 'plpgsql'
	as $function$

declare 
	v_sql varchar;

begin
	select audit.fn_track_table_set(p_target_table, true, true) 
		into v_sql
	;
	return v_sql;
end;
$function$ 
;

comment on function audit.fn_track_table_set(regclass) is '
Add auditing support to the given table. Row-level changes will be logged with full client query text. No cols are ignored';

--
-- Success
--
--select * from audit.fn_track_table_set('stage_dmo.all_taxrule_status');



-- drop function if exists audit.fn_track_schema_set;
create or replace function audit.fn_track_schema_set(
                                                    p_schema_name varchar(60)
                                                    )
	returns table(sql_trigger varchar)
	language 'plpgsql'
	as $function$

declare
    TABLE_TYPE_BASE constant varchar(10) := 'BASE TABLE';
    
begin
	return query
		select audit.fn_track_table_set(
									   case table_name
									       when 'user' 
											     then p_schema_name || '."user"'
											else 
											     p_schema_name || '.' || table_name
										end
									) as sql_trigger
			from information_schema.tables
			where 1=1
				and table_schema = p_schema_name
				and table_type = TABLE_TYPE_BASE
		;
end;
$function$
;

comment on function audit.fn_track_schema_set(varchar) is 'Set auditing for all tables in the schema';

--
-- Success
--
--select * from audit.fn_track_schema_set('stage_dmo');

/*
select tgname as trigger_name
		, case tgtype::varchar 
			when '29' then 'ON ROW'
			when '32' then 'ON STATEMENT'
			else tgtype::varchar
		end as trigger_type
		, case tgenabled 
			when 'O' then 'ENABLED ORIGIN LOCAL'
			when 'D' then 'DISABLED'
			when 'R' then 'ENABLED IN REPLICA'
			when 'A' then 'ENABLED ALWAYS'
		end as status
	from pg_catalog.pg_trigger 
	where tgname like 'change_trigger%'
;
*/



-- drop procedure if exists audit.fn_track_schema_drop;
create or replace procedure audit.fn_track_schema_drop(
													p_schema_name varchar(60)
													)
	language 'plpgsql'
	as $procedure$

declare 
	v_row_data record;
    
    TRG_PREFIX constant varchar(15) := 'change_trigger%';

begin
	for v_row_data in 
                    select nspname as schema_name
                        , relname as table_name
                        , tgname as trigger_name
                        from pg_trigger t
                            inner join pg_class c on (c.oid = t.tgrelid) 
                            inner join pg_namespace ns on (ns.nspowner = c.relowner)
                        where 1=1
                            and ns.nspname = p_schema_name
                            and tgname like TRG_PREFIX
	loop
		execute format($$
                        drop trigger if exists %s on %L.%s
                        $$
                        , v_row_data.trigger_name
                        , v_row_data.schema_name
                        , (case v_row_data.table_name
                            when 'user' then '"user"'
                            else v_row_data.table_name
                        end)
                        )
        ;
	end loop;
end;
$procedure$
;

comment on procedure audit.fn_track_schema_drop(varchar) is 'Drop auditing for all tables in the schema';

--call audit.fn_track_schema_drop('stage_dmo');



-- drop procedure if exists audit.fn_track_schema_enable;
create or replace procedure audit.fn_track_schema_enable(
                                                        p_schema_name varchar(60)
                                                        )
	language 'plpgsql'
	as $procedure$

declare 
	v_row_data record;

    TRG_PREFIX constant varchar(15) := 'change_trigger%';

begin
	for v_row_data in 
                    select nspname as schema_name
                        , relname as table_name
                        , tgname as trigger_name
                        from pg_trigger t
                            inner join pg_class c on (c.oid = t.tgrelid) 
                            inner join pg_namespace ns on (ns.nspowner = c.relowner)
                        where 1=1
                            and ns.nspname = p_schema_name
                            and tgname like TRG_PREFIX
	loop
		execute 'alter table ' 
				|| v_row_data.schema_name || '.' 
				|| (case v_row_data.table_name
						when 'user' then '"user"'
						else v_row_data.table_name
					end) 
				|| ' enable trigger ' || v_row_data.trigger_name;
	end loop;
end;
$procedure$
;

comment on procedure audit.fn_track_schema_enable(varchar) is 'Enable auditing triggers for all tables in the schema';

--call audit.fn_track_schema_enable('stage_dmo');



-- drop procedure if exists audit.fn_track_schema_disable;
create or replace procedure audit.fn_track_schema_disable(
                                                        p_schema_name varchar(60)
                                                        )
	language 'plpgsql'
	as $procedure$

declare 
	v_row_data record;

    TRG_PREFIX constant varchar(15) := 'change_trigger%';

begin
	for v_row_data in 
                    select nspname as schema_name
                        , relname as table_name
                        , tgname as trigger_name
                        from pg_trigger t
                            inner join pg_class c on (c.oid = t.tgrelid) 
                            inner join pg_namespace ns on (ns.nspowner = c.relowner)
                        where 1=1
                            and ns.nspname = p_schema_name
                            and tgname like TRG_PREFIX
	loop
		execute 'alter table ' 
				|| v_row_data.schema_name || '.' 
				|| (case v_row_data.table_name
						when 'user' then '"user"'
						else v_row_data.table_name
					end) 
				|| ' disable trigger ' || v_row_data.trigger_name;
	end loop;
end;
$procedure$
;

comment on procedure audit.fn_track_schema_disable(varchar) is 'Disable auditing triggers for all tables in the schema';

--
-- Success
--

--call audit.fn_track_schema_disable('stage_dmo');



-- drop procedure if exists audit.fn_track_schema;
create or replace procedure audit.fn_track_schema(
												p_schema_name varchar(60), 
												p_status varchar(8)
												)
	language 'plpgsql'
	as $procedure$

declare 
	v_row_data record;

    TRG_PREFIX constant varchar(15) := 'change_trigger%';

begin
	for v_row_data in 
				select nspname as schema_name
					, relname as table_name
					, tgname as trigger_name
					from pg_trigger t
				    	inner join pg_class c on (c.oid = t.tgrelid) 
						inner join pg_namespace ns on (ns.nspowner = c.relowner)
					where 1=1
						and ns.nspname = p_schema_name
						and tgname like TRG_PREFIX
	loop
		execute format('
						alter table %I.%I 
							%I trigger %s'
						, v_row_data.schema_name
						, v_row_data.table_name
						, p_status
						, v_row_data.trigger_name
					)
		;
	end loop;
end;
$procedure$
;

comment on procedure audit.fn_track_schema(varchar, varchar) is 'Enable or disable auditing triggers for all tables in the schema';

--
-- Success
--

--call audit.fn_track_schema_enable('stage_dmo', 'enable');



-- drop function if exists audit.fn_track_table_list_set;
create or replace function audit.fn_track_table_list_set(p_track_table_list_name varchar(60) default 'track_table_list')
    returns table (
        schema_name varchar(60)
        , table_name varchar(60)
        , track_row boolean
        , track_stm boolean
        , exclude_column text[]
    ) 
    language 'plpgsql'
    as $function$

declare
    v_sql text;
    v_row record;

begin
    for v_row in 
                execute format ($$
                                select schema_name, table_name, track_row, track_stm, exclude_column
                                    from %s
                                    where table_process
                                $$
                                , p_track_table_list_name
                                )
    loop
        perform audit.fn_track_table_set(v_row.schema_name || '.' || v_row.table_name
                                        , v_row.track_row, v_row.track_stm
                                        , v_row.exclude_column)
        ;
        schema_name := v_row.schema_name;
        table_name := v_row.table_name;
        track_row := v_row.track_row;
        track_stm := v_row.track_stm;
        exclude_column := v_row.exclude_column;
        return next; 
    end loop;
end;
$function$
;

comment on function audit.fn_track_table_list_set is '
Add auditing support to the tables defined through the table.
Arguments:
   p_track_table_list_name:     table name, possibly with schema name, that contain a list of tables to be tracked.
Expected table format:
    schema_name    -- schema
    table_name     -- table to be tracked
    table_process  -- process table if "true"
    track_row      -- set rows tracking if "true"
    track_stm      -- set statement tracking if "true"
    exclude_column -- list of columns not to be tracked';

--
-- Success
--
--select * from audit.fn_track_table_list_set('audit.track_table_list');



--drop function if exists audit.fn_track_table_list_drop;
create or replace function audit.fn_track_table_list_drop(p_track_table_list_name varchar(60) default 'track_table_list') 
    returns table (
        schema_name varchar(60)
        , table_name varchar(60)
        , track_row boolean
        , track_stm boolean
        , exclude_column text[]
    ) 
    language 'plpgsql'
    as $function$

declare
    v_sql text;
    v_row record;

begin
    for v_row in 
                execute format ($$
                                select schema_name, table_name, track_row, track_stm, exclude_column
                                    from %s
                                    where table_process
                                $$
                                , p_track_table_list_name
                                )
    loop
        call fn_track_table_drop(v_row.schema_name || '.' || v_row.table_name);
        schema_name := v_row.schema_name;
        table_name := v_row.table_name;
        track_row := v_row.track_row;
        track_stm := v_row.track_stm;
        exclude_column := v_row.exclude_column;
        return next; 
    end loop;
end;
$function$
;

comment on function audit.fn_track_table_list_drop is '
Drop auditing support for a tables defined through the table.
Arguments:
   p_track_table_list_name:     table name, possibly with schema name, that contain a list of tables to be tracked.
Expected table format:
    schema_name    -- schema
    table_name     -- table to be tracked
    table_process  -- process table if "true"
    track_row      -- set rows tracking if "true"
    track_stm      -- set statement tracking if "true"
    exclude_column -- list of columns not to be tracked';

--
-- Success
--

--select * from audit.fn_track_table_list_drop('audit.track_table_list');



-- drop function if exists audit.fn_track_table_list_fill;
create or replace function audit.fn_track_table_list_fill(
                                                        p_schema_name varchar(60)
                                                        , p_track_row boolean default true
                                                        , p_track_stm boolean default true 
                                                        , p_track_table_list_name varchar(60) default 'track_table_list'
                                                        )
    returns table (
        schema_name varchar(60)
        , table_name varchar(60)
        , track_row boolean
        , track_stm boolean
        , exclude_column text[]
    ) 
    language 'plpgsql'
    as $function$

declare
    v_sql text;
    v_row record;

begin
    execute format ($$
                    insert
                        into %s (schema_name, table_name, track_row, track_stm)
                            select t.schemaname, t.tablename, boolean %L, boolean %L
                                from pg_catalog.pg_tables t
                                    inner join pg_class c on c.oid = t.tablename::regclass
                                where 1=1
                                    and schemaname = %L
                                    and not c.relispartition
                        on conflict 
                            do nothing
                    $$
                    , p_track_table_list_name
                    , p_track_row
                    , p_track_stm
                    , p_schema_name
                    )
        ;
    return query
        execute format ($$
                        select schema_name, table_name, track_row, track_stm, exclude_column
                            from %s
                        $$
                        , p_track_table_list_name
                        )
    ;
end;
$function$
;

comment on function audit.fn_track_table_list_fill is '
Fill table with tables for the define schema. Target table should exist before running the function.
Arguments:
    p_schema_name           -- schema from which tables will be get
    p_track_row             -- set rows change tracking
    p_track_stm             -- set statement change tracking
    p_track_table_list_name -- target table with possible schema definition
Expected target table format:
    schema_name    -- schema
    table_name     -- table to be tracked
    table_process  -- process table if "true"
    track_row      -- set rows tracking if "true"
    track_stm      -- set statement tracking if "true"
    exclude_column -- list of columns not to be tracked';

--
-- Success
--
--select * from audit.fn_track_table_list_fill('cdc', p_track_table_list_name => 'public.track_table_list');

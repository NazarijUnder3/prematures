drop function if exists audit.fn_tracked_table_name;
create or replace function audit.fn_tracked_table_name(
                                                    sSchemaName varchar
                                                    )
	returns table(audited_table_name varchar)
	language 'sql'
	as $function$

	select distinct t.event_object_table as audited_table
		from information_schema.triggers t
		where 1=1
			and t.trigger_name::text in ('change_trigger_row'::text, 'change_trigger_stm'::text)  
			and t.trigger_schema = sSchemaName
		order by audited_table
	;
$function$
;

comment on function audit.fn_tracked_table_name is 'List audited tables in the schema with specified name';



drop function if exists audit.fn_non_tracked_table_name;
create or replace function audit.fn_non_tracked_table_name(
														sSchemaName varchar
														)
	returns table(non_audited_table_name varchar)
	language 'sql'
	as $function$

	select tablename::varchar as not_audited_table_name 
		from pg_catalog.pg_tables 
		where schemaname = sSchemaName
	except
	select distinct t.event_object_table as not_audited_table_name
		from information_schema.triggers t
		where 1=1
			and t.trigger_name::text in ('change_trigger_row'::text, 'change_trigger_stm'::text)  
			and t.trigger_schema = sSchemaName
		order by not_audited_table_name
	;
$function$
;

comment on function audit.fn_non_tracked_table_name is 'List non-audited tables in the schema with specified name';




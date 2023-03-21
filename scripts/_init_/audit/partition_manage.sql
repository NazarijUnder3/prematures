--drop function if exists audit.fn_add_partition;
create or replace function audit.fn_partition_add(p_table_name varchar(65)
                                                , p_start_date timestamp default current_date
                                                , p_period_type varchar(10) default 'day'
                                                , p_period_count integer default 1
                                                ) 
    returns table (
                    table_name name
                    , partition_name name
                    , partition_expression text
                    ) 
    language 'plpgsql'
    as $function$

declare
    sSQL text;
    i integer;
    v_partition_suffix varchar(14);
    v_default_partition_count integer;
    v_start_range timestamp(0);
    v_end_range timestamp(0);

    v_current_time timestamp(0) := p_start_date;
    
    RELATION_NAME constant varchar(65) := 'change_queue';
    PARTITION_DEFAULT constant varchar(10) := 'DEFAULT';
    YYYYMMDD_MASK constant varchar(14) := 'yyyymmddhh24mi';

begin
    -- create partitions
    for i in 1..p_period_count loop
        v_start_range := date_trunc(p_period_type, v_current_time) + (i - 1) * cast('1 ' || p_period_type as interval);
        v_end_range := v_start_range + cast('1 ' || p_period_type as interval);
        v_partition_suffix := to_char(v_start_range, YYYYMMDD_MASK);

        sSQL := format ($$
                        create table %s_%s
                            partition of %s 
                                for values from ('%s') TO ('%s');
                        $$
                        , p_table_name, v_partition_suffix
                        , p_table_name
                        , v_start_range, v_end_range
        ); 

        execute sSQL;

        -- Permissions
        execute format ($$
                        revoke all on %s_%s
                            from public;
                        $$
                        , p_table_name, v_partition_suffix
        );
    end loop;

    -- create default if not exists
    select count(*)
        into v_default_partition_count
        from pg_class c 
            inner join pg_inherits i on i.inhparent = c.oid 
            inner join pg_class pt on pt.oid = i.inhrelid
        where 1=1
            and c.relname = RELATION_NAME
            and pg_get_expr(pt.relpartbound, pt.oid, true) = PARTITION_DEFAULT
    ;
    if v_default_partition_count = 0 then
        sSQL := format ($$
                        create table %s_%s 
                            partition of %s default;
                        $$
                        , p_table_name, PARTITION_DEFAULT
                        , p_table_name 
        );
        execute sSQL;

        -- premissions for default
        execute format ($$
                        revoke all on %s_default from public;
                        $$
                        , p_table_name
        );    
    end if;

    return query 
        select c.relname as table_name
                , pt.relname as partition_name
                , pg_get_expr(pt.relpartbound, pt.oid, true) as partition_expression
            from pg_class c 
                inner join pg_inherits i on i.inhparent = c.oid 
                inner join pg_class pt on pt.oid = i.inhrelid
            where c.relname = substring(p_table_name, position('.' in p_table_name) + 1)
        ;
end;
$function$
;

comment on function audit.fn_partition_add is 'Generate specified number of partitions for the defined table starting from the defined date';

--
-- Success
--
--select * from audit.fn_partition_add('audit.change_queue', p_start_date => (current_date + 11), p_period_count => 10);



create or replace function audit.fn_partition_create(p_table_name varchar(65)
                                                , p_period_type varchar(10) default 'day'
                                                , p_period_count integer default 1
                                                ) 
    returns table (
                    table_name name
                    , partition_name name
                    , partition_expression text
                    ) 
    language 'plpgsql'
    as $function$

begin
    return query
        select * 
            from audit.fn_partition_add(p_table_name, current_date, p_period_type, p_period_count);
end;
$function$
;

comment on function audit.fn_partition_create is 'Generate specified number of partitions for the defined table';

--
--Success
--
--select * from audit.fn_partition_create('change_queue', 'hour', 5);
--select * from audit.fn_partition_create('change_queue', 'day', 3);



create or replace function audit.fn_partition_extend(p_table_name varchar(65)
                                                    , p_period_type varchar(10) default 'day'
                                                    , p_period_count integer default 1
                                                    ) 
    returns table (
                    table_name name
                    , partition_name name
                    , partition_expression text
                    ) 
    language 'plpgsql'
    as $function$

declare
    v_maxdatetmie timestamp;
    TO_RANGE_MASK constant varchar(20) := '.+ TO \((.+)\)';
    INTERVAL_MINUTE constant varchar(6) := 'minute';

begin
    select max(substring(pg_get_expr(pt.relpartbound, pt.oid, true) from TO_RANGE_MASK)::timestamp)
        into v_maxdatetmie
        from pg_class base_tb 
            join pg_inherits i on i.inhparent = base_tb.oid 
            join pg_class pt on pt.oid = i.inhrelid
        where base_tb.oid = p_table_name::regclass
    ;
    return query
        select * 
            from audit.fn_partition_add(p_table_name
                                    , v_maxdatetmie + cast('1 ' || INTERVAL_MINUTE as interval)
                                    , p_period_type
                                    , p_period_count
                                    );
end;
$function$
;

comment on function audit.fn_partition_extend is 'Generate specified number of partitions for the defined table';

--
--Success
--
--select * from audit.fn_partition_extend('change_queue', 'hour', 5);
--select * from audit.fn_partition_extend('change_queue', 'day', 5);

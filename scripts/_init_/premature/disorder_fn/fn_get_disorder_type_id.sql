--drop function if exists main.fn_get_disorder_type_id;
create or replace function main.fn_get_disorder_type_id(
											p_disorder_type_name main.disorder_type.disorder_type_name%type
											)
    returns main.disorder_type.disorder_type_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_disorder_type_id main.disorder_type.disorder_type_id%type;
 
begin
    select disorder_type_id
        into v_disorder_type_id
        from main.disorder_type
        where disorder_type_name = p_disorder_type_name
    ;
 
    return v_disorder_type_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_disorder_type_id('НН');
--select * from main.fn_get_disorder_type_id('sdft');
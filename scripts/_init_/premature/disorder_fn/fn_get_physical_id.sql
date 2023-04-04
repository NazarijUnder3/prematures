--drop function if exists main.fn_get_physical_id;
create or replace function main.fn_get_physical_id(
											p_physical_name main.physical.physical_name%type
											)
    returns main.physical.physical_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_physical_id main.physical.physical_id%type;
 
begin
    select physical_id
        into v_physical_id
        from main.physical
        where physical_name = p_physical_name
    ;
 
    return v_physical_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_physical_id('нет');
--select * from main.fn_get_physical_id('sdft');
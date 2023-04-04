--drop function if exists main.fn_get_locality_id;
create or replace function main.fn_get_locality_id(
											p_locality_name main.locality.locality_name%type
											)
    returns main.locality.locality_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_locality_id main.locality.locality_id%type;
 
begin
    select locality_id
        into v_locality_id
        from main.locality
        where locality_name = p_locality_name
    ;
 
    return v_locality_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_locality_id('РБ');
--select * from main.fn_get_locality_id('Любань');
--select * from main.fn_get_locality_id('sdft');
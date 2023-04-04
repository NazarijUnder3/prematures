--drop function if exists main.fn_get_strabismus_id;
create or replace function main.fn_get_strabismus_id(
											p_strabismus_name main.strabismus.strabismus_name%type
											)
    returns main.strabismus.strabismus_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_strabismus_id main.strabismus.strabismus_id%type;
 
begin
    select strabismus_id
        into v_strabismus_id
        from main.strabismus
        where strabismus_name = p_strabismus_name
    ;
 
    return v_strabismus_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_strabismus_id('нет');
--select * from main.fn_get_strabismus_id('sdft');
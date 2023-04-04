--drop function if exists main.fn_get_reflex_id;
create or replace function main.fn_get_reflex_id(
											p_reflex_name main.reflex.reflex_name%type
											)
    returns main.reflex.reflex_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_reflex_id main.reflex.reflex_id%type;
 
begin
    select reflex_id
        into v_reflex_id
        from main.reflex
        where reflex_name = p_reflex_name
    ;
 
    return v_reflex_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_reflex_id('высокие');
--select * from main.fn_get_reflex_id('sdft');
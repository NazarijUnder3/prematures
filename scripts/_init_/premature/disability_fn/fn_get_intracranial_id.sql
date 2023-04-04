--drop function if exists main.fn_get_intracranial_id;
create or replace function main.fn_get_intracranial_id(
											p_intracranial_name main.intracranial.intracranial_name%type
											)
    returns main.intracranial.intracranial_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_intracranial_id main.intracranial.intracranial_id%type;
 
begin
    select intracranial_id
        into v_intracranial_id
        from main.intracranial
        where intracranial_name = p_intracranial_name
    ;
 
    return v_intracranial_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_intracranial_id('нет');
--select * from main.fn_get_intracranial_id('sdft');
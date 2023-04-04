--drop function if exists main.fn_get_leukomalacia_id;
create or replace function main.fn_get_leukomalacia_id(
											p_leukomalacia_name main.leukomalacia.leukomalacia_name%type
											)
    returns main.leukomalacia.leukomalacia_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_leukomalacia_id main.leukomalacia.leukomalacia_id%type;
 
begin
    select leukomalacia_id
        into v_leukomalacia_id
        from main.leukomalacia
        where leukomalacia_name = p_leukomalacia_name
    ;
 
    return v_leukomalacia_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_leukomalacia_id('нет');
--select * from main.fn_get_leukomalacia_id('sdft');
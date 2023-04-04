--drop function if exists main.fn_get_sepsis_id;
create or replace function main.fn_get_sepsis_id(
											p_sepsis_name main.sepsis.sepsis_name%type
											)
    returns main.sepsis.sepsis_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_sepsis_id main.sepsis.sepsis_id%type;
 
begin
    select sepsis_id
        into v_sepsis_id
        from main.sepsis
        where sepsis_name = p_sepsis_name
    ;
 
    return v_sepsis_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_sepsis_id('нет');
--select * from main.fn_get_sepsis_id('sdft');
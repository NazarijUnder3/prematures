--drop function if exists main.fn_get_sepsis_ethiology_id;
create or replace function main.fn_get_sepsis_ethiology_id(
											p_sepsis_ethiology_name main.sepsis_ethiology.sepsis_ethiology_name%type
											)
    returns main.sepsis_ethiology.sepsis_ethiology_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_sepsis_ethiology_id main.sepsis_ethiology.sepsis_ethiology_id%type;
 
begin
    select sepsis_ethiology_id
        into v_sepsis_ethiology_id
        from main.sepsis_ethiology
        where sepsis_ethiology_name = p_sepsis_ethiology_name
    ;
 
    return v_sepsis_ethiology_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_sepsis_ethiology_id('БДУ');
--select * from main.fn_get_sepsis_ethiology_id('sdft');
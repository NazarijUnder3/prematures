--drop function if exists main.fn_get_apgar1_id;
create or replace function main.fn_get_apgar1_id(
											p_apgar1_name main.apgar1.apgar1_name%type
											)
    returns main.apgar1.apgar1_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_apgar1_id main.apgar1.apgar1_id%type;
 
begin
    select apgar1_id
        into v_apgar1_id
        from main.apgar1
        where apgar1_name = p_apgar1_name
    ;
 
    return v_apgar1_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_apgar1_id('CPAP');
--select * from main.fn_get_apgar1_id('sdft');
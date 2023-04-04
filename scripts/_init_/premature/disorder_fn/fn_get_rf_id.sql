--drop function if exists main.fn_get_rf_id;
create or replace function main.fn_get_rf_id(
											p_rf_name main.rf.rf_name%type
											)
    returns main.rf.rf_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_rf_id main.rf.rf_id%type;
 
begin
    select rf_id
        into v_rf_id
        from main.rf
        where rf_name = p_rf_name
    ;
 
    return v_rf_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_rf_id('норма');
--select * from main.fn_get_rf_id('sdft');
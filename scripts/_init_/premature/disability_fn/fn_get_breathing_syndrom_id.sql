--drop function if exists main.fn_get_breathing_syndrom_id;
create or replace function main.fn_get_breathing_syndrom_id(
											p_breathing_syndrom_name main.breathing_syndrom.breathing_syndrom_name%type
											)
    returns main.breathing_syndrom.breathing_syndrom_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_breathing_syndrom_id main.breathing_syndrom.breathing_syndrom_id%type;
 
begin
    select breathing_syndrom_id
        into v_breathing_syndrom_id
        from main.breathing_syndrom
        where breathing_syndrom_name = p_breathing_syndrom_name
    ;
 
    return v_breathing_syndrom_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_breathing_syndrom_id('нет');
--select * from main.fn_get_breathing_syndrom_id('sdft');
--drop function if exists main.fn_get_multipregnancy_condition_id;
create or replace function main.fn_get_multipregnancy_condition_id(
											p_multipregnancy_condition_name main.multipregnancy_condition.multipregnancy_condition_name%type
											)
    returns main.multipregnancy_condition.multipregnancy_condition_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_multipregnancy_condition_id main.multipregnancy_condition.multipregnancy_condition_id%type;
 
begin
    select multipregnancy_condition_id
        into v_multipregnancy_condition_id
        from main.multipregnancy_condition
        where multipregnancy_condition_name = p_multipregnancy_condition_name
    ;
 
    return v_multipregnancy_condition_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_multipregnancy_condition_id('БДУ');
--select * from main.fn_get_multipregnancy_condition_id('sdft');
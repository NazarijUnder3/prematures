--drop function if exists main.fn_get_multipregnancy_result_id;
create or replace function main.fn_get_multipregnancy_result_id(
											p_multipregnancy_result_name main.multipregnancy_result.multipregnancy_result_name%type
											)
    returns main.multipregnancy_result.multipregnancy_result_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_multipregnancy_result_id main.multipregnancy_result.multipregnancy_result_id%type;
 
begin
    select multipregnancy_result_id
        into v_multipregnancy_result_id
        from main.multipregnancy_result
        where multipregnancy_result_name = p_multipregnancy_result_name
    ;
 
    return v_multipregnancy_result_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_multipregnancy_result_id('одноплодный');
--select * from main.fn_get_multipregnancy_result_id('sdft');
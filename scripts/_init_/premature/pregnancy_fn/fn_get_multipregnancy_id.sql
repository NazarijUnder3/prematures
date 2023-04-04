--drop function if exists main.fn_get_multipregnancy_id;
create or replace function main.fn_get_multipregnancy_id(
											p_multipregnancy_name main.multipregnancy.multipregnancy_name%type
											)
    returns main.multipregnancy.multipregnancy_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_multipregnancy_id main.multipregnancy.multipregnancy_id%type;
 
begin
    select multipregnancy_id
        into v_multipregnancy_id
        from main.multipregnancy
        where multipregnancy_name = p_multipregnancy_name
    ;
 
    return v_multipregnancy_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_multipregnancy_id('нет');
--select * from main.fn_get_multipregnancy_id('sdft');
--drop function if exists main.fn_get_mrt_id;
create or replace function main.fn_get_mrt_id(
											p_mrt_name main.mrt.mrt_name%type
											)
    returns main.mrt.mrt_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_mrt_id main.mrt.mrt_id%type;
 
begin
    select mrt_id
        into v_mrt_id
        from main.mrt
        where mrt_name = p_mrt_name
    ;
 
    return v_mrt_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_mrt_id('норма');
--select * from main.fn_get_mrt_id('sdft');
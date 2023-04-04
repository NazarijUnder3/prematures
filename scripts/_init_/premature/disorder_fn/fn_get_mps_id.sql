--drop function if exists main.fn_get_mps_id;
create or replace function main.fn_get_mps_id(
											p_mps_name main.mps.mps_name%type
											)
    returns main.mps.mps_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_mps_id main.mps.mps_id%type;
 
begin
    select mps_id
        into v_mps_id
        from main.mps
        where mps_name = p_mps_name
    ;
 
    return v_mps_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_mps_id('норма');
--select * from main.fn_get_mps_id('sdft');
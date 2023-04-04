--drop function if exists main.fn_get_coordination_id;
create or replace function main.fn_get_coordination_id(
											p_coordination_name main.coordination.coordination_name%type
											)
    returns main.coordination.coordination_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_coordination_id main.coordination.coordination_id%type;
 
begin
    select coordination_id
        into v_coordination_id
        from main.coordination
        where coordination_name = p_coordination_name
    ;
 
    return v_coordination_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_coordination_id('да');
--select * from main.fn_get_coordination_id('sdft');
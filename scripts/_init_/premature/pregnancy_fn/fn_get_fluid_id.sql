--drop function if exists main.fn_get_fluid_id;
create or replace function main.fn_get_fluid_id(
											p_fluid_name main.fluid.fluid_name%type
											)
    returns main.fluid.fluid_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_fluid_id main.fluid.fluid_id%type;
 
begin
    select fluid_id
        into v_fluid_id
        from main.fluid
        where fluid_name = p_fluid_name
    ;
 
    return v_fluid_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_fluid_id('норма');
--select * from main.fn_get_fluid_id('sdft');
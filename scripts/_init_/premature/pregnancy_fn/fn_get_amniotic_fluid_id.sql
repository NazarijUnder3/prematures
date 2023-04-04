--drop function if exists main.fn_get_amniotic_fluid_id;
create or replace function main.fn_get_amniotic_fluid_id(
											p_amniotic_fluid_name main.amniotic_fluid.amniotic_fluid_name%type
											)
    returns main.amniotic_fluid.amniotic_fluid_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_amniotic_fluid_id main.amniotic_fluid.amniotic_fluid_id%type;
 
begin
    select amniotic_fluid_id
        into v_amniotic_fluid_id
        from main.amniotic_fluid
        where amniotic_fluid_name = p_amniotic_fluid_name
    ;
 
    return v_amniotic_fluid_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_amniotic_fluid_id('БО');
--select * from main.fn_get_amniotic_fluid_id('sdft');
--drop function if exists main.fn_get_immersion_id;
create or replace function main.fn_get_immersion_id(
											p_immersion_name main.immersion.immersion_name%type
											)
    returns main.immersion.immersion_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_immersion_id main.immersion.immersion_id%type;
 
begin
    select immersion_id
        into v_immersion_id
        from main.immersion
        where immersion_name = p_immersion_name
    ;
 
    return v_immersion_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_immersion_id('нет');
--select * from main.fn_get_immersion_id('sdft');
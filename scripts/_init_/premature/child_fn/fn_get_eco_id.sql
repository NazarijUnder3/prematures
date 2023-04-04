--drop function if exists main.fn_get_eco_id;
create or replace function main.fn_get_eco_id(
											p_eco_name main.eco.eco_name%type
											)
    returns main.eco.eco_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_eco_id main.eco.eco_id%type;
 
begin
    select eco_id, eco_name
    	from main.eco
    union
    select eco_id, eco_name
		from main.alt_eco
    ;
 
    return v_eco_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_eco_id('1-я');
--select * from main.fn_get_eco_id('sdft');
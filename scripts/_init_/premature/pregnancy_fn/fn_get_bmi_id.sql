--drop function if exists main.fn_get_bmi_id;
create or replace function main.fn_get_bmi_id(
											p_bmi_status main.bmi.bmi_status%type
											)
    returns main.bmi.bmi_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_bmi_id main.bmi.bmi_id%type;
 
begin
    select bmi_id
		into v_bmi_id
		from (
				select bmi_id, bmi_status
					from main.bmi
				union
				select bmi_id, bmi_status
					from main.alt_bmi
			  ) bmi
		where bmi_status = p_bmi_status
    ;
 
    return v_bmi_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_bmi_id('ниже нормального веса, ( ,18.5)');
--select * from main.fn_get_bmi_id('sdft');
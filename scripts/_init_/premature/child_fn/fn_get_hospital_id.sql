--drop function if exists main.fn_get_hospital_id;
create or replace function main.fn_get_hospital_id(
											p_hospital_name main.hospital.hospital_name%type
											)
    returns main.hospital.hospital_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_hospital_id main.hospital.hospital_id%type;
 
begin
	select hospital_id, hospital_name
    	from main.hospital
    union
    select hospital_id, hospital_name
		from main.alt_hospital
    ;
 
    return v_hospital_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_hospital_id('высокие');
--select * from main.fn_get_hospital_id('sdft');
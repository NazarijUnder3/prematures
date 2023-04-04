--drop function if exists main.fn_get_gender_id;
create or replace function main.fn_get_gender_id(
											p_gender_name main.gender.gender_name%type
											)
    returns main.gender.gender_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_gender_id main.gender.gender_id%type;
 
begin
    select gender_id
        into v_gender_id
        from main.gender
        where gender_name = p_gender_name
    ;
 
    return v_gender_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_gender_id('М');
--select * from main.fn_get_gender_id('sdft');
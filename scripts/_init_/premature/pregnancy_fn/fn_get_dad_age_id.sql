--drop function if exists main.fn_get_dad_age_id;
create or replace function main.fn_get_dad_age_id(
											p_dad_age main.dad_age.dad_age%type
											)
    returns main.dad_age.dad_age_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_dad_age_id main.dad_age.dad_age_id%type;
 
begin
    select dad_age_id
        into v_dad_age_id
        from main.dad_age
        where dad_age = p_dad_age
    ;
 
    return v_dad_age_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_dad_age_id('до 40');
--select * from main.fn_get_dad_age_id('sdft');
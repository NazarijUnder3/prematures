--drop function if exists main.fn_get_hearing_id;
create or replace function main.fn_get_hearing_id(
											p_hearing_name main.hearing.hearing_name%type
											)
    returns main.hearing.hearing_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_hearing_id main.hearing.hearing_id%type;
 
begin
    select hearing_id
        into v_hearing_id
        from main.hearing
        where hearing_name = p_hearing_name
    ;
 
    return v_hearing_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_hearing_id('норма');
--select * from main.fn_get_hearing_id('sdft');
--drop function if exists main.fn_get_presentation_id;
create or replace function main.fn_get_presentation_id(
											p_presentation_name main.presentation.presentation_name%type
											)
    returns main.presentation.presentation_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_presentation_id main.presentation.presentation_id%type;
 
begin
    select presentation_id
        into v_presentation_id
        from main.presentation
        where presentation_name = p_presentation_name
    ;
 
    return v_presentation_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_presentation_id('головное');
--select * from main.fn_get_presentation_id('sdft');
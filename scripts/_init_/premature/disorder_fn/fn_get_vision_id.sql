--drop function if exists main.fn_get_vision_id;
create or replace function main.fn_get_vision_id(
											p_vision_name main.vision.vision_name%type
											)
    returns main.vision.vision_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_vision_id main.vision.vision_id%type;
 
begin
    select vision_id
        into v_vision_id
        from main.vision
        where vision_name = p_vision_name
    ;
 
    return v_vision_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_vision_id('норма');
--select * from main.fn_get_vision_id('sdft');
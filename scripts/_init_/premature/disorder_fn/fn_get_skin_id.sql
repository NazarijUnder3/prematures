--drop function if exists main.fn_get_skin_id;
create or replace function main.fn_get_skin_id(
											p_skin_name main.skin.skin_name%type
											)
    returns main.skin.skin_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_skin_id main.skin.skin_id%type;
 
begin
    select skin_id
        into v_skin_id
        from main.skin
        where skin_name = p_skin_name
    ;
 
    return v_skin_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_skin_id('норма');
--select * from main.fn_get_skin_id('sdft');
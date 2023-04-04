--drop function if exists main.fn_get_white_body_id;
create or replace function main.fn_get_white_body_id(
											p_white_body_name main.white_body.white_body_name%type
											)
    returns main.white_body.white_body_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_white_body_id main.white_body.white_body_id%type;
 
begin
    select white_body_id
        into v_white_body_id
        from main.white_body
        where white_body_name = p_white_body_name
    ;
 
    return v_white_body_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_white_body_id('нет');
--select * from main.fn_get_white_body_id('sdft');
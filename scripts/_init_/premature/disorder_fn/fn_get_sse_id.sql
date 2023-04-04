--drop function if exists main.fn_get_sse_id;
create or replace function main.fn_get_sse_id(
											p_sse_name main.sse.sse_name%type
											)
    returns main.sse.sse_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_sse_id main.sse.sse_id%type;
 
begin
    select sse_id
        into v_sse_id
        from main.sse
        where sse_name = p_sse_name
    ;
 
    return v_sse_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_sse_id('нет');
--select * from main.fn_get_sse_id('sdft');
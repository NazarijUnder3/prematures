--drop function if exists main.fn_get_status_id;
create or replace function main.fn_get_status_id(
											p_status_name main.status.status_name%type
											)
    returns main.status.status_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_status_id main.status.status_id%type;
 
begin
    select status_id
        into v_status_id
        from main.status
        where status_name = p_status_name
    ;
 
    return v_status_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_status_id('нет');
--select * from main.fn_get_status_id('sdft');
--drop function if exists main.fn_get_status_30_id;
create or replace function main.fn_get_status_30_id(
											p_status_30_name main.status_30.status_30_name%type
											)
    returns main.status_30.status_30_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_status_30_id main.status_30.status_30_id%type;
 
begin
    select status_30_id
        into v_status_30_id
        from main.status_30
        where status_30_name = p_status_30_name
    ;
 
    return v_status_30_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_status_30_id('БО');
--select * from main.fn_get_status_30_id('sdft');
--drop function if exists main.fn_get_wd_id;
create or replace function main.fn_get_wd_id(
											p_wd_name main.wd.wd_name%type
											)
    returns main.wd.wd_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_wd_id main.wd.wd_id%type;
 
begin
    select wd_id
        into v_wd_id
        from main.wd
        where wd_name = p_wd_name
    ;
 
    return v_wd_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_wd_id('да');
--select * from main.fn_get_wd_id('sdft');
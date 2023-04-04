--drop function if exists main.fn_get_ps_id;
create or replace function main.fn_get_ps_id(
											p_ps_name main.ps.ps_name%type
											)
    returns main.ps.ps_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_ps_id main.ps.ps_id%type;
 
begin
    select ps_id
        into v_ps_id
        from main.ps
        where ps_name = p_ps_name
    ;
 
    return v_ps_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_ps_id('нет');
--select * from main.fn_get_ps_id('sdft');
--drop function if exists main.fn_get_slf_id;
create or replace function main.fn_get_slf_id(
											p_slf_name main.slf.slf_name%type
											)
    returns main.slf.slf_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_slf_id main.slf.slf_id%type;
 
begin
    select slf_id
        into v_slf_id
        from main.slf
        where slf_name = p_slf_name
    ;
 
    return v_slf_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_slf_id('нет');
--select * from main.fn_get_slf_id('sdft');
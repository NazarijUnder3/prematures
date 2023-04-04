--drop function if exists main.fn_get_convulsion_id;
create or replace function main.fn_get_convulsion_id(
											p_convulsion_name main.convulsion.convulsion_name%type
											)
    returns main.convulsion.convulsion_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_convulsion_id main.convulsion.convulsion_id%type;
 
begin
    select convulsion_id
        into v_convulsion_id
        from main.convulsion
        where convulsion_name = p_convulsion_name
    ;
 
    return v_convulsion_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_convulsion_id('нет');
--select * from main.fn_get_convulsion_id('sdft');
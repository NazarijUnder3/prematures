--drop function if exists main.fn_get_ct_id;
create or replace function main.fn_get_ct_id(
											p_ct_name main.ct.ct_name%type
											)
    returns main.ct.ct_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_ct_id main.ct.ct_id%type;
 
begin
    select ct_id
        into v_ct_id
        from main.ct
        where ct_name = p_ct_name
    ;
 
    return v_ct_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_ct_id('норма');
--select * from main.fn_get_ct_id('sdft');
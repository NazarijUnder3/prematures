--drop function if exists main.fn_get_ims_id;
create or replace function main.fn_get_ims_id(
											p_ims_name main.ims.ims_name%type
											)
    returns main.ims.ims_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_ims_id main.ims.ims_id%type;
 
begin
    select ims_id
        into v_ims_id
        from main.ims
        where ims_name = p_ims_name
    ;
 
    return v_ims_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_ims_id('норма');
--select * from main.fn_get_ims_id('sdft');
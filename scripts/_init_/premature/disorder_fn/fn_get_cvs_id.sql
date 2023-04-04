--drop function if exists main.fn_get_cvs_id;
create or replace function main.fn_get_cvs_id(
											p_cvs_name main.cvs.cvs_name%type
											)
    returns main.cvs.cvs_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_cvs_id main.cvs.cvs_id%type;
 
begin
    select cvs_id
        into v_cvs_id
        from main.cvs
        where cvs_name = p_cvs_name
    ;
 
    return v_cvs_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_cvs_id('норма');
--select * from main.fn_get_cvs_id('sdft');
--drop function if exists main.fn_get_pf_id;
create or replace function main.fn_get_pf_id(
											p_pf_name main.pf.pf_name%type
											)
    returns main.pf.pf_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_pf_id main.pf.pf_id%type;
 
begin
    select pf_id
        into v_pf_id
        from main.pf
        where pf_name = p_pf_name
    ;
 
    return v_pf_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_pf_id('норма');
--select * from main.fn_get_pf_id('sdft');
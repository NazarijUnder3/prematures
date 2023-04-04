--drop function if exists main.fn_get_npt_id;
create or replace function main.fn_get_npt_id(
											p_npt_name main.npt.npt_name%type
											)
    returns main.npt.npt_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_npt_id main.npt.npt_id%type;
 
begin
    select npt_id
        into v_npt_id
        from main.npt
        where npt_name = p_npt_name
    ;
 
    return v_npt_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_npt_id('1-2 мес.');
--select * from main.fn_get_npt_id('sdft');
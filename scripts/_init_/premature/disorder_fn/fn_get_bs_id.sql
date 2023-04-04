--drop function if exists main.fn_get_bs_id;
create or replace function main.fn_get_bs_id(
											p_bs_name main.bs.bs_name%type
											)
    returns main.bs.bs_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_bs_id main.bs.bs_id%type;
 
begin
    select bs_id
        into v_bs_id
        from main.bs
        where bs_name = p_bs_name
    ;
 
    return v_bs_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_bs_id('норма');
--select * from main.fn_get_bs_id('sdft');
--drop function if exists main.fn_get_compitation_id;
create or replace function main.fn_get_compitation_id(
											p_compitation_name main.compitation.compitation_name%type
											)
    returns main.compitation.compitation_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_compitation_id main.compitation.compitation_id%type;
 
begin
    select compitation_id
        into v_compitation_id
        from main.compitation
        where compitation_name = p_compitation_name
    ;
 
    return v_compitation_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_compitation_id('НМФПК');
--select * from main.fn_get_compitation_id('sdft');
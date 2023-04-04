--drop function if exists main.fn_get_habilitation_id;
create or replace function main.fn_get_habilitation_id(
											p_habilitation_name main.habilitation.habilitation_name%type
											)
    returns main.habilitation.habilitation_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_habilitation_id main.habilitation.habilitation_id%type;
 
begin
    select habilitation_id
        into v_habilitation_id
        from main.habilitation
        where habilitation_name = p_habilitation_name
    ;
 
    return v_habilitation_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_habilitation_id('нет');
--select * from main.fn_get_habilitation_id('sdft');
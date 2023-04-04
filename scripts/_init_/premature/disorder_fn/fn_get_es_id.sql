--drop function if exists main.fn_get_es_id;
create or replace function main.fn_get_es_id(
											p_es_name main.es.es_name%type
											)
    returns main.es.es_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_es_id main.es.es_id%type;
 
begin
    select es_id
        into v_es_id
        from main.es
        where es_name = p_es_name
    ;
 
    return v_es_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_es_id('норма');
--select * from main.fn_get_es_id('sdft');
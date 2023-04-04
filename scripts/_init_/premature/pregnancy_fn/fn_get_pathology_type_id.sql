--drop function if exists main.fn_get_pathology_id;
create or replace function main.fn_get_pathology_type_id(
											p_pathology_name main.pathology_type.pathology_name%type
											)
    returns main.pathology_type.pathology_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_pathology_id main.pathology_type.pathology_id%type;
 
begin
    select pathology_id
        into v_pathology_id
        from main.pathology_type
        where pathology_name = p_pathology_name
    ;
 
    return v_pathology_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_pathology_type_id('анемия');
--select * from main.fn_get_pathology_type_id('sdft');
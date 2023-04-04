--drop function if exists main.fn_get_mkf_category_id;
create or replace function main.fn_get_mkf_code_category_id(
											p_mkf_category_name main.mkf_code_category.mkf_category_name%type
											)
    returns main.mkf_code_category.mkf_category_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_mkf_category_id main.mkf_code_category.mkf_category_id%type;
 
begin
    select mkf_category_id
        into v_mkf_category_id
        from main.mkf_code_category
        where mkf_category_name = p_mkf_category_name
    ;
 
    return v_mkf_category_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_mkf_code_category_id('b');
--select * from main.fn_get_mkf_code_category_id('sdft');
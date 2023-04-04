--drop function if exists main.fn_get_mkf_id;
create or replace function main.fn_get_mkf_code_id(
											p_mkf_name main.mkf_code.mkf_name%type
											)
    returns main.mkf_code.mkf_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_mkf_id main.mkf_code.mkf_id%type;
 
begin
    select mkf_id
        into v_mkf_id
        from main.mkf_code
        where mkf_name = p_mkf_name
    ;
 
    return v_mkf_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_mkf_code_id('высокие');
--select * from main.fn_get_mkf_code_id('sdft');
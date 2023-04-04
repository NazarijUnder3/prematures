--drop function if exists main.fn_get_delivery_id;
create or replace function main.fn_get_delivery_id(
											p_delivery_name main.delivery.delivery_name%type
											)
    returns main.delivery.delivery_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_delivery_id main.delivery.delivery_id%type;
 
begin
    select delivery_id
        into v_delivery_id
        from main.delivery
        where delivery_name = p_delivery_name
    ;
 
    return v_delivery_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_delivery_id('ЕРП');
--select * from main.fn_get_delivery_id('sdft');
--drop function if exists main.fn_get_pcr_id;
create or replace function main.fn_get_pcr_id(
											p_pcr_name main.pcr.pcr_name%type
											)
    returns main.pcr.pcr_id%type
    language 'plpgsql'
    stable --функция всегда возвращает 1 и то же
    as $function$ -- plpg разбирает то, что между такими тегами
 
declare
    v_pcr_id main.pcr.pcr_id%type; --объявление переменной
 
begin -- начало транзакции
    select pcr_id
        into v_pcr_id -- результат поместиться сюда
        from main.pcr
        where pcr_name = p_pcr_name
    ;
 
    return v_pcr_id;
end; -- окончание транзакции
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_pcr_id('отрицательный');
--select * from main.fn_get_pcr_id('sdft');
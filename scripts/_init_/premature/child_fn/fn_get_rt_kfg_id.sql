--drop function if exists main.fn_get_rt_kfg_id;
create or replace function main.fn_get_rt_kfg_id(
											p_rt_kfg_name main.rt_kfg.rt_kfg_name%type
											)
    returns main.rt_kfg.rt_kfg_id%type
    language 'plpgsql'
    stable --функция всегда возвращает 1 и то же
    as $function$ -- plpg разбирает то, что между такими тегами
 
declare
    v_rt_kfg_id main.rt_kfg.rt_kfg_id%type; --объявление переменной
 
begin -- начало транзакции
    select rt_kfg_id
        into v_rt_kfg_id -- результат поместиться сюда
        from main.rt_kfg
        where rt_kfg_name = p_rt_kfg_name
    ;
 
    return v_rt_kfg_id;
end; -- окончание транзакции
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_rt_kfg_id('нет');
--select * from main.fn_get_rt_kfg_id('sdft');
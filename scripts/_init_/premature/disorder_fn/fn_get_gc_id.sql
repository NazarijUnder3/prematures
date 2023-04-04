--drop function if exists main.fn_get_gc_id;
create or replace function main.fn_get_gc_id(
											p_gc_name main.gc.gc_name%type
											)
    returns main.gc.gc_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_gc_id main.gc.gc_id%type;
 
begin
    select gc_id
        into v_gc_id
        from main.gc
        where gc_name = p_gc_name
    ;
 
    return v_gc_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_gc_id('нет');
--select * from main.fn_get_gc_id('sdft');
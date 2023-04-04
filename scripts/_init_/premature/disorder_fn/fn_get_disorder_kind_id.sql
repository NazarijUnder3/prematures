--drop function if exists main.fn_get_disorder_kind_id;
create or replace function main.fn_get_disorder_kind_id(
											p_disorder_kind_name main.disorder_kind.disorder_kind_name%type
											)
    returns main.disorder_kind.disorder_kind_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_disorder_kind_id main.disorder_kind.disorder_kind_id%type;
 
begin
    select disorder_kind_id
        into v_disorder_kind_id
        from main.disorder_kind
        where disorder_kind_name = p_disorder_kind_name
    ;
 
    return v_disorder_kind_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_disorder_kind_id('норма');
--select * from main.fn_get_disorder_kind_id('sdft');
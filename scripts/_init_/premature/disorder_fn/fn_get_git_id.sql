--drop function if exists main.fn_get_git_id;
create or replace function main.fn_get_git_id(
											p_git_name main.git.git_name%type
											)
    returns main.git.git_id%type
    language 'plpgsql'
    stable
    as $function$
 
declare
    v_git_id main.git.git_id%type;
 
begin
    select git_id
        into v_git_id
        from main.git
        where git_name = p_git_name
    ;
 
    return v_git_id;
end;
$function$
;
 
--
-- Success
-- 
--select * from main.fn_get_git_id('норма');
--select * from main.fn_get_git_id('sdft');
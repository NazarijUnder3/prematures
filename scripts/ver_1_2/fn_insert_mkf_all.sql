create or replace function main.fn_insert_mkf_all()
    returns bigint
    language 'plpgsql'
    volatile
    as $function$
 
declare
    v_mkf record;
    v_count bigint;
    v_massive smallint[] := array [1, 3, 6, 12, 24];
    v_obs smallint;
    v_total bigint := 0;
 
begin
	for v_mkf in select mkf_name
					from mkf_code
					where active
	loop
		foreach v_obs in array v_massive 
		loop
			select cnt
				into v_count
				from fn_insert_mkf (v_mkf.mkf_name, v_obs) cnt
			;
			v_total := v_total + v_count;
raise notice 'mkf: %, obs time: %, count: %', v_mkf.mkf_name, v_obs, v_count;
		end loop;
	end loop;
	
	return v_total;
end;
$function$
;

--select fn_insert_mkf_all();
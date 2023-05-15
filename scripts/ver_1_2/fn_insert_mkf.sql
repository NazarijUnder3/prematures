create or replace function main.fn_insert_mkf(
											p_mkf_name main.mkf_code.mkf_name%type
											, p_observation_time main.mkf.observation_time%type
											)
    returns bigint
    language 'plpgsql'
    volatile
    as $function$
 
declare
    v_sql text;
    v_mkf_name text;
    v_count bigint;
 
begin
	v_mkf_name := p_mkf_name || '.' || p_observation_time;
raise notice '%', v_mkf_name;
	v_sql := format($$
					insert 
						into main.mkf
						select sd.child_id
								, fn_get_mkf_code_id (%L)
								, %s
								, trim(leading '.' from replace(%I, '%s', ''))
							from stage_data sd
							where %I is not null
								and %I <> ''
					;
					$$
					, p_mkf_name
					, p_observation_time
					, v_mkf_name
					, p_mkf_name
					, v_mkf_name
					, v_mkf_name
					);
raise notice '%', v_sql;
	execute v_sql;
	get diagnostics v_count = row_count;
	
	return v_count;
end;
$function$
;

--select * from fn_insert_mkf('b750', cast(1 as smallint)) x;
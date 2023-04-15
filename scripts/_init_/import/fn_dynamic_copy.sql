--drop function if exists main.fn_dynamic_copy;

create or replace function main.fn_dynamic_copy(p_fq_file_name text
                                        , p_temp_table_name text default 't_m_p'
                                        , p_delimeter text default e'\t'
                                        , p_no_delimeter text default chr(127)
                                        , p_encoding text default 'WIN1251'
										) -- see below!
	returns text
	language plpgsql as
$function$

declare
   v_row_count integer;
   v_tmp varchar;

begin
   -- create staging table for 1st row as  single text column
	create temp table t_m_p_0(
							 cols text
							 ) 
		on commit drop
	;
 
	-- fetch 1st row

--raise notice '%', format($$copy t_m_p_0 from program 'findstr . %s | findstr m_s110.24$' with (delimiter %L, encoding '%s')$$  -- impossible delimiter
--					, p_fq_file_name
--					, p_no_delimeter
--					, p_encoding
--					);

	execute format($$copy t_m_p_0 from program 'findstr . %s | findstr m_s110.24$' with (delimiter %L, encoding '%s')$$  -- impossible delimiter
					, p_fq_file_name
					, p_no_delimeter
					, p_encoding
					)
	;
 
	-- create actual temp table with all columns text

--select format('create table %I(', p_temp_table_name)
--					|| string_agg(quote_ident(c) || ' text', ',')
--					|| ')'
--				into v_tmp
--				from unnest(
--							string_to_array(
--											(
--											select cols
--												from t_m_p_0
--												limit 1
--											)
--											, p_delimeter
--											)
--							) c
--				where c is not null;
--raise notice '%', v_tmp;
	begin
		execute (
				select format('create table %I(', p_temp_table_name)
						|| string_agg(quote_ident(c) || ' text', ',')
						|| ')'
					from unnest(
								string_to_array(
												(
												select cols
													from t_m_p_0
													limit 1
												)
												, p_delimeter
												)
								) c
					where c is not null
	    		)
	    ;
	exception 
		when sqlstate '42P07'
			then return null;
	end;
	
	-- import data
	execute format($$copy %I from %L with (format csv, header, null '\n', delimiter %L, encoding '%s')$$
					, p_temp_table_name
					, p_fq_file_name
					, p_delimeter
					, p_encoding
					)
	;
	get diagnostics v_row_count = row_count;
	
	return format('created table %I with %s rows.', p_temp_table_name, v_row_count);
end;
$function$;

--select main.fn_dynamic_copy('G:\premature_data_final.csv', p_delimeter => ';');

--select main.fn_dynamic_copy('G:\premature_data_final.csv', 'tmp_aaa', ';');
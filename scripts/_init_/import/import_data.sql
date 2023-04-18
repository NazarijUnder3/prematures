drop table if exists main.stage_data;

--Import data
select main.fn_dynamic_copy('G:\premature_data_final_2.csv', 'stage_data', ';');




--Add column
alter table main.stage_data
	add column surname varchar
;
update stage_data
	set surname = split_part("ФИО", ' ', 1)
;
create index surname_idx 
	on main.stage_data (surname)
;



--Clean data
truncate table main.pregnancy cascade;
truncate table main.mother cascade;



--Insert mother data
insert into main.mother (mother_last_name)
	select distinct surname
		from stage_data
		order by 1
;



--Insert pregnancy data
insert into main.pregnancy (mother_id, mother_age, dad_age_id, multipregnancy_result_id, multipregnancy_id
						, status_id, bmi_id, antenatal, infertility, pregnancy_count, birth_count, delivery_id, gestation, user_id)
		select distinct m.mother_id
				, (case 
					when "СБФ.Возраст0" = '[18; 30)'
						then 25
					when "СБФ.Возраст0" = 'менее 18'
						then 16
					else cast("СБФ.Возраст0" as integer)
				end)
				, fn_get_dad_age_id("СБФ.Возраст отца")
				, fn_get_multipregnancy_result_id("Беременность.Исход многоплодности")
				, fn_get_multipregnancy_id("Беременность.Многоплодие")
				, fn_get_status_id("СБФ.Одинокая")
				, fn_get_bmi_id("СБФ.ИМТ")
				, (cast (case
							when "Антенатальные нарушения" = 'да'
								then 'yes'
							when "Антенатальные нарушения" = 'нет'
								then 'no'
						 end 
					as boolean))
				, (cast (case
							when "Бесплодие матери" = 'да'
								then 'yes'
							when "Бесплодие матери" = 'нет'
								then 'no'
					     end 
					as boolean))
				, (cast (case
							when "Беременность счет0" = '7-я'
								then 7
							when "Беременность счет0" = '5-я'
								then 5
							when "Беременность счет0" = '3-я'
								then 3
							when "Беременность счет0" = '1-я'
								then 1
							when "Беременность счет0" = '2-я'
								then 2
							when "Беременность счет0" = '4-я'
								then 4
						end 
					as smallint))
				, (cast (case
							when "Роды" = '4-е'
								then 4
							when "Роды" = '3-и'
								then 3
							when "Роды" = '2-е'
								then 2
							when "Роды" = '1-е'
								then 1
						end 
					as smallint))
				, fn_get_delivery_id("Родоразрешение")
				, cast("Гестация0" as smallint)
				, 1
				from main.stage_data sd
					inner join main.mother m on (m.mother_last_name = sd.surname)
;
--191 мать и 192 беременности, т.к. у 1 из матерей было 2 беременности в разное время
--select *
--	from pregnancy 
--	where mother_id = ANY (
--						select mother_id
--							from pregnancy
--							group by mother_id
--								having count(*) > 1
--						)
--;



--Import pathology
with 
	pathology_stage as (
		select distinct sd.surname
				, sd."Беременность счет0" 
				, p.pregnancy_id
				, sd."Беременность.Анемия"
				, sd."Беременность.МВС"
				, sd."Беременность.Энд.система0"
				, sd."Беременность.ССС0"
				, sd."Беременность.ЖКТ"
				, sd."Беременность.Курение"
				, sd."Беременность.НС0"
				, sd."Беременность.Гинекология0"
				, sd."Беременность.Угроза0"
				, sd."Беременность.ХФПН/ХВГП"
				, sd."Беременность.ИЦН"
				, sd."Беременность.Кольпит"
				, sd."Беременность.ОРВИ0"
				, sd."ИМТ"
			from main.stage_data sd
				inner join main.mother m on (m.mother_last_name = sd.surname)
				inner join main.pregnancy p on (p.mother_id = m.mother_id
													and p.pregnancy_count = cast(left(sd."Беременность счет0", 1) as smallint))
	)
	, ins_anemy as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('анемия')
					, "Беременность.Анемия"
					, 'да'
			from pathology_stage
			where "Беременность.Анемия" <> trim('нет')
	)
	, ins_mvs as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('МВС')
					, "Беременность.МВС"
					, 'да'
			from pathology_stage
			where "Беременность.МВС" <> trim('нет')
	)
	select *
		from pathology
;



--Import child data
insert into main.child (pregnancy_id, child_name, child_surname, address, height, weight, apgar0, apgar1, asphyxia
					, hospital_id, gender_id, locality_id, eco_id, convulsion0_id, convulsion7_id, sepsis_id, sepsis_ethiology_id
					, pcr_blood_id, pcr_saliva_id, rt_kfg_id, reanimation, alv, cpap, ph, surfactant, child_card
					, ir, white_body_id, reflex_id, ne, amniotic_fluid_id, fluid_id, presentation_id, compitation_id, user_id, ts)
	select ...--pregnancy_id
			, "ФИО"
			, "ФИО"
			, "Адрес"
			, (cast ("Рост" as smallint))
			, (cast ("Масса" as smallint))
			, (cast ("Апгар0" as smallint))
			, ... -- апгар1 - содержит не только цифры
			, (cast (case
						when "Асфиксия" = 'да'
							then 'yes'
						when "Асфиксия" = 'нет'
							then 'no'
					 end
				as boolean))
			, fn_get_hospital_id("Роддом") -- нужно добвить Мид в alt_haspital
			, fn_get_gender_id("Пол")
			, fn_get_locality_id-------------
			, fn_get_eco_id(trim("ЭКО0"))
			, fn_get_convulsion_id---
			, fn_get_convulsion_id--- как заполнять conv0 и conv7
			, fn_get_sepsis_id("ВУИ/сепсис")
			, fn_get_sepsis_ethiology_id("ВУИ/сепсис.Этиология")
			, fn_get_pcr_id("ПЦР кровь")
			, fn_get_pcr_id("ПЦР слюна/моча")
			, fn_get_rt_kfg_id("РТ/КФГ")
			, (cast (case
						when "Реанимационные мероприятия" = 'да'
							then 'yes'
						when "Реанимационные мероприятия" = 'нет'
							then 'no'
					 end
				as boolean))
			, cast(rtrim(rtrim("Длительность ИВЛ", '0'), ',') as smallint) -- значение 0.5
			, cast("Длительность CPAP" as smallint)
			, cast("pH" as numeric) -- нецелые значение
			, (cast (case
						when "Куросурф" = 'да'
							then 'yes'
						when "Куросурф" = 'нет'
							then 'no'
					 end
				as boolean))
			, cast("ИБ" as varchar)
			, cast("IR" as smallint) -- нецелые значения
			, fn_get_white_body_id(trim ("БВ"))
			, fn_get_reflex_id("Рефлексы")
			, (cast (case
						when "НЭ" = 'да'
							then 'yes'
						when "НЭ" = 'нет'
							then 'no'
					 end
				as boolean))
			, fn_get_amniotic_fluid_id("О/плодные воды")
			, fn_get_fluid_id("Беременность.Воды")
			, fn_get_presentation_id("Беременность.Предлежание")
			, fn_get_compitation_id("Осложнения")
			, 1
	from stage_data
;


select distinct "Роддом", fn_get_hospital_id(trim("Роддом"))
	from stage_data
;
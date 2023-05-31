drop table if exists main.stage_data cascade;

--Import data
select main.fn_dynamic_copy('G:\premature_data_final_2.csv', 'stage_data', ';');



--correct data
update main.stage_data
	set lng = replace(lng, ',', '.')
;

update main.stage_data
	set lat = replace(lat, ',', '.')
;

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
alter table main.stage_data
	add column child_id smallint
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
	, ins_end_syst as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('энд.система')
					, "Беременность.Энд.система0"
					, 'да'
			from pathology_stage
			where "Беременность.Энд.система0" <> trim('нет')
	)
	, ins_sss as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('ССС')
					, "Беременность.ССС0"
					, 'да'
			from pathology_stage
			where "Беременность.ССС0" <> trim('нет')
	)
	, ins_git as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('ЖКТ')
					, "Беременность.ЖКТ"
					, 'да'
			from pathology_stage
			where "Беременность.ЖКТ" <> trim('нет')
	)
	, ins_smoking as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('курение')
					, "Беременность.Курение"
					, 'да'
			from pathology_stage
			where "Беременность.Курение" <> trim('отрицает')
	)
	, ins_ns as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('НС')
					, "Беременность.НС0"
					, 'да'
			from pathology_stage
			where "Беременность.НС0" <> trim('нет')
	)
	, ins_gynecology as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('гинекология')
					, "Беременность.Гинекология0"
					, 'да'
			from pathology_stage
			where "Беременность.Гинекология0" <> trim('нет')
	)
	, ins_threat as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('угроза')
					, "Беременность.Угроза0"
					, 'да'
			from pathology_stage
			where "Беременность.Угроза0" <> trim('нет')
	)
	, ins_hfpn_hvgp as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('ХФПН/ХВГП')
					, "Беременность.ХФПН/ХВГП"
					, 'да'
			from pathology_stage
			where "Беременность.ХФПН/ХВГП" <> trim('нет')
	)
	, ins_icn as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('ИЦН')
					, "Беременность.ИЦН"
					, 'да'
			from pathology_stage
			where "Беременность.ИЦН" <> trim('нет')
	)
	, ins_colpitis as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('кольпит')
					, "Беременность.Кольпит"
					, 'да'
			from pathology_stage
			where "Беременность.Кольпит" <> trim('нет')
	)
	, ins_orvi as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('ОРВИ')
					, "Беременность.ОРВИ0"
					, 'да'
			from pathology_stage
			where "Беременность.ОРВИ0" <> trim('нет')
	)
	, ins_imt as (
		insert into main.pathology (pregnancy_id, pathology_id, pathology_full_name, pathology_short_name)
			select pregnancy_id
					, fn_get_pathology_type_id('ИМТ')
					, "ИМТ"
					, 'да'
			from pathology_stage
			where "ИМТ" <> trim('нет')
	)
	select *
		from pathology
;



--Import child data
insert into main.child (pregnancy_id, child_name, child_surname, address, height, weight, apgar0, apgar1_id, asphyxia
					, hospital_id, gender_id, locality_id, eco_id, convulsion0_id, convulsion7_id, sepsis_id, sepsis_ethiology_id
					, pcr_blood_id, pcr_saliva_id, rt_kfg_id, reanimation, alv, cpap, ph, surfactant, child_card
					, ir, white_body_id, reflex_id, ne, amniotic_fluid_id, fluid_id, presentation_id, compitation_id, user_id)
	select p.pregnancy_id
			, split_part("ФИО", ' ', 2)
			, surname
			, "Адрес"
			, (cast(cast(replace("Рост", ',', '.') as numeric) as smallint))
			, (cast ("Масса" as smallint))
			, (cast ("Апгар0" as smallint))
			, fn_get_apgar1_id (trim("Апгар1"))
			, (cast (case
						when "Асфиксия" = 'да'
							then 'yes'
						when "Асфиксия" = 'нет'
							then 'no'
					 end
				as boolean))
			, fn_get_hospital_id("Роддом")
			, fn_get_gender_id("Пол")
			, 0
			, fn_get_eco_id(trim("ЭКО0"))
			, fn_get_convulsion_id("Судороги0")
			, fn_get_convulsion_id(replace ("АСН7", 'да', 'АСН'))
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
			, cast (case 
					when replace("Длительность ИВЛ", ',', '.') = '0'
						then null
					else replace("Длительность ИВЛ", ',', '.')
				end
		 		as float(1))
			, cast(case 
						when "Длительность CPAP" = '0'
							then null
						else "Длительность CPAP"
					end
		 		as smallint)
			, cast(replace("pH", ',', '.') as float)
			, (cast (case
						when "Куросурф" = 'да'
							then 'yes'
						when "Куросурф" = 'нет'
							then 'no'
					 end
				as boolean))
			, cast("ИБ" as varchar)
			, cast(replace("IR", ',', '.') as float)
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
		from main.stage_data sd 
			inner join main.mother m on (m.mother_last_name = sd.surname)
			inner join main.pregnancy p on (p.mother_id = m.mother_id
												and p.pregnancy_count = cast(left(sd."Беременность счет0", 1) as smallint))
;



update main.stage_data sd
	set child_id = c.child_id
	from main.child c
	where sd."ФИО" = (c.child_surname || ' ' || c.child_name) 
		and sd."Адрес" = c.address 
;

create index child_id_idx 
	on main.stage_data (child_id)
;
--добавлено поле child_id в stage_data для упрощения работы



--Insert diagnosis
insert into main.diagnosis (child_id, diagnosis)
	select child_id
			, "Диагноз"
		from main.stage_data
;



--Insert phone
insert into main.phone (child_id, phone)
	select child_id
			, "Контакт" 
		from main.stage_data
;



--Import mkf
select fn_insert_mkf_all();



--Insert followup for 0 months
insert into main.followup (child_id, followup_time, fad, sd
							, wd_id, ps_id, coordination_id, disorder_structure, disorder_type_id)
	select child_id
			, 0
			, (cast (case
						when "Нарушение засыпания.0" = 'да'
							then 'yes'
						when "Нарушение засыпания.0" = 'нет'
							then 'no'
					 end
				as boolean))
			, (cast (case
						when "Нарушение сна.0" = 'да'
							then 'yes'
						when "Нарушение сна.0" = 'нет'
							then 'no'
					 end
				as boolean))
			, fn_get_wd_id ("Нарушение бодрствования.0")
			, fn_get_ps_id ("Нарушения.ПС.0")
			, fn_get_coordination_id ("Нарушения.Координация.0")
			, cast("Структура нарушений.0" as varchar)
			, NULL
		from main.stage_data sd
;



--Insert followup for 12 months
insert into main.followup (child_id, followup_time, strabismus, dss, disorder_structure, disorder_type_id)
	select child_id
			, 12
			, (cast (case
						when "Косоглазие.1" = 'да'
							then 'yes'
						when "Косоглазие.1" = 'нет'
							then 'no'
					 end
				as boolean))
			, (cast (case
						when "Задержка речевых навыков.1" = 'да'
							then 'yes'
						when "Задержка речевых навыков.1" = 'нет'
							then 'no'
					 end
				as boolean))
			, cast("Нарушения.1" as varchar)
			, NULL
		from main.stage_data sd
;

--Insert followup for 18 months
insert into main.followup (child_id, followup_time, disorder_structure, disorder_type_id)
	select child_id
			, 18
			, cast ("Структура нарушений.1.5" as varchar)
			, fn_get_disorder_type_id ("Нарушения.1.5")
		from main.stage_data sd
;


--Insert followup for 24 months
--косоглазие 2 сюда не загружать
insert into main.followup (child_id, followup_time, disorder_structure, disorder_type_id)
	select child_id
			, 24
			, cast ("Структура нарушений.2" as varchar)
			, fn_get_disorder_type_id ("Нарушения.2")
		from main.stage_data sd
;

--Insert followup for 36 months
insert into main.followup (child_id, followup_time, ee, disorder_type_id)
	select child_id
			, 36
			, (cast (case
						when "Избыточная возбудимость.3" = 'да'
							then 'yes'
						when "Избыточная возбудимость.3" = 'нет'
							then 'no'
					 end
				as boolean))
			, NULL
		from main.stage_data sd
;


--Insert disorder
insert into main.disorder (child_id, disability_oficial, disability_sign, physical_id, slf_id, gc_id, sse_id, rf_id, pf_id, strabismus_id, disorder_kind_id, disorder_type_id
							, ims_id, mps_id, es_id, cvs_id, vision_id, git_id, bs_id, mrt_id, skin_id, ct_id, hearing_id, user_id)
	select child_id
			, (cast (case
						when "Инвалидность ОФ" = 'да'
							then 'yes'
						when "Инвалидность ОФ" = 'нет'
							then 'no'
					 end
				as boolean))
			, (cast (case
						when "Признаки инвалидности" = 'да'
							then 'yes'
						when "Признаки инвалидности" = 'нет'
							then 'no'
					 end
				as boolean))
			, fn_get_physical_id (trim("Двигательная"))
			, fn_get_slf_id (trim("СЛФ"))
			, fn_get_gc_id (trim("ГЦ"))
			, fn_get_sse_id (trim("СС/Э"))
			, fn_get_rf_id (trim("РФ"))
			, fn_get_pf_id (trim("ПФ"))
			, fn_get_strabismus_id (trim("Косоглазие2"))
			, fn_get_disorder_kind_id (trim("ЭФ.Характер нарушений.2"))
			, fn_get_disorder_type_id (trim("Нарушения.2"))
			, fn_get_ims_id (trim("ИС"))
			, fn_get_mps_id (trim("МПС"))
			, fn_get_es_id (trim("Энд.система"))
			, fn_get_cvs_id (trim("ССС2"))
			, fn_get_vision_id (trim("ОФТ"))
			, fn_get_git_id (trim("ЖКТ"))
			, fn_get_bs_id (trim("Ортопед"))
			, fn_get_mrt_id (trim("МРТ"))
			, fn_get_skin_id (trim("Кожа, стигмы"))
			, fn_get_ct_id (trim("КТ"))
			, fn_get_hearing_id (trim("Слух"))
			, 1
		from main.stage_data sd
;



--Insert disability
insert into main.disability (child_id, breathing_syndrom_id, intracranial_id, npt_id, immersion_id, leukomalacia_id, status_30_id, habilitation_id, hemorrhage
							, breathing_failure, sei, encephalopathy, user_id)
	select child_id
			, fn_get_breathing_syndrom_id ("ДС")
			, fn_get_intracranial_id ("ВЧК0")
			, fn_get_npt_id (trim(replace("возраст начала терапии", '..', '.')))
			, fn_get_immersion_id ("Сухая иммерсия")
			, fn_get_leukomalacia_id ("ПВЛ")
			, fn_get_status_30_id (trim("30 дней"))
			, fn_get_habilitation_id ("Абилитация")
			, cast("ПВК степень" as smallint)
			, cast("ДН степень" as smallint)
			, (cast (case
						when "СЭИ" = 'да'
							then 'yes'
						when "СЭИ" = 'нет'
							then 'no'
					 end
				as boolean))
			, (cast (case
						when "ЭФПН" = 'да'
							then 'yes'
						when "ЭФПН" = 'нет'
							then 'no'
					 end
				as boolean))
			, 1
		from main.stage_data sd
;
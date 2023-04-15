--Import data
select main.fn_dynamic_copy('G:\premature_data_final_2.csv', 'stage_data', ';');

--Insert mother data
insert into mother (mother_last_name)
	select distinct split_part("ФИО", ' ', 1)
		from stage_data
		order by 1
;

--Insert pregnancy data
insert into pregnancy (mother_id, mother_age, dad_age_id, multipregnancy_result_id, multipregnancy_id, compitation_id, amniotic_fluid_id
						, fluid_id, status_id, bmi_id, antenatal, infertility, presentation_id, pregnancy_count, birth_count, delivery_id, user_id)
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
				, fn_get_compitation_id("Осложнения")
				, fn_get_amniotic_fluid_id("О/плодные воды")
				, fn_get_fluid_id("Беременность.Воды")
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
				, fn_get_presentation_id("Беременность.Предлежание")
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
				, 1
				from main.stage_data sd
					inner join main.mother m on (m.mother_last_name = split_part(sd."ФИО", ' ', 1))
;

select count (*)
	from (select distinct mother_id, dad_age_id, multipregnancy_result_id, multipregnancy_id, status_id, antenatal, infertility, pregnancy_count, birth_count, user_id from pregnancy) as t1
;

--Import child data
insert into child (pregnancy_id, child_name, child_surname, address, gestation, height, weight, apgar0, apgar1, asphyxia
					, hospital_id, gender_id, locality_id, eco_id, convulsion0_id, convulsion7_id, sepsis_id, sepsis_ethiology_id
					, pcr_blood_id, pcr_saliva_id, rt_kfg_id, reanimation, alv, cpap, ph, surfactant, child_card, user_id, ts
					, ir, white_body_id, reflex_id, ne)
	select ...--pregnancy_id
			, "ФИО"
			, "ФИО"
			, "Адрес"
			, ... -- гестация - как привести промежутки
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
			, fn_get_hospital_id("Роддом") -- как с alt таблицей делать
			, fn_get_gender_id("Пол")
			, fn_get_locality_id-------------
			, fn_get_eco_id("ЭКО")-- как с alt таблицей делать
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
			, --user_id 
			, --ts 
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
	from stage_data
;

select distinct m.mother_id
				, (case 
					when "СБФ.Возраст0" = '[18; 30)'
						then 25
					when "СБФ.Возраст0" = 'менее 18'
						then 16
					else cast("СБФ.Возраст0" as integer)
				end)
				, fn_get_dad_age_id("СБФ.Возраст отца")
				--, fn_get_multipregnancy_condition_id("Беременность.Плод по счету")
				, fn_get_multipregnancy_result_id("Беременность.Исход многоплодности")
				, fn_get_multipregnancy_id("Беременность.Многоплодие")
				, fn_get_compitation_id("Осложнения")
				, fn_get_amniotic_fluid_id("О/плодные воды")
				, fn_get_fluid_id("Беременность.Воды")
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
				, fn_get_presentation_id("Беременность.Предлежание")
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
				, 1
				from main.stage_data sd
					inner join main.mother m on (m.mother_last_name = split_part(sd."ФИО", ' ', 1))
;

select count (split_part("ФИО", ' ', 1)) - count (distinct split_part("ФИО", ' ', 1))
	from stage_data 
;
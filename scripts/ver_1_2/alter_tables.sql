--liquibase formatted sql




--changeset NP:1 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table if exists main.pregnancy 
	drop constraint if exists pregnancy_compitation_fk
;

--rollback alter table if exists main.pregnancy add constraint pregnancy_compitation_fk foreign key (compitation_id) references main.compitation (compitation_id);



--changeset NP:2 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table main.pregnancy 
	drop column if exists compitation_id
;

--rollback alter table main.pregnancy add column compitation_id smallint;



--changeset NP:3 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table main.child
	add column compitation_id smallint
;

--rollback alter table main.child drop column if exists compitation_id;



--changeset NP:4 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table if exists main.child 
	add constraint child_compitation_fk 
		foreign key (compitation_id) 
			references main.compitation (compitation_id);
;

--rollback alter table if exists main.child drop constraint if exists child_compitation_fk;



--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table apgar1
create table if not exists main.apgar1 (
    apgar1_id   smallint not null
    , apgar1_name varchar not null
);

comment on table main.apgar1 is
    'Apgar1';

alter table main.apgar1 
	add constraint apgar1_pk 
		primary key ( apgar1_id );

alter table main.apgar1 
	add constraint apgar1_apgar1_name_un 
		unique ( apgar1_name );

--rollback drop table if exists main.apgar1;



--changeset NP:6 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table if exists main.child
	rename column apgar1 to apgar1_id
;

alter table if exists main.child
	add constraint child_apgar1_fk
		foreign key (apgar1_id)
			references main.apgar1 (apgar1_id)
;

--rollback alter table if exists main.child drop constraint child_apgar1_fk;
--rollback alter table if exists main.child rename column apgar1_id to apgar1;



--changeset NP:7 labels:insert_values dbms:postgresql context:dev,qa,uat,prod
--comment: insert into table apgar1
insert into main.apgar1
	values (1, 1)
			, (2, 2)
			, (3, 3)
			, (4, 4)
			, (5, 5)
			, (6, 6)
			, (7, 7)
			, (8, 8)
			, (9, 9)
			, (10, 'CPAP')
			, (11, 'ИВЛ')
;

--rollback select 1;



--changeset NP:8 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child 
alter table if exists main.child
	alter column alv type float(1)
;

--rollback alter table if exists main.child alter column alv type smallint;



--changeset NP:9 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child 
alter table if exists main.child
	alter column ph type float
;

--rollback alter table if exists main.child alter column ph type numeric;



--changeset NP:10 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child 
alter table if exists main.child
	alter column ir type float
;

--rollback alter table if exists main.child alter column ir type smallint;



--changeset NP:11 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child 
alter table if exists main.child
	drop constraint child_alv_check
;

alter table if exists main.child
	add constraint child_alv_check
		check ((alv > 0) and (alv <= 70))
;

--rollback alter table if exists main.child drop constraint child_alv_check;
--rollback alter table main.child add constraint child_alv_check check ((alv >= 1) and (alv <= 60));



--changeset NP:12 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child 
alter table if exists main.child
	drop constraint child_apgar1_check
;

--rollback alter table if exists main.child add constraint child_apgar1_check check ((apgar1_id >= 1) AND (apgar1_id <= 11));



--changeset NP:13 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table diagnosis
alter table if exists main.diagnosis
	rename column "data" to date_ts
;

--rollback alter table if exists main.diagnosis rename column date_ts to "data";



--changeset NP:14 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table ps
update main.ps
	set ps_name = 'Спастика'
	where ps_name = 'спастика'
;

--rollback update main.ps set ps_name = 'спастика' where ps_name = 'Спастика';



--changeset NP:15 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table disorder kind
update main.disorder_kind
	set disorder_kind_name = 'РДН, нарушение сна'
	where disorder_kind_name = 'РДН, нарешуние сна'
;

--rollback update main.disorder_kind set disorder_kind_name = 'РДН, нарешуние сна' where disorder_kind_name = 'РДН, нарушение сна';



--changeset NP:16 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table ims
update main.ims
	set ims_name = 'Дисбаланс иммунологической реактивности'
	where ims_name = 'дисбаланс иммунологической реактивности'
;

update main.ims
	set ims_name = 'Вт. Иммунодефицит'
	where ims_name = 'Вт. иммунодефицит'
;

update main.ims
	set ims_name = 'ГТ, недост-ть гумор иммунитета'
	where ims_name = 'ГТ, недост-сть гумор. иммунитета'
;

--rollback update main.ims set ims_name = 'Вт. иммунодефицит' where ims_name = 'Вт. Иммунодефицит';
--rollback update main.ims set ims_name = 'дисбаланс иммунологической реактивности' where ims_name = 'Дисбаланс иммунологической реактивности';
--rollback update main.ims set ims_name = 'ГТ, недост-сть гумор. иммунитета' where ims_name = 'ГТ, недост-ть гумор иммунитета';



--changeset NP:17 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table mps
update main.mps
	set mps_name = 'МКБ: конкремент почки'
	where mps_name = 'МКБ; конкремент почки'
;

update main.mps
	set mps_name = 'Пиелоэктазия, гидроцеле'
	where mps_name = 'пиелоэктазия, гидроцеле'
;

--rollback update main.mps set mps_name = 'МКБ; конкремент почки' where mps_name = 'МКБ: конкремент почки';
--rollback update main.mps set mps_name = 'пиелоэктазия, гидроцеле' where mps_name = 'Пиелоэктазия, гидроцеле';



--changeset NP:18 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table es
update main.es
	set es_name = 'ГЩЖ, врожд гипотиреоз'
	where es_name = 'ГЩЖ, врожд.гипотиреоз'
;

update main.es
	set es_name = 'Гипоплазия тимуса'
	where es_name = 'гипоплазия тимуса'
;

update main.es
	set es_name = 'Субклинич.гипотиреоз'
	where es_name = 'субклинич.гипотиреоз'
;

update main.es
	set es_name = 'ГЩЖ, Субклинич.гипотиреоз'
	where es_name = 'ГЩЖ, субклинич.гипотиреоз'
;

--rollback update main.es set es_name = 'ГЩЖ, субклинич.гипотиреоз' where es_name = 'ГЩЖ, Субклинич.гипотиреоз';
--rollback update main.es set es_name = 'субклинич.гипотиреоз' where es_name = 'Субклинич.гипотиреоз';
--rollback update main.es set es_name = 'гипоплазия тимуса' where es_name = 'Гипоплазия тимуса';
--rollback update main.es set es_name = 'ГЩЖ, врожд.гипотиреоз' where es_name = 'ГЩЖ, врожд гипотиреоз';



--changeset NP:19 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table cvs
update main.cvs
	set cvs_name = 'ВПС. ДМПП, анемия'
	where cvs_name = 'ВПС, ДМПП, анемия'
;

update main.cvs
	set cvs_name = 'Декстракардия'
	where cvs_name = 'декстракардия'
;

update main.cvs
	set cvs_name = 'ВПС. ДМПП'
	where cvs_name = 'ВПС, ДМПП'
;

update main.cvs
	set cvs_name = 'МАРС.ДЖЛЖ'
	where cvs_name = 'МАРС, ДЖЛЖ'
;

--rollback update main.cvs set cvs_name = 'ВПС, ДМПП, анемия' where cvs_name = 'ВПС. ДМПП, анемия';
--rollback update main.cvs set cvs_name = 'декстракардия' where cvs_name = 'Декстракардия';
--rollback update main.cvs set cvs_name = 'ВПС, ДМПП' where cvs_name = 'ВПС. ДМПП';
--rollback update main.cvs set cvs_name = 'МАРС, ДЖЛЖ' where cvs_name = 'МАРС.ДЖЛЖ';



--changeset NP:20 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table vision
update main.vision
	set vision_name = 'Колобомы'
	where vision_name = 'колобомы'
;

--rollback update main.vision set vision_name = 'колобомы' where vision_name = 'Колобомы';



--changeset NP:21 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table mrt
update main.mrt
	set mrt_name = 'ПВ кистозная трансформация. РПСАП. ВМГ'
	where mrt_name = 'ПВ кистозная трансформация, РПСАП, ВМГ'
;

--rollback update main.mrt set mrt_name = 'ПВ кистозная трансформация, РПСАП, ВМГ' where mrt_name = 'ПВ кистозная трансформация. РПСАП. ВМГ';



--changeset NP:22 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table skin
update main.skin
	set skin_name = 'Вр. Папиллома шеи'
	where skin_name = 'Вр. папиллома шеи'
;

--rollback update main.skin set skin_name = 'Вр. папиллома шеи' where skin_name = 'Вр. Папиллома шеи';



--changeset NP:23 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table ct
update main.ct
	set ct_name = 'ЛМ. РПСАП. Киста ПП'
	where ct_name = 'ЛМ, РПСАП, киста ПП'
;

update main.ct
	set ct_name = 'Мультикистозная трансформация'
	where ct_name = 'мульти кистозная трансформация'
;

--rollback update main.ct set ct_name = 'ЛМ, РПСАП, киста ПП' where ct_name = 'ЛМ. РПСАП. Киста ПП';
--rollback update main.ct set ct_name = 'мульти кистозная трансформация' where ct_name = 'Мультикистозная трансформация';



--changeset NP:24 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table hearing
update main.hearing
	set hearing_name = 'Нарушение'
	where hearing_name = 'нарушение'
;

update main.hearing
	set hearing_name = 'Хр.НСТ 1 ст.справа'
	where hearing_name = 'Хр.НСТ 1 ст. справа'
;

update main.hearing
	set hearing_name = 'Хр.НСТ 4 ст.справа'
	where hearing_name = 'Хр.НСТ 4 ст. справа'
;

--rollback update main.hearing set hearing_name = 'нарушение' where hearing_name = 'Нарушение';
--rollback update main.hearing set hearing_name = 'Хр.НСТ 1 ст. справа' where hearing_name = 'Хр.НСТ 1 ст.справа';
--rollback update main.hearing set hearing_name = 'Хр.НСТ 4 ст. справа' where hearing_name = 'Хр.НСТ 4 ст.справа';



--changeset NP:25 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table mkf code
insert
	into main.mkf_code_category
	values (4, 's')
;

alter table main.mkf_code 
	add column active boolean not null default true
;

insert
	into main.mkf_code 
	values (19, 's110', 4, true)
;
	
update main.mkf_code
	set active = true
;

update main.mkf_code
	set active = false
	where mkf_name = 'b210'
		or mkf_name = 'b230'
;

--rollback delete from main.mkf_code where mkf_id = 19;
--rollback alter table main.mkf_code drop column active;
--rollback delete from main.mkf_code_category where mkf_category_name = 's';



--changeset NP:26 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table mkf
alter table main.mkf
	alter column mkf_value type char(3)
;

--rollback select 1;



--changeset NP:27 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: update table followup
alter table main.followup
	alter column wd_id drop not null
;

alter table main.followup
	alter column ps_id drop not null
;

alter table main.followup
	alter column coordination_id drop not null
;

--rollback alter table main.followup alter column wd_id set not null;
--rollback alter table main.followup alter column ps_id set not null;
--rollback alter table main.followup alter column coordination_id set not null;



--changeset NP:28 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: correct intracranial
truncate table main.intracranial cascade;

insert
	into main.intracranial
	values (1,	'нет')
		, (2,	'ПГИ в ЛПШ')
		, (3,	'ВЖК 4/ СГШ')
		, (4,	'ПВК')
;

--rollback select 1;



--changeset NP:29 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: adjust disability
alter table main.disability 
	drop column ne
;

--rollback alter table main.disability add column if not exists ne boolean null;



--changeset NP:30 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: adjust followup
alter table main.followup 
	add column disorder_type_id smallint
;

alter table main.followup 
add constraint followup_disorder_type_fk 
		foreign key (disorder_type_id) 
			references main.disorder_type (disorder_type_id)
;

insert 
	into main.disorder_type
	values (3, 'МВПР')
	on conflict 
		do nothing
;

--rollback delete from main.disorder_type where disorder_type_id = 3;
--rollback alter table main.followup drop constraint followup_disorder_type_fk;
--rollback alter table main.followup drop column disorder_type_id;



--changeset NP:31 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: adjust followup
alter table main.followup 
	drop constraint followup_followup_time_check
;

alter table main.followup 
	add constraint followup_followup_time_check
		check (followup_time = any (array[0, 12, 18, 24, 36]))
;

--rollback alter table main.followup drop constraint followup_followup_time_check;
--rollback alter table main.followup add constraint followup_followup_time_check check (((followup_time)::numeric = any (array[(0)::numeric, (1)::numeric, 1.5, (2)::numeric])));
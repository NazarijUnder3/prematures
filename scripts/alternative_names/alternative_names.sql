--liquibase formatted sql




--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.alt_hospital
create table if not exists main.alt_hospital (
    hospital_id   smallint not null
    , hospital_name varchar not null
);

comment on table main.alt_hospital is
    'Alternative list of hospitals';

alter table main.alt_hospital 
	add constraint alt_hospital_hospital_name_un 
		unique ( hospital_name);

alter table main.alt_hospital
    add constraint alt_hospital_hospital_fk 
		foreign key ( hospital_id )
			references main.hospital ( hospital_id );

-- Permissions
revoke all on main.alt_hospital from public;

--rollback drop table if exists main.alt_hospital;

--changeset NP:2 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.alt_hospital
insert 
	into main.alt_hospital
	values
		(1 ,'1')
		, (2 ,'2')
		, (4 ,'5')
		, (5 ,'6')
		, (1 ,'1 род.дом')
		, (1 ,'11 роддом')
		, (2 ,'2 (5198)')
		, (2 ,'2 род.дом')
		, (4 ,'5 РД')
		, (4 ,'5 род.дом')
		, (32 ,'ВОРД')
		, (18 ,'Гомельская обл.больница')
		, (6 ,'МиД')
		, (7 ,'МОРД')
		, (7 ,'областной')
		, (2 ,'роддом2')
	on conflict 
		do nothing
;

--rollback select 1;




--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.alt_eco
create table if not exists main.alt_eco (
    eco_id   smallint not null
	, eco_name varchar not null
);

comment on table main.alt_eco is
    'Alternative in vitro fertilization';

alter table main.alt_eco 
	add constraint alt_eco_eco_name_un 
		unique ( eco_name );

alter table main.alt_eco
    add constraint alt_eco_eco_fk 
		foreign key ( eco_id )
			references main.eco ( eco_id );

-- Permissions
revoke all on main.alt_eco from public;

--rollback drop table if exists main.alt_eco;


--changeset NP:4 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.alt_eco
insert 
	into main.alt_eco
	values
		(3, '3-я попытка, 1-ый криоперенос 05.2018 беременность не подтвердилась, 2-й криоперенос 02.2019 беременность не подтвердилась')
	on conflict 
		do nothing
;

--rollback select 1;

--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.alt_bmi
create table main.alt_bmi (
    bmi_id     smallint not null
    , bmi_status varchar not null
);

comment on table main.alt_bmi is
    'Alternative Body Mass Index';

alter table main.alt_bmi add constraint alt_bmi_bmi_status_un unique ( bmi_status );

alter table main.alt_bmi
    add constraint alt_bmi_bmi_fk foreign key ( bmi_id )
        references main.bmi ( bmi_id );

-- Permissions
revoke all on main.alt_bmi from public;

--rollback drop table if exists main.alt_bmi;


--changeset NP:6 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.alt_bmi
insert 
	into main.alt_bmi
	values
		(2, 'норма')
		, (3, 'ИМТ')
	on conflict 
		do nothing
;

--rollback select 1;
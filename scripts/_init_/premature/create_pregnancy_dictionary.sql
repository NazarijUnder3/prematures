--liquibase formatted sql



--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.bmi
create table if not exist main.bmi (
    bmi_id     smallint 
		generated by default as identity ( start with 1 ) ,
    bmi_status varchar not null
);

comment on table main.bmi is
    'Body Mass Index';

alter table main.bmi 
	add constraint bmi_pk 
		primary key ( bmi_id );

alter table main.bmi 
	add constraint bmi_bmi_status_un 
		unique ( bmi_status );

-- Permissions
revoke all on main.bmi from public;

--rollback drop table if exists main.bmi;


--changeset NP:1 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.bmi
insert 
	into main.bmi
	values
		(1, 'ниже нормального веса, ( ,18.5)')
		, (2, 'нормальный вес, [18.5,25)')
		, (3, 'избыточный вес, [25,30)')
		, (4, 'ожирение I степени, [30,35)')
		, (5, 'ожирение II степени, [35,40)')
		, (6, 'ожирение III степени, [40, )')
	on conflict 
		do nothing
;
		

--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.dad
create table main.dad (
    dad_age_id smallint not null
    , dad_age    smallint not null
);

comment on table main.dad is
    'Dad age group: less\greater or equal then 40';

alter table main.dad add constraint dad_pk primary key ( dad_age_id );

-- Permissions
revoke all on main.dad from public;

--rollback drop table if exists main.dad;


--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.mother
create table main.mother (
    mother_id         smallint not null
    , mother_first_name varchar
    , mother_last_name  varchar
);

alter table main.mother add constraint mother_pk primary key ( mother_id );

-- Permissions
revoke all on main.mother from public;

--rollback drop table if exists main.mother;


--changeset NP:4 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.delivery
create table if not exist main.delivery (
    delivery_id   smallint not null,
    delivery_name varchar not null
);

comment on table main.delivery is
    'Completion of childbirth';

alter table main.delivery 
	add constraint delivery_pk 
		primary key ( delivery_id );

alter table main.delivery 
	add constraint delivery_delivery_name_un 
		unique ( delivery_name );

-- Permissions
revoke all on main.delivery from public;

--rollback drop table if exists main.delivery;


--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.amniotic_fluid
create table if not exist main.amniotic_fluid (
    amniotic_fluid_id   smallint not null,
    amniotic_fluid_name varchar not null
);

comment on table main.amniotic_fluid is
    'Amniotic fluid';

alter table main.amniotic_fluid 
	add constraint amniotic_fluid_pk 
		primary key ( amniotic_fluid_id );

alter table main.amniotic_fluid 
	add constraint amniotic_fluid_name_un 
		unique ( amniotic_fluid_name );

-- Permissions
revoke all on main.amniotic_fluid from public;

--rollback drop table if exists main.amniotic_fluid;


--changeset NP:6 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.multipregnancy_condition
create table if not exist main.multipregnancy_condition (
    multipregnancy_condition_id smallint not null
);

comment on table main.multipregnancy_condition is
    'Child birth by count';

alter table main.multipregnancy_condition 
	add constraint multipregnancy_condition_pk 
		primary key ( multipregnancy_condition_id );

-- Permissions
revoke all on main.multipregnancy_condition from public;

--rollback drop table if exists main.multipregnancy_condition;


--changeset NP:7 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.multipregnancy_result
create table if not exist main.multipregnancy_result (
    multipregnancy_result_id   smallint not null,
    multipregnancy_result_name varchar not null
);

comment on table main.multipregnancy_result is
    'The outcome of multiple pregnancy';

alter table main.multipregnancy_result 
	add constraint multipregnancy_result_pk 
		primary key ( multipregnancy_result_id );

alter table main.multipregnancy_result 
	add constraint multipregnancy_result_name_un 
		unique ( multipregnancy_result_name );

-- Permissions
revoke all on main.multipregnancy_result from public;

--rollback drop table if exists main.multipregnancy_result;


--changeset NP:8 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.multipregnancy
create table if not exist main.multipregnancy (
    multipregnancy_id smallint not null
);

alter table main.multipregnancy 
	add constraint multipregnancy_pk 
		primary key ( multipregnancy_id );

-- Permissions
revoke all on main.multipregnancy from public;

--rollback drop table if exists main.multipregnancy;


--changeset NP:9 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.fluid
create table if not exist main.fluid (
    fluid_id   smallint not null,
    fluid_name varchar not null
);

comment on table main.fluid is
    'Water(fluid)pregnancy';

alter table main.fluid 
	add constraint fluid_pk 
		primary key ( fluid_id );

alter table main.fluid 
	add constraint fluid_fluid_name_un 
		unique ( fluid_name );

-- Permissions
revoke all on main.fluid from public;

--rollback drop table if exists main.fluid;


--changeset NP:10 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.compitation
create table if not exist main.compitation (
    compitation_id   smallint not null,
    compitation_name varchar not null
);

comment on table main.compitation is
    'Complications during childbirth';

alter table main.compitation 
	add constraint compitation_pk 
		primary key ( compitation_id );

alter table main.compitation 
	add constraint compitation_name_un 
		unique ( compitation_name );

-- Permissions
revoke all on main.compitation from public;

--rollback drop table if exists main.compitation;


--changeset NP:11 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.presentation
create table if not exist main.presentation (
    presentation_id   smallint not null,
    presentation_name varchar not null
);

comment on table main.presentation is
    'List of fetal presentations: головное, ножное, поперечное, тазовое, ягодичное';

alter table main.presentation 
	add constraint presentation_pk 
		primary key ( presentation_id );

alter table main.presentation 
	add constraint presentation_name_un 
		unique ( presentation_name );

-- Permissions
revoke all on main.presentation from public;

--rollback drop table if exists main.presentation;


--changeset NP:12 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.status
create table if not exist main.status (
    status_id   smallint not null,
    status_name varchar not null
);

comment on table main.status is
    'Is the mother lonely';

alter table main.status 
	add constraint status_pk 
		primary key ( status_id );

alter table main.status 
	add constraint status_status_name_un 
		unique ( status_name );

-- Permissions
revoke all on main.status from public;

--rollback drop table if exists main.status;


--changeset NP:13 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.pathology_type
create table if not exist main.pathology_type (
    pathology_id   smallint not null,
    pathology_name varchar not null
);

comment on table main.pathology_type is
    'List of pathologies';

alter table main.pathology_type 
	add constraint pathology_type_pk 
		primary key ( pathology_id );

alter table main.pathology_type 
	add constraint pathology_name_un 
		unique ( pathology_name );

-- Permissions
revoke all on main.pathology_type from public;

--rollback drop table if exists main.pathology_type;



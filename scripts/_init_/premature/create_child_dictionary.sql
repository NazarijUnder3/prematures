--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.pcr
create table if not exists main.pcr (
    pcr_id   smallint not null,
    pcr_name varchar not null
);

comment on table main.pcr is
    'PCR analysis';

alter table main.pcr 
	add constraint pcr_pk \r\n\t\tprimary key ( pcr_id );

alter table main.pcr 
	add constraint pcr_pcr_name_un 
		unique ( pcr_name );

-- Permissions
revoke all on main.pcr from public;

--rollback drop table if exists main.pcr;


--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.rt_kfg
create table if not exists main.rt_kfg (
    rt_kfg_id   smallint not null,
    rt_kfg_name varchar not null
);

comment on table main.rt_kfg is
    'Birth injury\cephalohematoma';

alter table main.rt_kfg 
	add constraint rt_kfg_pk \r\n\t\tprimary key ( rt_kfg_id );

alter table main.rt_kfg 
	add constraint rt_kfg_rt_kfg_name_un 
		unique ( rt_kfg_name );

-- Permissions
revoke all on main.rt_kfg from public;

--rollback drop table if exists main.rt_kfg;


--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.hospital
create table if not exists main.hospital (
    hospital_id   smallint not null,
    hospital_name varchar not null
);

comment on table main.hospital is
    'List of hospitals';

alter table main.hospital 
	add constraint hospital_pk \r\n\t\tprimary key ( hospital_id );

alter table main.hospital 
	add constraint hospital_hospital_name_un 
		unique ( hospital_name );

-- Permissions
revoke all on main.hospital from public;

--rollback drop table if exists main.hospital;


--changeset NP:4 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.reflex
create table if not exists main.reflex (
    reflex_id   smallint not null,
    reflex_name varchar not null
);

comment on table main.reflex is
    'Reflexes';

alter table main.reflex 
	add constraint reflex_pk \r\n\t\tprimary key ( reflex_id );

alter table main.reflex 
	add constraint reflex_reflex_name_un 
		unique ( reflex_name );

-- Permissions
revoke all on main.reflex from public;

--rollback drop table if exists main.reflex;


--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.white_body
create table if not exists main.white_body (
    white_body_id   smallint not null,
    white_body_name varchar not null
);

alter table main.white_body 
	add constraint white_body_pk \r\n\t\tprimary key ( white_body_id );

alter table main.white_body 
	add constraint white_body_white_body_name_un 
		unique ( white_body_name );

-- Permissions
revoke all on main.white_body from public;

--rollback drop table if exists main.white_body;


--changeset NP:6 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.locality
create table if not exists main.locality (
    locality_id          smallint not null,
    locality_name        varchar not null,
    "locality parent id" smallint not null
);

alter table main.locality 
	add constraint locality_pk \r\n\t\tprimary key ( locality_id );

alter table main.locality 
	add constraint locality_locality_name_un 
		unique ( locality_name );

alter table main.locality
    
	add constraint locality_locality_fk FOREIGN KEY ( "locality parent id" )
        REFERENCES main.locality ( locality_id );

-- Permissions
revoke all on main.locality from public;

--rollback drop table if exists main.locality;


--changeset NP:7 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.sepsis_ethiology
create table if not exists main.sepsis_ethiology (
    sepsis_ethiology_id   smallint not null,
    sepsis_ethiology_name varchar not null
);

comment on table main.sepsis_ethiology is
    'Etiology of sepsis\intrauterine (congenital) infections';

alter table main.sepsis_ethiology 
	add constraint sepsis_ethiology_pk \r\n\t\tprimary key ( sepsis_ethiology_id );

alter table main.sepsis_ethiology 
	add constraint sepsis_ethiology_name_un 
		unique ( sepsis_ethiology_name );

-- Permissions
revoke all on main.sepsis_ethiology from public;

--rollback drop table if exists main.sepsis_ethiology;


--changeset NP:8 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.convulsion
create table if not exists main.convulsion (
    convulsion_id   smallint not null,
    convulsion_name varchar not null
);

comment on table main.convulsion is
    'Convulsions';

alter table main.convulsion 
	add constraint convulsion_pk \r\n\t\tprimary key ( convulsion_id );

alter table main.convulsion 
	add constraint convulsion_convulsion_name_un 
		unique ( convulsion_name );

-- Permissions
revoke all on main.convulsion from public;

--rollback drop table if exists main.convulsion;


--changeset NP:9 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.sepsis
create table if not exists main.sepsis (
    sepsis_id   smallint not null,
    sepsis_name varchar not null
);

comment on table main.sepsis is
    'Intrauterine (congenital) infections\sepsis';

alter table main.sepsis 
	add constraint sepsis_pk \r\n\t\tprimary key ( sepsis_id );

alter table main.sepsis 
	add constraint sepsis_sepsis_name_un 
		unique ( sepsis_name );

-- Permissions
revoke all on main.sepsis from public;

--rollback drop table if exists main.sepsis;


--changeset NP:10 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.eco
create table if not exists main.eco (
    eco_id    smallint not null,
    eco_name  varchar not null,
    "comment" varchar
);

comment on table main.eco is
    'In vitro fertilization';

alter table main.eco 
	add constraint eco_pk \r\n\t\tprimary key ( eco_id );

alter table main.eco 
	add constraint eco_eco_name_un 
		unique ( eco_name );

-- Permissions
revoke all on main.eco from public;

--rollback drop table if exists main.eco;


--changeset NP:11 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.gender
create table if not exists main.gender (
    gender_id   smallint not null,
    gender_name varchar not null
);

comment on table main.gender is
    'Genders';

alter table main.gender 
	add constraint gender_pk \r\n\t\tprimary key ( gender_id );

alter table main.gender 
	add constraint gender_gender_name_un 
		unique ( gender_name );

-- Permissions
revoke all on main.gender from public;

--rollback drop table if exists main.gender;


--changeset NP:12 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.mkf_code_category
create table if not exists main.mkf_code_category (
    mkf_category_id   smallint not null,
    mkf_category_name varchar not null
);

alter table main.mkf_code_category 
	add constraint mkf_code_category_pk \r\n\t\tprimary key ( mkf_category_id );

alter table main.mkf_code_category 
	add constraint mkf_code_category_name_un 
		unique ( mkf_category_name );

-- Permissions
revoke all on main.mkf_code_category from public;

--rollback drop table if exists main.mkf_code_category;


--changeset NP:13 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.mkf_code
create table if not exists main.mkf_code (
    mkf_id          smallint not null,
    mkf_name        varchar not null,
    mkf_category_id smallint not null
);

alter table main.mkf_code 
	add constraint mkf_code_pk \r\n\t\tprimary key ( mkf_id );

alter table main.mkf_code 
	add constraint mkf_code_mkf_name_un 
		unique ( mkf_name );

alter table main.mkf_code
    
	add constraint mkf_code_mkf_code_category_fk FOREIGN KEY ( mkf_category_id )
        REFERENCES main.mkf_code_category ( mkf_category_id )
            ON DELETE CASCADE;

-- Permissions
revoke all on main.mkf_code from public;

--rollback drop table if exists main.mkf_code;
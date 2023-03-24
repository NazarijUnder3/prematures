--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.pcr
CREATE TABLE main.pcr (
    pcr_id   SMALLINT NOT NULL,
    pcr_name varchar NOT NULL
);

COMMENT ON TABLE main.pcr IS
    'PCR analysis';

ALTER TABLE main.pcr ADD CONSTRAINT pcr_pk PRIMARY KEY ( pcr_id );

ALTER TABLE main.pcr ADD CONSTRAINT pcr_pcr_name_un UNIQUE ( pcr_name );

-- Permissions
revoke all on main.pcr from public;

--rollback drop table if exists main.pcr;


--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.rt_kfg
CREATE TABLE main.rt_kfg (
    rt_kfg_id   SMALLINT NOT NULL,
    rt_kfg_name varchar NOT NULL
);

COMMENT ON TABLE main.rt_kfg IS
    'Birth injury\cephalohematoma';

ALTER TABLE main.rt_kfg ADD CONSTRAINT rt_kfg_pk PRIMARY KEY ( rt_kfg_id );

ALTER TABLE main.rt_kfg ADD CONSTRAINT rt_kfg_rt_kfg_name_un UNIQUE ( rt_kfg_name );

-- Permissions
revoke all on main.rt_kfg from public;

--rollback drop table if exists main.rt_kfg;


--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.hospital
CREATE TABLE main.hospital (
    hospital_id   SMALLINT NOT NULL,
    hospital_name varchar NOT NULL
);

COMMENT ON TABLE main.hospital IS
    'List of hospitals';

ALTER TABLE main.hospital ADD CONSTRAINT hospital_pk PRIMARY KEY ( hospital_id );

ALTER TABLE main.hospital ADD CONSTRAINT hospital_hospital_name_un UNIQUE ( hospital_name );

-- Permissions
revoke all on main.hospital from public;

--rollback drop table if exists main.hospital;


--changeset NP:4 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.reflex
CREATE TABLE main.reflex (
    reflex_id   SMALLINT NOT NULL,
    reflex_name varchar NOT NULL
);

COMMENT ON TABLE main.reflex IS
    'Reflexes';

ALTER TABLE main.reflex ADD CONSTRAINT reflex_pk PRIMARY KEY ( reflex_id );

ALTER TABLE main.reflex ADD CONSTRAINT reflex_reflex_name_un UNIQUE ( reflex_name );

-- Permissions
revoke all on main.reflex from public;

--rollback drop table if exists main.reflex;


--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.white_body
CREATE TABLE main.white_body (
    white_body_id   SMALLINT NOT NULL,
    white_body_name varchar NOT NULL
);

ALTER TABLE main.white_body ADD CONSTRAINT white_body_pk PRIMARY KEY ( white_body_id );

ALTER TABLE main.white_body ADD CONSTRAINT white_body_white_body_name_un UNIQUE ( white_body_name );

-- Permissions
revoke all on main.white_body from public;

--rollback drop table if exists main.white_body;


--changeset NP:6 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.locality
CREATE TABLE main.locality (
    locality_id          SMALLINT NOT NULL,
    locality_name        varchar NOT NULL,
    "locality parent id" SMALLINT NOT NULL
);

ALTER TABLE main.locality ADD CONSTRAINT locality_pk PRIMARY KEY ( locality_id );

ALTER TABLE main.locality ADD CONSTRAINT locality_locality_name_un UNIQUE ( locality_name );

ALTER TABLE main.locality
    ADD CONSTRAINT locality_locality_fk FOREIGN KEY ( "locality parent id" )
        REFERENCES main.locality ( locality_id );

-- Permissions
revoke all on main.locality from public;

--rollback drop table if exists main.locality;


--changeset NP:7 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.sepsis_ethiology
CREATE TABLE main.sepsis_ethiology (
    sepsis_ethiology_id   SMALLINT NOT NULL,
    sepsis_ethiology_name varchar NOT NULL
);

COMMENT ON TABLE main.sepsis_ethiology IS
    'Etiology of sepsis\intrauterine (congenital) infections';

ALTER TABLE main.sepsis_ethiology ADD CONSTRAINT sepsis_ethiology_pk PRIMARY KEY ( sepsis_ethiology_id );

ALTER TABLE main.sepsis_ethiology ADD CONSTRAINT sepsis_ethiology_name_un UNIQUE ( sepsis_ethiology_name );

-- Permissions
revoke all on main.sepsis_ethiology from public;

--rollback drop table if exists main.sepsis_ethiology;


--changeset NP:8 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.convulsion
CREATE TABLE main.convulsion (
    convulsion_id   SMALLINT NOT NULL,
    convulsion_name varchar NOT NULL
);

COMMENT ON TABLE main.convulsion IS
    'Convulsions';

ALTER TABLE main.convulsion ADD CONSTRAINT convulsion_pk PRIMARY KEY ( convulsion_id );

ALTER TABLE main.convulsion ADD CONSTRAINT convulsion_convulsion_name_un UNIQUE ( convulsion_name );

-- Permissions
revoke all on main.convulsion from public;

--rollback drop table if exists main.convulsion;


--changeset NP:9 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.sepsis
CREATE TABLE main.sepsis (
    sepsis_id   SMALLINT NOT NULL,
    sepsis_name varchar NOT NULL
);

COMMENT ON TABLE main.sepsis IS
    'Intrauterine (congenital) infections\sepsis';

ALTER TABLE main.sepsis ADD CONSTRAINT sepsis_pk PRIMARY KEY ( sepsis_id );

ALTER TABLE main.sepsis ADD CONSTRAINT sepsis_sepsis_name_un UNIQUE ( sepsis_name );

-- Permissions
revoke all on main.sepsis from public;

--rollback drop table if exists main.sepsis;


--changeset NP:10 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.eco
CREATE TABLE main.eco (
    eco_id    SMALLINT NOT NULL,
    eco_name  varchar NOT NULL,
    "comment" varchar
);

COMMENT ON TABLE main.eco IS
    'In vitro fertilization';

ALTER TABLE main.eco ADD CONSTRAINT eco_pk PRIMARY KEY ( eco_id );

ALTER TABLE main.eco ADD CONSTRAINT eco_eco_name_un UNIQUE ( eco_name );

-- Permissions
revoke all on main.eco from public;

--rollback drop table if exists main.eco;


--changeset NP:11 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.gender
CREATE TABLE main.gender (
    gender_id   SMALLINT NOT NULL,
    gender_name varchar NOT NULL
);

COMMENT ON TABLE main.gender IS
    'Genders';

ALTER TABLE main.gender ADD CONSTRAINT gender_pk PRIMARY KEY ( gender_id );

ALTER TABLE main.gender ADD CONSTRAINT gender_gender_name_un UNIQUE ( gender_name );

-- Permissions
revoke all on main.gender from public;

--rollback drop table if exists main.gender;


--changeset NP:12 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.mkf_code_category
CREATE TABLE main.mkf_code_category (
    mkf_category_id   SMALLINT NOT NULL,
    mkf_category_name varchar NOT NULL
);

ALTER TABLE main.mkf_code_category ADD CONSTRAINT mkf_code_category_pk PRIMARY KEY ( mkf_category_id );

ALTER TABLE main.mkf_code_category ADD CONSTRAINT mkf_code_category_name_un UNIQUE ( mkf_category_name );

-- Permissions
revoke all on main.mkf_code_category from public;

--rollback drop table if exists main.mkf_code_category;


--changeset NP:13 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.mkf_code
CREATE TABLE main.mkf_code (
    mkf_id          SMALLINT NOT NULL,
    mkf_name        varchar NOT NULL,
    mkf_category_id SMALLINT NOT NULL
);

ALTER TABLE main.mkf_code ADD CONSTRAINT mkf_code_pk PRIMARY KEY ( mkf_id );

ALTER TABLE main.mkf_code ADD CONSTRAINT mkf_code_mkf_name_un UNIQUE ( mkf_name );

ALTER TABLE main.mkf_code
    ADD CONSTRAINT mkf_code_mkf_code_category_fk FOREIGN KEY ( mkf_category_id )
        REFERENCES main.mkf_code_category ( mkf_category_id )
            ON DELETE CASCADE;

-- Permissions
revoke all on main.mkf_code from public;

--rollback drop table if exists main.mkf_code;
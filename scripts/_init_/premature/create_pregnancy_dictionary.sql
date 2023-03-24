--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.bmi
CREATE TABLE main.bmi (
    bmi_id     SMALLINT NOT NULL,
    bmi_status varchar NOT NULL
);

COMMENT ON TABLE main.bmi IS
    'Body Mass Index';

ALTER TABLE main.bmi ADD CONSTRAINT bmi_pk PRIMARY KEY ( bmi_id );

ALTER TABLE main.bmi ADD CONSTRAINT bmi_bmi_status_un UNIQUE ( bmi_status );

-- Permissions
revoke all on main.bmi from public;

--rollback drop table if exists main.bmi;


--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.dad
CREATE TABLE main.dad (
    dad_age SMALLINT NOT NULL
);

-- Permissions
revoke all on main.dad from public;

--rollback drop table if exists main.dad;


--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.mother
CREATE TABLE main.mother (
    mother_id SMALLINT NOT NULL
);

ALTER TABLE main.mother ADD CONSTRAINT mother_pk PRIMARY KEY ( mother_id );

-- Permissions
revoke all on main.mother from public;

--rollback drop table if exists main.mother;


--changeset NP:4 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.delivery
CREATE TABLE main.delivery (
    delivery_id   SMALLINT NOT NULL,
    delivery_name varchar NOT NULL
);

COMMENT ON TABLE main.delivery IS
    'Completion of childbirth';

ALTER TABLE main.delivery ADD CONSTRAINT delivery_pk PRIMARY KEY ( delivery_id );

ALTER TABLE main.delivery ADD CONSTRAINT delivery_delivery_name_un UNIQUE ( delivery_name );

-- Permissions
revoke all on main.delivery from public;

--rollback drop table if exists main.delivery;


--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.amniotic_fluid
CREATE TABLE main.amniotic_fluid (
    amniotic_fluid_id   SMALLINT NOT NULL,
    amniotic_fluid_name varchar NOT NULL
);

COMMENT ON TABLE main.amniotic_fluid IS
    'Amniotic fluid';

ALTER TABLE main.amniotic_fluid ADD CONSTRAINT amniotic_fluid_pk PRIMARY KEY ( amniotic_fluid_id );

ALTER TABLE main.amniotic_fluid ADD CONSTRAINT amniotic_fluid_name_un UNIQUE ( amniotic_fluid_name );

-- Permissions
revoke all on main.amniotic_fluid from public;

--rollback drop table if exists main.amniotic_fluid;


--changeset NP:6 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.multipregnancy_condition
CREATE TABLE main.multipregnancy_condition (
    multipregnancy_condition_id SMALLINT NOT NULL
);

COMMENT ON TABLE main.multipregnancy_condition IS
    'Child birth by count';

ALTER TABLE main.multipregnancy_condition ADD CONSTRAINT multipregnancy_condition_pk PRIMARY KEY ( multipregnancy_condition_id );

-- Permissions
revoke all on main.multipregnancy_condition from public;

--rollback drop table if exists main.multipregnancy_condition;


--changeset NP:7 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.multipregnancy_result
CREATE TABLE main.multipregnancy_result (
    multipregnancy_result_id   SMALLINT NOT NULL,
    multipregnancy_result_name varchar NOT NULL
);

COMMENT ON TABLE main.multipregnancy_result IS
    'The outcome of multiple pregnancy';

ALTER TABLE main.multipregnancy_result ADD CONSTRAINT multipregnancy_result_pk PRIMARY KEY ( multipregnancy_result_id );

ALTER TABLE main.multipregnancy_result ADD CONSTRAINT multipregnancy_result_name_un UNIQUE ( multipregnancy_result_name );

-- Permissions
revoke all on main.multipregnancy_result from public;

--rollback drop table if exists main.multipregnancy_result;


--changeset NP:8 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.multipregnancy
CREATE TABLE main.multipregnancy (
    multipregnancy_id SMALLINT NOT NULL
);

ALTER TABLE main.multipregnancy ADD CONSTRAINT multipregnancy_pk PRIMARY KEY ( multipregnancy_id );

-- Permissions
revoke all on main.multipregnancy from public;

--rollback drop table if exists main.multipregnancy;


--changeset NP:9 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.fluid
CREATE TABLE main.fluid (
    fluid_id   SMALLINT NOT NULL,
    fluid_name varchar NOT NULL
);

COMMENT ON TABLE main.fluid IS
    'Water(fluid)pregnancy';

ALTER TABLE main.fluid ADD CONSTRAINT fluid_pk PRIMARY KEY ( fluid_id );

ALTER TABLE main.fluid ADD CONSTRAINT fluid_fluid_name_un UNIQUE ( fluid_name );

-- Permissions
revoke all on main.fluid from public;

--rollback drop table if exists main.fluid;


--changeset NP:10 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.compitation
CREATE TABLE main.compitation (
    compitation_id   SMALLINT NOT NULL,
    compitation_name varchar NOT NULL
);

COMMENT ON TABLE main.compitation IS
    'Complications during childbirth';

ALTER TABLE main.compitation ADD CONSTRAINT compitation_pk PRIMARY KEY ( compitation_id );

ALTER TABLE main.compitation ADD CONSTRAINT compitation_name_un UNIQUE ( compitation_name );

-- Permissions
revoke all on main.compitation from public;

--rollback drop table if exists main.compitation;


--changeset NP:11 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.presentation
CREATE TABLE main.presentation (
    presentation_id   SMALLINT NOT NULL,
    presentation_name varchar NOT NULL
);

COMMENT ON TABLE main.presentation IS
    'List of fetal presentations: головное, ножное, поперечное, тазовое, ягодичное';

ALTER TABLE main.presentation ADD CONSTRAINT presentation_pk PRIMARY KEY ( presentation_id );

ALTER TABLE main.presentation ADD CONSTRAINT presentation_name_un UNIQUE ( presentation_name );

-- Permissions
revoke all on main.presentation from public;

--rollback drop table if exists main.presentation;


--changeset NP:12 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.status
CREATE TABLE main.status (
    status_id   SMALLINT NOT NULL,
    status_name varchar NOT NULL
);

COMMENT ON TABLE main.status IS
    'Is the mother lonely';

ALTER TABLE main.status ADD CONSTRAINT status_pk PRIMARY KEY ( status_id );

ALTER TABLE main.status ADD CONSTRAINT status_status_name_un UNIQUE ( status_name );

-- Permissions
revoke all on main.status from public;

--rollback drop table if exists main.status;


--changeset NP:13 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.pathology_type
CREATE TABLE main.pathology_type (
    pathology_id   SMALLINT NOT NULL,
    pathology_name varchar NOT NULL
);

COMMENT ON TABLE main.pathology_type IS
    'List of pathologies';

ALTER TABLE main.pathology_type ADD CONSTRAINT pathology_type_pk PRIMARY KEY ( pathology_id );

ALTER TABLE main.pathology_type ADD CONSTRAINT pathology_name_un UNIQUE ( pathology_name );

-- Permissions
revoke all on main.pathology_type from public;

--rollback drop table if exists main.pathology_type;



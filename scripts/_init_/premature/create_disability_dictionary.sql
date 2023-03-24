--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.leukomalacia
CREATE TABLE main.leukomalacia (
    leukomalacia_id   SMALLINT NOT NULL,
    leukomalacia_name varchar NOT NULL
);

COMMENT ON TABLE main.leukomalacia IS
    'Periventricular leukomalacia';

ALTER TABLE main.leukomalacia ADD CONSTRAINT leukomalacia_pk PRIMARY KEY ( leukomalacia_id );

ALTER TABLE main.leukomalacia ADD CONSTRAINT leukomalacia_name_un UNIQUE ( leukomalacia_name );

-- Permissions
revoke all on main.leukomalacia from public;

--rollback drop table if exists main.leukomalacia;


--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.hemorrhage
CREATE TABLE main.hemorrhage (
    hemorrhage_id   SMALLINT NOT NULL,
    hemorrhage_name varchar NOT NULL
);

COMMENT ON TABLE main.hemorrhage IS
    'Paraventicular hemorrhage';

ALTER TABLE main.hemorrhage ADD CONSTRAINT hemorrhage_pk PRIMARY KEY ( hemorrhage_id );

ALTER TABLE main.hemorrhage ADD CONSTRAINT hemorrhage_hemorrhage_name_un UNIQUE ( hemorrhage_name );

-- Permissions
revoke all on main.hemorrhage from public;

--rollback drop table if exists main.hemorrhage;


--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.habilitation
CREATE TABLE main.habilitation (
    habilitation_id   SMALLINT NOT NULL,
    habilitation_name varchar NOT NULL
);

COMMENT ON TABLE main.habilitation IS
    'Habilitation';

ALTER TABLE main.habilitation ADD CONSTRAINT habilitation_pk PRIMARY KEY ( habilitation_id );

ALTER TABLE main.habilitation ADD CONSTRAINT habilitation_name_un UNIQUE ( habilitation_name );

-- Permissions
revoke all on main.habilitation from public;

--rollback drop table if exists main.habilitation;


--changeset NP:4 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.breathing_syndrom
CREATE TABLE main.breathing_syndrom (
    breathing_syndrom_id   SMALLINT NOT NULL,
    breathing_syndrom_name varchar NOT NULL
);

COMMENT ON TABLE main.breathing_syndrom IS
    'Breathing syndrom';

ALTER TABLE main.breathing_syndrom ADD CONSTRAINT breathing_syndrom_pk PRIMARY KEY ( breathing_syndrom_id );

ALTER TABLE main.breathing_syndrom ADD CONSTRAINT breathing_syndrom_name_un UNIQUE ( breathing_syndrom_name );

-- Permissions
revoke all on main.breathing_syndrom from public;

--rollback drop table if exists main.breathing_syndrom;


--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.breathing_failure
CREATE TABLE main.breathing_failure (
    breathing_failure_id   SMALLINT NOT NULL,
    breathing_failure_name varchar NOT NULL
);

COMMENT ON TABLE main.breathing_failure IS
    'Respiratory disorders';

ALTER TABLE main.breathing_failure ADD CONSTRAINT breathing_failure_pk PRIMARY KEY ( breathing_failure_id );

ALTER TABLE main.breathing_failure ADD CONSTRAINT breathing_failure_name_un UNIQUE ( breathing_failure_name );

-- Permissions
revoke all on main.breathing_failure from public;

--rollback drop table if exists main.breathing_failure;


--changeset NP:6 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.intracranial
CREATE TABLE main.intracranial (
    intracranial_id   SMALLINT NOT NULL,
    intracranial_name varchar NOT NULL
);

COMMENT ON TABLE main.intracranial IS
    'Intracranial hemorrhage';

ALTER TABLE main.intracranial ADD CONSTRAINT intracranial_pk PRIMARY KEY ( intracranial_id );

ALTER TABLE main.intracranial ADD CONSTRAINT intracranial_name_un UNIQUE ( intracranial_name );

-- Permissions
revoke all on main.intracranial from public;

--rollback drop table if exists main.intracranial;


--changeset NP:7 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.npt
CREATE TABLE main.npt (
    npt_id   SMALLINT NOT NULL,
    npt_name varchar NOT NULL
);

COMMENT ON TABLE main.npt IS
    'Neuro protective therapy begining';

ALTER TABLE main.npt ADD CONSTRAINT npt_pk PRIMARY KEY ( npt_id );

ALTER TABLE main.npt ADD CONSTRAINT npt_npt_name_un UNIQUE ( npt_name );

-- Permissions
revoke all on main.npt from public;

--rollback drop table if exists main.npt;


--changeset NP:8 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.status_30
CREATE TABLE main.status_30 (
    status_30_id   SMALLINT NOT NULL,
    status_30_name varchar NOT NULL
);

COMMENT ON TABLE main.status_30 IS
    'Status after 30 days';

ALTER TABLE main.status_30 ADD CONSTRAINT status_30_pk PRIMARY KEY ( status_30_id );

ALTER TABLE main.status_30 ADD CONSTRAINT status_30_status_30_name_un UNIQUE ( status_30_name );

-- Permissions
revoke all on main.status_30 from public;

--rollback drop table if exists main.status_30;


--changeset NP:9 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.immersion
CREATE TABLE main.immersion (
    immersion_id   SMALLINT NOT NULL,
    immersion_name varchar NOT NULL
);

COMMENT ON TABLE main.immersion IS
    'Dry immersion';

ALTER TABLE main.immersion ADD CONSTRAINT immersion_pk PRIMARY KEY ( immersion_id );

ALTER TABLE main.immersion ADD CONSTRAINT immersion_immersion_name_un UNIQUE ( immersion_name );

-- Permissions
revoke all on main.immersion from public;

--rollback drop table if exists main.immersion;
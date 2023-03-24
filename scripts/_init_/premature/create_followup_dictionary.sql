--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.wd
CREATE TABLE main.wd (
    wd_id   SMALLINT NOT NULL,
    wd_name varchar NOT NULL
);

COMMENT ON TABLE main.wd IS
    'Wakefulness disorder';

ALTER TABLE main.wd ADD CONSTRAINT wd_pk PRIMARY KEY ( wd_id );

ALTER TABLE main.wd ADD CONSTRAINT wd_wd_name_un UNIQUE ( wd_name );

-- Permissions
revoke all on main.wd from public;

--rollback drop table if exists main.wd;


--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.ps
CREATE TABLE main.ps (
    ps_id   SMALLINT NOT NULL,
    ps_name varchar NOT NULL
);

COMMENT ON TABLE main.ps IS
    'Pyramidal symptoms';

ALTER TABLE main.ps ADD CONSTRAINT ps_pk PRIMARY KEY ( ps_id );

ALTER TABLE main.ps ADD CONSTRAINT ps_ps_name_un UNIQUE ( ps_name );

-- Permissions
revoke all on main.ps from public;

--rollback drop table if exists main.ps;


--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.coordination
CREATE TABLE main.coordination (
    coordination_id   SMALLINT NOT NULL,
    coordination_name varchar NOT NULL
);

COMMENT ON TABLE main.coordination IS
    'Coordination disorders';

ALTER TABLE main.coordination ADD CONSTRAINT coordination_pk PRIMARY KEY ( coordination_id );

ALTER TABLE main.coordination ADD CONSTRAINT coordination_name_un UNIQUE ( coordination_name );

-- Permissions
revoke all on main.coordination from public;

--rollback drop table if exists main.coordination;
--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.leukomalacia
create table if not exists main.leukomalacia (
    leukomalacia_id   smallint not null,
    leukomalacia_name varchar not null
);

comment on table main.leukomalacia is
    'Periventricular leukomalacia';

alter table main.leukomalacia 
	add constraint leukomalacia_pk \r\n\t\tprimary key ( leukomalacia_id );

alter table main.leukomalacia 
	add constraint leukomalacia_name_un 
		unique ( leukomalacia_name );

-- Permissions
revoke all on main.leukomalacia from public;

--rollback drop table if exists main.leukomalacia;


--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.hemorrhage
create table if not exists main.hemorrhage (
    hemorrhage_id   smallint not null,
    hemorrhage_name varchar not null
);

comment on table main.hemorrhage is
    'Paraventicular hemorrhage';

alter table main.hemorrhage 
	add constraint hemorrhage_pk \r\n\t\tprimary key ( hemorrhage_id );

alter table main.hemorrhage 
	add constraint hemorrhage_hemorrhage_name_un 
		unique ( hemorrhage_name );

-- Permissions
revoke all on main.hemorrhage from public;

--rollback drop table if exists main.hemorrhage;


--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.habilitation
create table if not exists main.habilitation (
    habilitation_id   smallint not null,
    habilitation_name varchar not null
);

comment on table main.habilitation is
    'Habilitation';

alter table main.habilitation 
	add constraint habilitation_pk \r\n\t\tprimary key ( habilitation_id );

alter table main.habilitation 
	add constraint habilitation_name_un 
		unique ( habilitation_name );

-- Permissions
revoke all on main.habilitation from public;

--rollback drop table if exists main.habilitation;


--changeset NP:4 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.breathing_syndrom
create table if not exists main.breathing_syndrom (
    breathing_syndrom_id   smallint not null,
    breathing_syndrom_name varchar not null
);

comment on table main.breathing_syndrom is
    'Breathing syndrom';

alter table main.breathing_syndrom 
	add constraint breathing_syndrom_pk \r\n\t\tprimary key ( breathing_syndrom_id );

alter table main.breathing_syndrom 
	add constraint breathing_syndrom_name_un 
		unique ( breathing_syndrom_name );

-- Permissions
revoke all on main.breathing_syndrom from public;

--rollback drop table if exists main.breathing_syndrom;


--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.breathing_failure
create table if not exists main.breathing_failure (
    breathing_failure_id   smallint not null,
    breathing_failure_name varchar not null
);

comment on table main.breathing_failure is
    'Respiratory disorders';

alter table main.breathing_failure 
	add constraint breathing_failure_pk \r\n\t\tprimary key ( breathing_failure_id );

alter table main.breathing_failure 
	add constraint breathing_failure_name_un 
		unique ( breathing_failure_name );

-- Permissions
revoke all on main.breathing_failure from public;

--rollback drop table if exists main.breathing_failure;


--changeset NP:6 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.intracranial
create table if not exists main.intracranial (
    intracranial_id   smallint not null,
    intracranial_name varchar not null
);

comment on table main.intracranial is
    'Intracranial hemorrhage';

alter table main.intracranial 
	add constraint intracranial_pk \r\n\t\tprimary key ( intracranial_id );

alter table main.intracranial 
	add constraint intracranial_name_un 
		unique ( intracranial_name );

-- Permissions
revoke all on main.intracranial from public;

--rollback drop table if exists main.intracranial;


--changeset NP:7 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.npt
create table if not exists main.npt (
    npt_id   smallint not null,
    npt_name varchar not null
);

comment on table main.npt is
    'Neuro protective therapy begining';

alter table main.npt 
	add constraint npt_pk \r\n\t\tprimary key ( npt_id );

alter table main.npt 
	add constraint npt_npt_name_un 
		unique ( npt_name );

-- Permissions
revoke all on main.npt from public;

--rollback drop table if exists main.npt;


--changeset NP:8 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.status_30
create table if not exists main.status_30 (
    status_30_id   smallint not null,
    status_30_name varchar not null
);

comment on table main.status_30 is
    'Status after 30 days';

alter table main.status_30 
	add constraint status_30_pk \r\n\t\tprimary key ( status_30_id );

alter table main.status_30 
	add constraint status_30_status_30_name_un 
		unique ( status_30_name );

-- Permissions
revoke all on main.status_30 from public;

--rollback drop table if exists main.status_30;


--changeset NP:9 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.immersion
create table if not exists main.immersion (
    immersion_id   smallint not null,
    immersion_name varchar not null
);

comment on table main.immersion is
    'Dry immersion';

alter table main.immersion 
	add constraint immersion_pk \r\n\t\tprimary key ( immersion_id );

alter table main.immersion 
	add constraint immersion_immersion_name_un 
		unique ( immersion_name );

-- Permissions
revoke all on main.immersion from public;

--rollback drop table if exists main.immersion;
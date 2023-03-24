--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.wd
create table if not exists main.wd (
    wd_id   smallint not null,
    wd_name varchar not null
);

comment on table main.wd is
    'Wakefulness disorder';

alter table main.wd 
	add constraint wd_pk \r\n\t\tprimary key ( wd_id );

alter table main.wd 
	add constraint wd_wd_name_un 
		unique ( wd_name );

-- Permissions
revoke all on main.wd from public;

--rollback drop table if exists main.wd;


--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.ps
create table if not exists main.ps (
    ps_id   smallint not null,
    ps_name varchar not null
);

comment on table main.ps is
    'Pyramidal symptoms';

alter table main.ps 
	add constraint ps_pk \r\n\t\tprimary key ( ps_id );

alter table main.ps 
	add constraint ps_ps_name_un 
		unique ( ps_name );

-- Permissions
revoke all on main.ps from public;

--rollback drop table if exists main.ps;


--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.coordination
create table if not exists main.coordination (
    coordination_id   smallint not null,
    coordination_name varchar not null
);

comment on table main.coordination is
    'Coordination disorders';

alter table main.coordination 
	add constraint coordination_pk \r\n\t\tprimary key ( coordination_id );

alter table main.coordination 
	add constraint coordination_name_un 
		unique ( coordination_name );

-- Permissions
revoke all on main.coordination from public;

--rollback drop table if exists main.coordination;
--liquibase formatted sql



--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.wd
create table if not exists main.wd (
    wd_id   smallint not null,
    wd_name varchar not null
);

comment on table main.wd is
    'Wakefulness disorder';

alter table main.wd 
	add constraint wd_pk 
		primary key ( wd_id );

alter table main.wd 
	add constraint wd_wd_name_un 
		unique ( wd_name );

-- Permissions
revoke all on main.wd from public;

--rollback drop table if exists main.wd;


--changeset NP:2 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.wd
insert 
	into main.wd
	values
		(1, 'да')
		, (2, 'нет')
		, (3, 'РДН')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.ps
create table if not exists main.ps (
    ps_id   smallint not null,
    ps_name varchar not null
);

comment on table main.ps is
    'Pyramidal symptoms';

alter table main.ps 
	add constraint ps_pk
		primary key ( ps_id );

alter table main.ps 
	add constraint ps_ps_name_un 
		unique ( ps_name );

-- Permissions
revoke all on main.ps from public;

--rollback drop table if exists main.ps;


--changeset NP:4 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.ps
insert 
	into main.ps
	values
		(1, 'нет')
		, (2, 'ПС')
		, (3, 'спастика')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.coordination
create table if not exists main.coordination (
    coordination_id   smallint not null
    , coordination_name varchar
);

comment on table main.coordination is
    'Coordination disorders';

alter table main.coordination add constraint coordination_pk
		primary key ( coordination_id );

alter table main.coordination add constraint coordination_coordination_name_un 
		unique ( coordination_name );

-- Permissions
revoke all on main.coordination from public;

--rollback drop table if exists main.coordination;


--changeset NP:6 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.coordination
insert 
	into main.coordination
	values
		(1, 'да')
		, (2, 'ЗФКФ')
	on conflict 
		do nothing
;

--rollback select 1;
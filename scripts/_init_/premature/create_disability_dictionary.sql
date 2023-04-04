--liquibase formatted sql



--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.leukomalacia
create table if not exists main.leukomalacia (
    leukomalacia_id   smallint not null
    , leukomalacia_name varchar not null
);

comment on table main.leukomalacia is
    'Periventricular leukomalacia';

alter table main.leukomalacia add constraint leukomalacia_pk
		primary key ( leukomalacia_id
);

alter table main.leukomalacia add constraint leukomalacia_leukomalacia_name_un unique
( leukomalacia_name );

-- Permissions
revoke all on main.leukomalacia from public;

--rollback drop table if exists main.leukomalacia;


--changeset NP:2 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.leukomalacia
insert 
	into main.leukomalacia
	values
		(1, 'нет')
		, (2, 'ЛМ')
		, (3, 'ПВЛ')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.habilitation
create table if not exists main.habilitation (
    habilitation_id   smallint not null
    , habilitation_name varchar not null
);

comment on table main.habilitation is
    'Habilitation';

alter table main.habilitation add constraint habilitation_pk
		primary key ( habilitation_id
);

alter table main.habilitation add constraint habilitation_habilitation_name_un unique
( habilitation_name );

-- Permissions
revoke all on main.habilitation from public;

--rollback drop table if exists main.habilitation;


--changeset NP:4 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.habilitation
insert 
	into main.habilitation
	values
		(1, 'да')
		, (2, 'нет')
		, (3, 'после ПВЛ')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.breathing_syndrom
create table if not exists main.breathing_syndrom (
    breathing_syndrom_id   smallint not null
    , breathing_syndrom_name varchar not null
);

comment on table main.breathing_syndrom is
    'Breathing syndrom';

alter table main.breathing_syndrom add constraint breathing_syndrom_pk
		primary key ( breathing_syndrom_id
);
 
alter table main.breathing_syndrom add constraint breathing_syndrom_breathing_syndrom_name_un
unique ( breathing_syndrom_name );

-- Permissions
revoke all on main.breathing_syndrom from public;

--rollback drop table if exists main.breathing_syndrom;


--changeset NP:6 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.breathing_syndrom
insert 
	into main.breathing_syndrom
	values
		(1, 'нет')
		, (2, 'БЛД')
		, (3, 'БЛД, ВПн')
		, (4, 'БЛД, РДС, БГМ')
		, (5, 'БЛД, РДС, БГМ, ВПн')
		, (6, 'ВПн')
		, (7, 'ВПн, РДС')
		, (8, 'ВПн, РДС, БГМ')
		, (9, 'РДС')
		, (10, 'РДС, БГМ')
		, (11, 'РДС, БЛД, ВПн')
		, (12, 'РДС, ВПн')
		, (13, 'РДС, ВПн, БЛД')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:7 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.intracranial
create table if not exists main.intracranial (
    intracranial_id   smallint not null
    , intracranial_name varchar not null
);

comment on table main.intracranial is
    'Intracranial hemorrhage';

alter table main.intracranial add constraint intracranial_pk
		primary key ( intracranial_id
);
 
alter table main.intracranial add constraint intracranial_intracranial_name_un unique
( intracranial_name );

-- Permissions
revoke all on main.intracranial from public;

--rollback drop table if exists main.intracranial;


--changeset NP:8 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.intracranial
insert 
	into main.intracranial
	values
		(1, 'да')
		, (2, 'нет')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:9 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.npt
create table if not exists main.npt (
    npt_id   smallint not null,
    npt_name varchar not null
);

comment on table main.npt is
    'Neuroprotective therapy beginning';

alter table main.npt 
	add constraint npt_pk
		primary key ( npt_id );

alter table main.npt 
	add constraint npt_npt_name_un 
		unique ( npt_name );

-- Permissions
revoke all on main.npt from public;

--rollback drop table if exists main.npt;


--changeset NP:10 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.npt
insert 
	into main.npt
	values
		(1, '1-2 мес.')
		, (2, 'до 1 мес.')
		, (3, 'после 1 мес.')
		, (4, 'после 2 мес.')
		, (5, 'после 3 мес.')
		, (6, 'после 5 мес.')
		, (7, 'после 6 мес.')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:11 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.status_30
create table if not exists main.status_30 (
    status_30_id   smallint not null,
    status_30_name varchar not null
);

comment on table main.status_30 is
    'Status after 30 days';

alter table main.status_30 
	add constraint status_30_pk
		primary key ( status_30_id );

alter table main.status_30 
	add constraint status_30_status_30_name_un 
		unique ( status_30_name );

-- Permissions
revoke all on main.status_30 from public;

--rollback drop table if exists main.status_30;


--changeset NP:12 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.status_30
insert 
	into main.status_30
	values
		(1, 'БО')
		, (2, 'возбуждение')
		, (3, 'угнетение')
		, (4, 'возбуждение, ПГВГ/СГШ')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:13 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.immersion
create table if not exists main.immersion (
    immersion_id   smallint not null,
    immersion_name varchar not null
);

comment on table main.immersion is
    'Dry immersion';

alter table main.immersion 
	add constraint immersion_pk
		primary key ( immersion_id );

alter table main.immersion 
	add constraint immersion_immersion_name_un 
		unique ( immersion_name );

-- Permissions
revoke all on main.immersion from public;

--rollback drop table if exists main.immersion;


--changeset NP:14 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.immersion
insert 
	into main.immersion
	values
		(1, 'да')
		, (2, 'нет')
		, (3, 'после ПВЛ')
	on conflict 
		do nothing
;

--rollback select 1;
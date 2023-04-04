--liquibase formatted sql



--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.pathology_type
create table if not exists main.pathology_type (
    pathology_id   smallint not null
    , pathology_name varchar not null
);

comment on table main.pathology_type is
    'List of pathologies';

alter table main.pathology_type add constraint pathology_type_pk
		primary key ( pathology_id );

alter table main.pathology_type add constraint pathology_type_pathology_name_un 
		unique ( pathology_name );

-- Permissions
revoke all on main.pathology_type from public;

--rollback drop table if exists main.pathology_type;


--changeset NP:2 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.pathology_type
insert 
	into main.pathology_type
	values
		(1, 'анемия')
		, (2, 'МВС')
		, (3, 'энд.система')
		, (4, 'ССС')
		, (5, 'ЖКТ')
		, (6, 'курение')
		, (7, 'НС')
		, (8, 'гинекология')
		, (9, 'угроза')
		, (10, 'ХФПН/ХВГП')
		, (11, 'ИЦН')
		, (12, 'кольпит')
		, (13, 'ОРВИ')
		, (14, 'ИМТ')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.pathology
create table if not exists main.pathology (
    pregnancy_id         smallint not null
    , pathology_id         smallint not null
    , pathology_full_name  varchar
    , pathology_short_name varchar not null
);

comment on table main.pathology is
    'List of pathologies diagnost during pregnancy';

alter table main.pathology
    add constraint pathology_pathology_type_fk 
		foreign key ( pathology_id )
			references main.pathology_type ( pathology_id );

alter table main.pathology
    add constraint pathology_pregnancy_fk 
		foreign key ( pregnancy_id )
			references main.pregnancy ( pregnancy_id );

-- Permissions
revoke all on main.pathology from public;

--rollback drop table if exists main.pathology;
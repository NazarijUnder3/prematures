--liquibase formatted sql



--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.mkf_code_category
create table if not exists main.mkf_code_category (
    mkf_category_id   smallint not null
    , mkf_category_name varchar not null
);

alter table main.mkf_code_category 
	add constraint mkf_code_category_pk 
		primary key ( mkf_category_id );

alter table main.mkf_code_category 
	add constraint mkf_code_category_mkf_category_name_un
		unique ( mkf_category_name );

-- Permissions
revoke all on main.mkf_code_category from public;

--rollback drop table if exists main.mkf_code_category;


--changeset NP:2 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.mkf_code_category
insert 
	into main.mkf_code_category
	values
		(1, 'b')
		, (2, 'd')
		, (3, 'e')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.mkf_code
create table if not exists main.mkf_code (
    mkf_id          smallint not null
    , mkf_name        varchar not null
    , mkf_category_id smallint not null
);

alter table main.mkf_code 
	add constraint mkf_code_pk 
		primary key ( mkf_id );

alter table main.mkf_code 
	add constraint mkf_code_mkf_name_un 
		unique ( mkf_name );

alter table main.mkf_code
    add constraint mkf_code_mkf_code_category_fk foreign key ( mkf_category_id )
        references main.mkf_code_category ( mkf_category_id )
            on delete cascade;

-- Permissions
revoke all on main.mkf_code from public;

--rollback drop table if exists main.mkf_code;


--changeset NP:4 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.mkf_code
insert 
	into main.mkf_code
	values
		(1, 'b210', 1)
		, (2, 'b230', 1)
		, (3, 'b152', 1)
		, (4, 'b134', 1)
		, (5, 'b750', 1)
		, (6, 'b730', 1)
		, (7, 'b735', 1)
		, (8, 'b755', 1)
		, (9, 'b760', 1)
		, (10, 'd330', 2)
		, (11, 'd4103', 2)
		, (12, 'd4104', 2)
		, (13, 'd4550', 2)
		, (14, 'e110', 3)
		, (15, 'e1101', 3)
		, (16, 'e410', 3)
		, (17, 'e355', 3)
		, (18, 'e580', 3)
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.mkf
create table if not exists main.mkf (
    child_id         integer not null
    , mkf_id           smallint not null
    , observation_time smallint not null
    , mkf_value        char not null
    , mkf_description  varchar
);

alter table main.mkf
    add check ( observation_time in ( 1, 12, 24, 3, 6 ) );

alter table main.mkf
    add constraint mkf_pk primary key ( child_id
    , mkf_id
    , observation_time );

alter table main.mkf
    add constraint mkf_child_fk foreign key ( child_id )
        references main.child ( child_id );

alter table main.mkf
    add constraint mkf_mkf_code_fk foreign key ( mkf_id )
        references main.mkf_code ( mkf_id );

-- Permissions
revoke all on main.mkf from public;

--rollback drop table if exists main.mkf;



--changeset NP:6 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.phone
create table if not exists main.phone (
    child_id        integer not null
    , phone           varchar not null
    , phone_messanger varchar
    , phone_comment   varchar
);

comment on column main.phone.phone_messanger is
    'information about messangeres for communication';

alter table main.phone add constraint phone_pk primary key ( child_id );

alter table main.phone
    add constraint phone_child_fk foreign key ( child_id )
        references main.child ( child_id );

-- Permissions
revoke all on main.phone from public;

--rollback drop table if exists main.phone;



--changeset NP:7 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.diagnosis
create table if not exists main.diagnosis (
    child_id  integer not null
    , diagnosis text not null
    , data      timestamp with time zone default current_timestamp not null
);

alter table main.diagnosis
    add constraint diagnosis_child_fk foreign key ( child_id )
        references main.child ( child_id );

-- Permissions
revoke all on main.diagnosis from public;

--rollback drop table main.diagnosis;



--changeset NP:8 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.note
create table if not exists main.note (
    note_date timestamp with time zone default current_timestamp not null
    , child_id  integer not null
    , note      varchar
);

alter table main.note 
	add constraint comment_pk 
		primary key ( child_id, note_date );

alter table main.note
    add constraint comment_child_fk foreign key ( child_id )
        references main.child ( child_id );
		
-- Permissions
revoke all on main.note from public;

--rollback drop table if exists main.note;
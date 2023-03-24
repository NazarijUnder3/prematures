--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.vision
create table if not exists main.vision (
    vision_id   smallint not null,
    vision_name varchar not null
);

alter table main.vision 
	add constraint vision_pk \r\n\t\tprimary key ( vision_id );

alter table main.vision 
	add constraint vision_vision_name_un 
		unique ( vision_name );

-- Permissions
revoke all on main.vision from public;

--rollback drop table if exists main.vision;


--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.git
create table if not exists main.git (
    git_id   smallint not null,
    git_name varchar not null
);

comment on table main.git is
    'Gastrointestinal tract';

alter table main.git 
	add constraint git_pk \r\n\t\tprimary key ( git_id );

alter table main.git 
	add constraint git_git_name_un 
		unique ( git_name );

-- Permissions
revoke all on main.git from public;

--rollback drop table if exists main.git;


--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.rf
create table if not exists main.rf (
    rf_id   smallint not null,
    rf_name varchar not null
);

alter table main.rf 
	add constraint rf_pk \r\n\t\tprimary key ( rf_id );

alter table main.rf 
	add constraint rf_rf_name_un 
		unique ( rf_name );

-- Permissions
revoke all on main.rf from public;

--rollback drop table if exists main.rf;


--changeset NP:4 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.bs
create table if not exists main.bs (
    bs_id   smallint not null,
    bs_name varchar not null
);

alter table main.bs 
	add constraint bs_pk \r\n\t\tprimary key ( bs_id );

alter table main.bs 
	add constraint bs_bs_name_un 
		unique ( bs_name );

-- Permissions
revoke all on main.bs from public;

--rollback drop table if exists main.bs;


--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.mrt
create table if not exists main.mrt (
    mrt_id   smallint not null,
    mrt_name varchar not null
);

comment on table main.mrt is
    'MRT scan';

alter table main.mrt 
	add constraint mrt_pk \r\n\t\tprimary key ( mrt_id );

alter table main.mrt 
	add constraint mrt_mrt_name_un 
		unique ( mrt_name );

-- Permissions
revoke all on main.mrt from public;

--rollback drop table if exists main.mrt;


--changeset NP:6 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.ct
create table if not exists main.ct (
    ct_id   smallint not null,
    ct_name varchar not null
);

comment on table main.ct is
    'CT scan';

alter table main.ct 
	add constraint ct_pk \r\n\t\tprimary key ( ct_id );

alter table main.ct 
	add constraint ct_ct_name_un 
		unique ( ct_name );

-- Permissions
revoke all on main.ct from public;

--rollback drop table if exists main.ct;


--changeset NP:7 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.skin
create table if not exists main.skin (
    skin_id   smallint not null,
    skin_name varchar not null
);

comment on table main.skin is
    'Skin, stigmas';

alter table main.skin 
	add constraint skin_pk \r\n\t\tprimary key ( skin_id );

alter table main.skin 
	add constraint skin_skin_name_un 
		unique ( skin_name );

-- Permissions
revoke all on main.skin from public;

--rollback drop table if exists main.skin;


--changeset NP:8 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.hearing
create table if not exists main.hearing (
    hearing_id   smallint not null,
    hearing_name varchar not null
);

alter table main.hearing 
	add constraint hearing_pk \r\n\t\tprimary key ( hearing_id );

alter table main.hearing 
	add constraint hearing_hearing_name_un 
		unique ( hearing_name );

-- Permissions
revoke all on main.hearing from public;

--rollback drop table if exists main.hearing;


--changeset NP:9 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.physical
create table if not exists main.physical (
    physical_id   smallint not null,
    physical_name varchar not null
);

comment on table main.physical is
    'Motor disability';

alter table main.physical 
	add constraint physical_pk \r\n\t\tprimary key ( physical_id );

alter table main.physical 
	add constraint physical_physical_name_un 
		unique ( physical_name );

-- Permissions
revoke all on main.physical from public;

--rollback drop table if exists main.physical;


--changeset NP:10 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.strabismus
create table if not exists main.strabismus (
    strabismus_id   smallint not null,
    strabismus_name varchar not null
);

comment on table main.strabismus is
    'Strabismus';

alter table main.strabismus 
	add constraint strabismus_pk \r\n\t\tprimary key ( strabismus_id );

alter table main.strabismus 
	add constraint strabismus_strabismus_name_un 
		unique ( strabismus_name );

-- Permissions
revoke all on main.strabismus from public;

--rollback drop table if exists main.strabismus;


--changeset NP:11 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.pf
create table if not exists main.pf (
    pf_id   smallint not null,
    pf_name varchar not null
);

alter table main.pf 
	add constraint pf_pk \r\n\t\tprimary key ( pf_id );

alter table main.pf 
	add constraint pf_pf_name_un 
		unique ( pf_name );

-- Permissions
revoke all on main.pf from public;

--rollback drop table if exists main.pf;


--changeset NP:12 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.disorder_kind
create table if not exists main.disorder_kind (
    disorder_kind_id   smallint not null,
    disorder_kind_name varchar not null
);

comment on table main.disorder_kind is
    'Nature of violations';

alter table main.disorder_kind 
	add constraint disorder_kind_pk \r\n\t\tprimary key ( disorder_kind_id );

alter table main.disorder_kind 
	add constraint disorder_kind_name_un 
		unique ( disorder_kind_name );

-- Permissions
revoke all on main.disorder_kind from public;

--rollback drop table if exists main.disorder_kind;


--changeset NP:13 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.sse
create table if not exists main.sse (
    sse_id   smallint not null,
    sse_name varchar not null
);

alter table main.sse 
	add constraint sse_pk \r\n\t\tprimary key ( sse_id );

alter table main.sse 
	add constraint sse_sse_name_un 
		unique ( sse_name );

-- Permissions
revoke all on main.sse from public;

--rollback drop table if exists main.sse;


--changeset NP:14 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.gc
create table if not exists main.gc (
    gc_id   smallint not null,
    gc_name varchar not null
);

alter table main.gc 
	add constraint gc_pk \r\n\t\tprimary key ( gc_id );

alter table main.gc 
	add constraint gc_gc_name_un 
		unique ( gc_name );

-- Permissions
revoke all on main.gc from public;

--rollback drop table if exists main.gc;


--changeset NP:15 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.mps
create table if not exists main.mps (
    mps_id   smallint not null,
    mps_name varchar not null
);

alter table main.mps 
	add constraint mps_pk \r\n\t\tprimary key ( mps_id );

alter table main.mps 
	add constraint mps_mps_name_un 
		unique ( mps_name );

-- Permissions
revoke all on main.mps from public;

--rollback drop table if exists main.mps;


--changeset NP:16 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.ims
create table if not exists main.ims (
    ims_id   smallint not null,
    ims_name varchar not null
);

alter table main.ims 
	add constraint ims_pk \r\n\t\tprimary key ( ims_id );

alter table main.ims 
	add constraint ims_ims_name_un 
		unique ( ims_name );

-- Permissions
revoke all on main.ims from public;

--rollback drop table if exists main.ims;


--changeset NP:17 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.es
create table if not exists main.es (
    es_id   smallint not null,
    es_name varchar not null
);

alter table main.es 
	add constraint es_pk \r\n\t\tprimary key ( es_id );

alter table main.es 
	add constraint es_es_name_un 
		unique ( es_name );

-- Permissions
revoke all on main.es from public;

--rollback drop table if exists main.es;


--changeset NP:18 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.disorder_type
create table if not exists main.disorder_type (
    disorder_type_id   smallint not null,
    disorder_type_name varchar not null
);

comment on table main.disorder_type is
    'List of disorders';

alter table main.disorder_type 
	add constraint disorder_type_pk \r\n\t\tprimary key ( disorder_type_id );

alter table main.disorder_type 
	add constraint disorder_type_name_un 
		unique ( disorder_type_name );

-- Permissions
revoke all on main.disorder_type from public;

--rollback drop table if exists main.disorder_type;


--changeset NP:19 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.slf
create table if not exists main.slf (
    slf_id   smallint not null,
    slf_name varchar not null
);

alter table main.slf 
	add constraint slf_pk \r\n\t\tprimary key ( slf_id );

alter table main.slf 
	add constraint slf_slf_name_un 
		unique ( slf_name );

-- Permissions
revoke all on main.slf from public;

--rollback drop table if exists main.slf


--changeset NP:20 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.cvs
create table if not exists main.cvs (
    cvs_id   smallint not null,
    cvs_name varchar not null
);

alter table main.cvs 
	add constraint cvs_pk \r\n\t\tprimary key ( cvs_id );

alter table main.cvs 
	add constraint cvs_cvs_name_un 
		unique ( cvs_name );

-- Permissions
revoke all on main.cvs from public;

--rollback drop table if exists main.cvs
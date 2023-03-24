--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.vision
CREATE TABLE main.vision (
    vision_id   SMALLINT NOT NULL,
    vision_name varchar NOT NULL
);

ALTER TABLE main.vision ADD CONSTRAINT vision_pk PRIMARY KEY ( vision_id );

ALTER TABLE main.vision ADD CONSTRAINT vision_vision_name_un UNIQUE ( vision_name );

-- Permissions
revoke all on main.vision from public;

--rollback drop table if exists main.vision;


--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.git
CREATE TABLE main.git (
    git_id   SMALLINT NOT NULL,
    git_name varchar NOT NULL
);

COMMENT ON TABLE main.git IS
    'Gastrointestinal tract';

ALTER TABLE main.git ADD CONSTRAINT git_pk PRIMARY KEY ( git_id );

ALTER TABLE main.git ADD CONSTRAINT git_git_name_un UNIQUE ( git_name );

-- Permissions
revoke all on main.git from public;

--rollback drop table if exists main.git;


--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.rf
CREATE TABLE main.rf (
    rf_id   SMALLINT NOT NULL,
    rf_name varchar NOT NULL
);

ALTER TABLE main.rf ADD CONSTRAINT rf_pk PRIMARY KEY ( rf_id );

ALTER TABLE main.rf ADD CONSTRAINT rf_rf_name_un UNIQUE ( rf_name );

-- Permissions
revoke all on main.rf from public;

--rollback drop table if exists main.rf;


--changeset NP:4 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.bs
CREATE TABLE main.bs (
    bs_id   SMALLINT NOT NULL,
    bs_name varchar NOT NULL
);

ALTER TABLE main.bs ADD CONSTRAINT bs_pk PRIMARY KEY ( bs_id );

ALTER TABLE main.bs ADD CONSTRAINT bs_bs_name_un UNIQUE ( bs_name );

-- Permissions
revoke all on main.bs from public;

--rollback drop table if exists main.bs;


--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.mrt
CREATE TABLE main.mrt (
    mrt_id   SMALLINT NOT NULL,
    mrt_name varchar NOT NULL
);

COMMENT ON TABLE main.mrt IS
    'MRT scan';

ALTER TABLE main.mrt ADD CONSTRAINT mrt_pk PRIMARY KEY ( mrt_id );

ALTER TABLE main.mrt ADD CONSTRAINT mrt_mrt_name_un UNIQUE ( mrt_name );

-- Permissions
revoke all on main.mrt from public;

--rollback drop table if exists main.mrt;


--changeset NP:6 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.ct
CREATE TABLE main.ct (
    ct_id   SMALLINT NOT NULL,
    ct_name varchar NOT NULL
);

COMMENT ON TABLE main.ct IS
    'CT scan';

ALTER TABLE main.ct ADD CONSTRAINT ct_pk PRIMARY KEY ( ct_id );

ALTER TABLE main.ct ADD CONSTRAINT ct_ct_name_un UNIQUE ( ct_name );

-- Permissions
revoke all on main.ct from public;

--rollback drop table if exists main.ct;


--changeset NP:7 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.skin
CREATE TABLE main.skin (
    skin_id   SMALLINT NOT NULL,
    skin_name varchar NOT NULL
);

COMMENT ON TABLE main.skin IS
    'Skin, stigmas';

ALTER TABLE main.skin ADD CONSTRAINT skin_pk PRIMARY KEY ( skin_id );

ALTER TABLE main.skin ADD CONSTRAINT skin_skin_name_un UNIQUE ( skin_name );

-- Permissions
revoke all on main.skin from public;

--rollback drop table if exists main.skin;


--changeset NP:8 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.hearing
CREATE TABLE main.hearing (
    hearing_id   SMALLINT NOT NULL,
    hearing_name varchar NOT NULL
);

ALTER TABLE main.hearing ADD CONSTRAINT hearing_pk PRIMARY KEY ( hearing_id );

ALTER TABLE main.hearing ADD CONSTRAINT hearing_hearing_name_un UNIQUE ( hearing_name );

-- Permissions
revoke all on main.hearing from public;

--rollback drop table if exists main.hearing;


--changeset NP:9 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.physical
CREATE TABLE main.physical (
    physical_id   SMALLINT NOT NULL,
    physical_name varchar NOT NULL
);

COMMENT ON TABLE main.physical IS
    'Motor disability';

ALTER TABLE main.physical ADD CONSTRAINT physical_pk PRIMARY KEY ( physical_id );

ALTER TABLE main.physical ADD CONSTRAINT physical_physical_name_un UNIQUE ( physical_name );

-- Permissions
revoke all on main.physical from public;

--rollback drop table if exists main.physical;


--changeset NP:10 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.strabismus
CREATE TABLE main.strabismus (
    strabismus_id   SMALLINT NOT NULL,
    strabismus_name varchar NOT NULL
);

COMMENT ON TABLE main.strabismus IS
    'Strabismus';

ALTER TABLE main.strabismus ADD CONSTRAINT strabismus_pk PRIMARY KEY ( strabismus_id );

ALTER TABLE main.strabismus ADD CONSTRAINT strabismus_strabismus_name_un UNIQUE ( strabismus_name );

-- Permissions
revoke all on main.strabismus from public;

--rollback drop table if exists main.strabismus;


--changeset NP:11 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.pf
CREATE TABLE main.pf (
    pf_id   SMALLINT NOT NULL,
    pf_name varchar NOT NULL
);

ALTER TABLE main.pf ADD CONSTRAINT pf_pk PRIMARY KEY ( pf_id );

ALTER TABLE main.pf ADD CONSTRAINT pf_pf_name_un UNIQUE ( pf_name );

-- Permissions
revoke all on main.pf from public;

--rollback drop table if exists main.pf;


--changeset NP:12 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.disorder_kind
CREATE TABLE main.disorder_kind (
    disorder_kind_id   SMALLINT NOT NULL,
    disorder_kind_name varchar NOT NULL
);

COMMENT ON TABLE main.disorder_kind IS
    'Nature of violations';

ALTER TABLE main.disorder_kind ADD CONSTRAINT disorder_kind_pk PRIMARY KEY ( disorder_kind_id );

ALTER TABLE main.disorder_kind ADD CONSTRAINT disorder_kind_name_un UNIQUE ( disorder_kind_name );

-- Permissions
revoke all on main.disorder_kind from public;

--rollback drop table if exists main.disorder_kind;


--changeset NP:13 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.sse
CREATE TABLE main.sse (
    sse_id   SMALLINT NOT NULL,
    sse_name varchar NOT NULL
);

ALTER TABLE main.sse ADD CONSTRAINT sse_pk PRIMARY KEY ( sse_id );

ALTER TABLE main.sse ADD CONSTRAINT sse_sse_name_un UNIQUE ( sse_name );

-- Permissions
revoke all on main.sse from public;

--rollback drop table if exists main.sse;


--changeset NP:14 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.gc
CREATE TABLE main.gc (
    gc_id   SMALLINT NOT NULL,
    gc_name varchar NOT NULL
);

ALTER TABLE main.gc ADD CONSTRAINT gc_pk PRIMARY KEY ( gc_id );

ALTER TABLE main.gc ADD CONSTRAINT gc_gc_name_un UNIQUE ( gc_name );

-- Permissions
revoke all on main.gc from public;

--rollback drop table if exists main.gc;


--changeset NP:15 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.mps
CREATE TABLE main.mps (
    mps_id   SMALLINT NOT NULL,
    mps_name varchar NOT NULL
);

ALTER TABLE main.mps ADD CONSTRAINT mps_pk PRIMARY KEY ( mps_id );

ALTER TABLE main.mps ADD CONSTRAINT mps_mps_name_un UNIQUE ( mps_name );

-- Permissions
revoke all on main.mps from public;

--rollback drop table if exists main.mps;


--changeset NP:16 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.ims
CREATE TABLE main.ims (
    ims_id   SMALLINT NOT NULL,
    ims_name varchar NOT NULL
);

ALTER TABLE main.ims ADD CONSTRAINT ims_pk PRIMARY KEY ( ims_id );

ALTER TABLE main.ims ADD CONSTRAINT ims_ims_name_un UNIQUE ( ims_name );

-- Permissions
revoke all on main.ims from public;

--rollback drop table if exists main.ims;


--changeset NP:17 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.es
CREATE TABLE main.es (
    es_id   SMALLINT NOT NULL,
    es_name varchar NOT NULL
);

ALTER TABLE main.es ADD CONSTRAINT es_pk PRIMARY KEY ( es_id );

ALTER TABLE main.es ADD CONSTRAINT es_es_name_un UNIQUE ( es_name );

-- Permissions
revoke all on main.es from public;

--rollback drop table if exists main.es;


--changeset NP:18 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.disorder_type
CREATE TABLE main.disorder_type (
    disorder_type_id   SMALLINT NOT NULL,
    disorder_type_name varchar NOT NULL
);

COMMENT ON TABLE main.disorder_type IS
    'List of disorders';

ALTER TABLE main.disorder_type ADD CONSTRAINT disorder_type_pk PRIMARY KEY ( disorder_type_id );

ALTER TABLE main.disorder_type ADD CONSTRAINT disorder_type_name_un UNIQUE ( disorder_type_name );

-- Permissions
revoke all on main.disorder_type from public;

--rollback drop table if exists main.disorder_type;


--changeset NP:19 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.slf
CREATE TABLE main.slf (
    slf_id   SMALLINT NOT NULL,
    slf_name varchar NOT NULL
);

ALTER TABLE main.slf ADD CONSTRAINT slf_pk PRIMARY KEY ( slf_id );

ALTER TABLE main.slf ADD CONSTRAINT slf_slf_name_un UNIQUE ( slf_name );

-- Permissions
revoke all on main.slf from public;

--rollback drop table if exists main.slf


--changeset NP:20 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.cvs
CREATE TABLE main.cvs (
    cvs_id   SMALLINT NOT NULL,
    cvs_name varchar NOT NULL
);

ALTER TABLE main.cvs ADD CONSTRAINT cvs_pk PRIMARY KEY ( cvs_id );

ALTER TABLE main.cvs ADD CONSTRAINT cvs_cvs_name_un UNIQUE ( cvs_name );

-- Permissions
revoke all on main.cvs from public;

--rollback drop table if exists main.cvs
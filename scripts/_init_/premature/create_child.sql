--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.child
CREATE TABLE main.child (
    child_id            INTEGER
        GENERATED ALWAYS AS IDENTITY ( START WITH 1 )
    NOT NULL,
    child_name          varchar NOT NULL,
    child_surname       varchar NOT NULL,
    gestation           SMALLINT NOT NULL,
    height              SMALLINT NOT NULL,
    weight              SMALLINT NOT NULL,
    apgar0              SMALLINT NOT NULL,
    apgar1              SMALLINT,
    asphyxia            boolean NOT NULL,
    hospital_id         SMALLINT NOT NULL,
    gender_id           SMALLINT NOT NULL,
    locality_id         SMALLINT NOT NULL,
    eco_id              SMALLINT NOT NULL,
    pregnancy_id        SMALLINT NOT NULL,
    "convulsion0 id"    SMALLINT NOT NULL,
    "convulsion7 id"    SMALLINT NOT NULL,
    sepsis_id           SMALLINT NOT NULL,
    sepsis_ethiology_id SMALLINT NOT NULL,
    "pcr blood id"      SMALLINT NOT NULL,
    "pcr saliva id"     SMALLINT NOT NULL,
    rt_kfg_id           SMALLINT NOT NULL,
    reanimation         boolean NOT NULL,
    alv                 SMALLINT,
    cpap                SMALLINT,
    ph                  NUMERIC NOT NULL,
    surfactant          boolean NOT NULL,
    child_card          varchar,
    user_id             INTEGER NOT NULL,
    ts                  TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp NOT NULL,
    ir                  SMALLINT NOT NULL,
    white_body_id       SMALLINT NOT NULL,
    reflex_id           SMALLINT NOT NULL,
    ne                  boolean NOT NULL
);

ALTER TABLE main.child ADD CHECK ( gestation BETWEEN 20 AND 50 );

ALTER TABLE main.child ADD CHECK ( height BETWEEN 20 AND 60 );

ALTER TABLE main.child ADD CHECK ( weight BETWEEN 500 AND 5000 );

ALTER TABLE main.child ADD CHECK ( apgar0 BETWEEN 1 AND 9 );

ALTER TABLE main.child ADD CHECK ( apgar1 BETWEEN 1 AND 9 );

ALTER TABLE main.child ADD CHECK ( alv BETWEEN 1 AND 60 );

ALTER TABLE main.child ADD CHECK ( cpap BETWEEN 1 AND 60 );

ALTER TABLE main.child ADD CHECK ( ph BETWEEN 1 AND 15 );

ALTER TABLE main.child
    ADD CHECK ( ir BETWEEN 0.5 AND 1 );

COMMENT ON TABLE main.child IS
    'information about babies';

COMMENT ON COLUMN main.child."convulsion0 id" IS
    'Convulsion\apnea at birth';

COMMENT ON COLUMN main.child."convulsion7 id" IS
    'Convulsion\apnea during 1 week';

COMMENT ON COLUMN main.child.alv IS
    'Artificial lung ventilation';

COMMENT ON COLUMN main.child.cpap IS
    'Continuous positive airway pressure';

COMMENT ON COLUMN main.child.user_id IS
    'UserID making the change';

COMMENT ON COLUMN main.child.ts IS
    'Change timestamp';

CREATE UNIQUE INDEX main.child__idx ON
    main.child (
        pregnancy_id
    ASC );

ALTER TABLE main.child ADD CONSTRAINT child_pk PRIMARY KEY ( child_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_convulsion_fk FOREIGN KEY ( "convulsion0 id" )
        REFERENCES main.convulsion ( convulsion_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_convulsion_fkv1 FOREIGN KEY ( "convulsion7 id" )
        REFERENCES main.convulsion ( convulsion_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_eco_fk FOREIGN KEY ( eco_id )
        REFERENCES main.eco ( eco_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_gender_fk FOREIGN KEY ( gender_id )
        REFERENCES main.gender ( gender_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_hospital_fk FOREIGN KEY ( hospital_id )
        REFERENCES main.hospital ( hospital_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_locality_fk FOREIGN KEY ( locality_id )
        REFERENCES main.locality ( locality_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_pcr_fk FOREIGN KEY ( "pcr blood id" )
        REFERENCES main.pcr ( pcr_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_pcr_fkv1 FOREIGN KEY ( "pcr saliva id" )
        REFERENCES main.pcr ( pcr_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_pregnancy_fk FOREIGN KEY ( pregnancy_id )
        REFERENCES main.pregnancy ( pregnancy_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_reflex_fk FOREIGN KEY ( reflex_id )
        REFERENCES main.reflex ( reflex_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_rt_kfg_fk FOREIGN KEY ( rt_kfg_id )
        REFERENCES main.rt_kfg ( rt_kfg_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_sepsis_ethiology_fk FOREIGN KEY ( sepsis_ethiology_id )
        REFERENCES main.sepsis_ethiology ( sepsis_ethiology_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_sepsis_fk FOREIGN KEY ( sepsis_id )
        REFERENCES main.sepsis ( sepsis_id );

ALTER TABLE main.child
    ADD CONSTRAINT child_white_body_fk FOREIGN KEY ( white_body_id )
        REFERENCES main.white_body ( white_body_id );

-- Permissions
revoke all on main.child from public;

--rollback drop table if exists main.child;


--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.mkf
CREATE TABLE main.mkf (
    child_id         INTEGER NOT NULL,
    mkf_id           SMALLINT NOT NULL,
    observation_time SMALLINT NOT NULL,
    mkf_value        CHAR NOT NULL,
    mkf_description  varchar
);

ALTER TABLE main.mkf
    ADD CHECK ( observation_time IN ( 1, 12, 24, 3, 6 ) );

ALTER TABLE main.mkf
    ADD CONSTRAINT mkf_pk PRIMARY KEY ( child_id,
                                        mkf_id,
                                        observation_time );

ALTER TABLE main.mkf
    ADD CONSTRAINT mkf_child_fk FOREIGN KEY ( child_id )
        REFERENCES main.child ( child_id );

ALTER TABLE main.mkf
    ADD CONSTRAINT mkf_mkf_code_fk FOREIGN KEY ( mkf_id )
        REFERENCES main.mkf_code ( mkf_id );

-- Permissions
revoke all on main.mkf from public;

--rollback drop table if exists main.mkf;


--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.phone
CREATE TABLE main.phone (
    child_id        INTEGER NOT NULL,
    phone           varchar NOT NULL,
    phone_messanger varchar,
    phone_comment   varchar
);

COMMENT ON COLUMN main.phone.phone_messanger IS
    'information about messangeres for communication';

ALTER TABLE main.phone ADD CONSTRAINT phone_pk PRIMARY KEY ( child_id );

ALTER TABLE main.phone
    ADD CONSTRAINT phone_child_fk FOREIGN KEY ( child_id )
        REFERENCES main.child ( child_id );

-- Permissions
revoke all on main.phone from public;

--rollback drop table if exists main.phone;


--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.diagnosis
CREATE TABLE main.diagnosis (
    child_id  INTEGER NOT NULL,
    diagnosis text NOT NULL,
    data      TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp NOT NULL
);

ALTER TABLE main.diagnosis
    ADD CONSTRAINT diagnosis_child_fk FOREIGN KEY ( child_id )
        REFERENCES main.child ( child_id );

-- Permissions
revoke all on main.diagnosis from public;

--rollback drop table if exists main.diagnosis;
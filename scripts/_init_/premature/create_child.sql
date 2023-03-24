--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.child
create table if not exists main.child (
    child_id            INTEGER
        GENERATED ALWAYS AS IDENTITY ( START WITH 1 )
    not null,
    child_name          varchar not null,
    child_surname       varchar not null,
    gestation           smallint not null,
    height              smallint not null,
    weight              smallint not null,
    apgar0              smallint not null,
    apgar1              smallint,
    asphyxia            boolean not null,
    hospital_id         smallint not null,
    gender_id           smallint not null,
    locality_id         smallint not null,
    eco_id              smallint not null,
    pregnancy_id        smallint not null,
    "convulsion0 id"    smallint not null,
    "convulsion7 id"    smallint not null,
    sepsis_id           smallint not null,
    sepsis_ethiology_id smallint not null,
    "pcr blood id"      smallint not null,
    "pcr saliva id"     smallint not null,
    rt_kfg_id           smallint not null,
    reanimation         boolean not null,
    alv                 smallint,
    cpap                smallint,
    ph                  NUMERIC not null,
    surfactant          boolean not null,
    child_card          varchar,
    user_id             INTEGER not null,
    ts                  TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp not null,
    ir                  smallint not null,
    white_body_id       smallint not null,
    reflex_id           smallint not null,
    ne                  boolean not null
);

alter table main.child ADD CHECK ( gestation BETWEEN 20 AND 50 );

alter table main.child ADD CHECK ( height BETWEEN 20 AND 60 );

alter table main.child ADD CHECK ( weight BETWEEN 500 AND 5000 );

alter table main.child ADD CHECK ( apgar0 BETWEEN 1 AND 9 );

alter table main.child ADD CHECK ( apgar1 BETWEEN 1 AND 9 );

alter table main.child ADD CHECK ( alv BETWEEN 1 AND 60 );

alter table main.child ADD CHECK ( cpap BETWEEN 1 AND 60 );

alter table main.child ADD CHECK ( ph BETWEEN 1 AND 15 );

alter table main.child
    ADD CHECK ( ir BETWEEN 0.5 AND 1 );

comment on table main.child is
    'information about babies';

COMMENT ON COLUMN main.child."convulsion0 id" is
    'Convulsion\apnea at birth';

COMMENT ON COLUMN main.child."convulsion7 id" is
    'Convulsion\apnea during 1 week';

COMMENT ON COLUMN main.child.alv is
    'Artificial lung ventilation';

COMMENT ON COLUMN main.child.cpap is
    'Continuous positive airway pressure';

COMMENT ON COLUMN main.child.user_id is
    'UserID making the change';

COMMENT ON COLUMN main.child.ts is
    'Change timestamp';

CREATE 
		unique INDEX main.child__idx ON
    main.child (
        pregnancy_id
    ASC );

alter table main.child 
	add constraint child_pk \r\n\t\tprimary key ( child_id );

alter table main.child
    
	add constraint child_convulsion_fk FOREIGN KEY ( "convulsion0 id" )
        REFERENCES main.convulsion ( convulsion_id );

alter table main.child
    
	add constraint child_convulsion_fkv1 FOREIGN KEY ( "convulsion7 id" )
        REFERENCES main.convulsion ( convulsion_id );

alter table main.child
    
	add constraint child_eco_fk FOREIGN KEY ( eco_id )
        REFERENCES main.eco ( eco_id );

alter table main.child
    
	add constraint child_gender_fk FOREIGN KEY ( gender_id )
        REFERENCES main.gender ( gender_id );

alter table main.child
    
	add constraint child_hospital_fk FOREIGN KEY ( hospital_id )
        REFERENCES main.hospital ( hospital_id );

alter table main.child
    
	add constraint child_locality_fk FOREIGN KEY ( locality_id )
        REFERENCES main.locality ( locality_id );

alter table main.child
    
	add constraint child_pcr_fk FOREIGN KEY ( "pcr blood id" )
        REFERENCES main.pcr ( pcr_id );

alter table main.child
    
	add constraint child_pcr_fkv1 FOREIGN KEY ( "pcr saliva id" )
        REFERENCES main.pcr ( pcr_id );

alter table main.child
    
	add constraint child_pregnancy_fk FOREIGN KEY ( pregnancy_id )
        REFERENCES main.pregnancy ( pregnancy_id );

alter table main.child
    
	add constraint child_reflex_fk FOREIGN KEY ( reflex_id )
        REFERENCES main.reflex ( reflex_id );

alter table main.child
    
	add constraint child_rt_kfg_fk FOREIGN KEY ( rt_kfg_id )
        REFERENCES main.rt_kfg ( rt_kfg_id );

alter table main.child
    
	add constraint child_sepsis_ethiology_fk FOREIGN KEY ( sepsis_ethiology_id )
        REFERENCES main.sepsis_ethiology ( sepsis_ethiology_id );

alter table main.child
    
	add constraint child_sepsis_fk FOREIGN KEY ( sepsis_id )
        REFERENCES main.sepsis ( sepsis_id );

alter table main.child
    
	add constraint child_white_body_fk FOREIGN KEY ( white_body_id )
        REFERENCES main.white_body ( white_body_id );

-- Permissions
revoke all on main.child from public;

--rollback drop table if exists main.child;


--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.mkf
create table if not exists main.mkf (
    child_id         INTEGER not null,
    mkf_id           smallint not null,
    observation_time smallint not null,
    mkf_value        CHAR not null,
    mkf_description  varchar
);

alter table main.mkf
    ADD CHECK ( observation_time IN ( 1, 12, 24, 3, 6 ) );

alter table main.mkf
    
	add constraint mkf_pk \r\n\t\tprimary key ( child_id,
                                        mkf_id,
                                        observation_time );

alter table main.mkf
    
	add constraint mkf_child_fk FOREIGN KEY ( child_id )
        REFERENCES main.child ( child_id );

alter table main.mkf
    
	add constraint mkf_mkf_code_fk FOREIGN KEY ( mkf_id )
        REFERENCES main.mkf_code ( mkf_id );

-- Permissions
revoke all on main.mkf from public;

--rollback drop table if exists main.mkf;


--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.phone
create table if not exists main.phone (
    child_id        INTEGER not null,
    phone           varchar not null,
    phone_messanger varchar,
    phone_comment   varchar
);

COMMENT ON COLUMN main.phone.phone_messanger is
    'information about messangeres for communication';

alter table main.phone 
	add constraint phone_pk \r\n\t\tprimary key ( child_id );

alter table main.phone
    
	add constraint phone_child_fk FOREIGN KEY ( child_id )
        REFERENCES main.child ( child_id );

-- Permissions
revoke all on main.phone from public;

--rollback drop table if exists main.phone;


--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.diagnosis
create table if not exists main.diagnosis (
    child_id  INTEGER not null,
    diagnosis text not null,
    data      TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp not null
);

alter table main.diagnosis
    
	add constraint diagnosis_child_fk FOREIGN KEY ( child_id )
        REFERENCES main.child ( child_id );

-- Permissions
revoke all on main.diagnosis from public;

--rollback drop table if exists main.diagnosis;
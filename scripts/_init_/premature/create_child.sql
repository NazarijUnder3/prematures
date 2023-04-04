--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.child
create table if not exists main.child (
    child_id            integer
        generated always as identity ( start with 1 )
    , pregnancy_id        integer not null
    , child_name          varchar not null
    , child_surname       varchar not null
    , address             varchar
    , gestation           smallint not null
    , height              smallint not null
    , weight              smallint not null
    , apgar0              smallint not null
    , apgar1              smallint
    , asphyxia            boolean not null
    , hospital_id         smallint
    , gender_id           smallint not null
    , locality_id         smallint not null
    , eco_id              smallint not null
    , convulsion0_id      smallint not null
    , convulsion7_id      smallint not null
    , sepsis_id           smallint not null
    , sepsis_ethiology_id smallint not null
    , pcr_blood_id        smallint not null
    , pcr_saliva_id       smallint not null
    , rt_kfg_id           smallint not null
    , reanimation         boolean not null
    , alv                 smallint
    , cpap                smallint
    , ph                  numeric not null
    , surfactant          boolean not null
    , child_card          varchar
    , user_id             integer not null
    , ts                  timestamp with time zone default current_timestamp not null
    , ir                  smallint not null
    , white_body_id       smallint not null
    , reflex_id           smallint not null
    , ne                  boolean not null
);

alter table main.child add check ( gestation between 20 and 50 );

alter table main.child add check ( height between 20 and 60 );

alter table main.child add check ( weight between 500 and 5000 );

alter table main.child add check ( apgar0 between 1 and 9 );

alter table main.child add check ( apgar1 between 1 and 9 );

alter table main.child add check ( alv between 1 and 60 );

alter table main.child add check ( cpap between 1 and 60 );

alter table main.child add check ( ph between 1 and 15 );

alter table main.child
    add check ( ir between 0.5 and 1 );

comment on table main.child is
    'Information about babies';

comment on column main.child.convulsion0_id is
    'Convulsion\apnea at birth';

comment on column main.child.convulsion7_id is
    'Convulsion\apnea during 1 week';

comment on column main.child.alv is
    'Artificial lung ventilation';

comment on column main.child.cpap is
    'Continuous positive airway pressure';

comment on column main.child.user_id is
    'UserID making the change';

comment on column main.child.ts is
    'Change timestamp';

alter table main.child add constraint child_pk primary key ( child_id );

alter table main.child
    add constraint child_convulsion_fk foreign key ( convulsion0_id )
        references main.convulsion ( convulsion_id );

alter table main.child
    add constraint child_convulsion_fkv1 foreign key ( convulsion7_id )
        references main.convulsion ( convulsion_id );

alter table main.child
    add constraint child_eco_fk foreign key ( eco_id )
        references main.eco ( eco_id );

alter table main.child
    add constraint child_gender_fk foreign key ( gender_id )
        references main.gender ( gender_id );

alter table main.child
    add constraint child_hospital_fk foreign key ( hospital_id )
        references main.hospital ( hospital_id );

alter table main.child
    add constraint child_locality_fk foreign key ( locality_id )
        references main.locality ( locality_id );

alter table main.child
    add constraint child_pcr_fk foreign key ( pcr_blood_id )
        references main.pcr ( pcr_id );

alter table main.child
    add constraint child_pcr_fkv1 foreign key ( pcr_saliva_id )
        references main.pcr ( pcr_id );

alter table main.child
    add constraint child_pregnancy_fk foreign key ( pregnancy_id )
        references main.pregnancy ( pregnancy_id );

alter table main.child
    add constraint child_reflex_fk foreign key ( reflex_id )
        references main.reflex ( reflex_id );

alter table main.child
    add constraint child_rt_kfg_fk foreign key ( rt_kfg_id )
        references main.rt_kfg ( rt_kfg_id );

alter table main.child
    add constraint child_sepsis_ethiology_fk foreign key ( sepsis_ethiology_id )
        references main.sepsis_ethiology ( sepsis_ethiology_id );

alter table main.child
    add constraint child_sepsis_fk foreign key ( sepsis_id )
        references main.sepsis ( sepsis_id );

alter table main.child
    add constraint child_white_body_fk foreign key ( white_body_id )
        references main.white_body ( white_body_id );

-- Permissions
revoke all on main.child from public;

--rollback drop table if exists main.child cascade;
--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.disability
create table main.disability (
    child_id             integer not null
    , breathing_syndrom_id smallint not null
    , intracranial_id      smallint not null
    , npt_id               smallint not null
    , immersion_id         smallint not null
    , leukomalacia_id      smallint not null
    , status_30_id         smallint not null
    , habilitation_id      smallint not null
    , hemorrhage           smallint default 0 not null
    , breathing_failure    smallint default 0 not null
    , sei                  boolean not null
    , ne                   boolean not null
    , encephalopathy       boolean not null
    , "comment"            varchar
    , user_id              integer not null
    , ts                   timestamp with time zone default current_timestamp not null
);

comment on table main.disability is
    'Disability Information';

comment on column main.disability.hemorrhage is
    'Paraventricular hemorrhage degree';

comment on column main.disability.breathing_failure is
    'Respiratory failure degree';

comment on column main.disability.sei is
    'Syndrome of endogenous intoxication';

comment on column main.disability.user_id is
    'UserID making the change';

comment on column main.disability.ts is
    'Change timestamp';

alter table main.disability add constraint disability_pk primary key ( child_id );

alter table main.disability
    add constraint disability_breathing_syndrom_fk foreign key ( breathing_syndrom_id
    )
        references main.breathing_syndrom ( breathing_syndrom_id );

alter table main.disability
    add constraint disability_child_fk foreign key ( child_id )
        references main.child ( child_id );

alter table main.disability
    add constraint disability_habilitation_fk foreign key ( habilitation_id )
        references main.habilitation ( habilitation_id );

alter table main.disability
    add constraint disability_immersion_fk foreign key ( immersion_id )
        references main.immersion ( immersion_id );

alter table main.disability
    add constraint disability_intracranial_fk foreign key ( intracranial_id )
        references main.intracranial ( intracranial_id );

alter table main.disability
    add constraint disability_leukomalacia_fk foreign key ( leukomalacia_id )
        references main.leukomalacia ( leukomalacia_id );

alter table main.disability
    add constraint disability_npt_fk foreign key ( npt_id )
        references main.npt ( npt_id );

alter table main.disability
    add constraint disability_status_30_fk foreign key ( status_30_id )
        references main.status_30 ( status_30_id );

-- Permissions
revoke all on main.disability from public;

--rollback drop table if exists main.disability;
--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.followup
create table if not exists main.followup (
    followup_comment   varchar
    , followup_time      smallint not null
    , child_id           integer not null
    , strabismus         boolean
    , dss                boolean
    , asd                boolean
    , ee                 boolean
    , fad                boolean
    , wd_id              smallint not null
    , sd                 boolean
    , ps_id              smallint not null
    , coordination_id    smallint not null
    , disorder_structure varchar
);

alter table main.followup
    add check ( followup_time in ( 0, 1, 1.5, 2 ) );

comment on column main.followup.dss is
    'Delayed speech skills';

comment on column main.followup.asd is
    'Autism spectrum disorder';

comment on column main.followup.ee is
    'Excessive excitability';

comment on column main.followup.fad is
    'Falling asleep disturbance';

comment on column main.followup.sd is
    'Sleep disturbance';

alter table main.followup add constraint followup_pk
		primary key ( child_id
, followup_time );

alter table main.followup
    add constraint followup_child_fk foreign key ( child_id )
        references main.child ( child_id );

alter table main.followup
    add constraint followup_coordination_fk foreign key ( coordination_id )
        references main.coordination ( coordination_id );

alter table main.followup
    add constraint followup_ps_fk foreign key ( ps_id )
        references main.ps ( ps_id );

alter table main.followup
    add constraint followup_wd_fk foreign key ( wd_id )
        references main.wd ( wd_id );

-- Permissions
revoke all on main.followup from public;

--rollback drop table if exists main.followup;

--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.disorder
create table if not exists main.disorder (
    child_id           integer not null
    , disability_oficial boolean not null
    , disability_sign    boolean not null
    , physical_id        smallint not null
    , slf_id             smallint not null
    , gc_id              smallint not null
    , sse_id             smallint not null
    , rf_id              smallint not null
    , pf_id              smallint not null
    , strabismus_id      smallint not null
    , disorder_kind_id   smallint not null
    , disorder_type_id   smallint not null
    , ims_id             smallint
    , mps_id             smallint
    , es_id              smallint
    , cvs_id             smallint
    , vision_id          smallint
    , git_id             smallint
    , bs_id              smallint
    , mrt_id             smallint
    , skin_id            smallint
    , ct_id              smallint
    , hearing_id         smallint
    , user_id            integer not null
    , ts                 timestamp with time zone default current_timestamp not null
);

comment on table main.disorder is
    'disabilities as of 2 years';

comment on column main.disorder.user_id is
    'UserID making the change';

comment on column main.disorder.ts is
    'Change timestamp';

alter table main.disorder add constraint disorder_pk primary key ( child_id );

alter table main.disorder
    add constraint disorder_bs_fk foreign key ( bs_id )
        references main.bs ( bs_id );

alter table main.disorder
    add constraint disorder_child_fk foreign key ( child_id )
        references main.child ( child_id );

alter table main.disorder
    add constraint disorder_ct_fk foreign key ( ct_id )
        references main.ct ( ct_id );

alter table main.disorder
    add constraint disorder_cvs_fk foreign key ( cvs_id )
        references main.cvs ( cvs_id );

alter table main.disorder
    add constraint disorder_disorder_kind_fk foreign key ( disorder_kind_id )
        references main.disorder_kind ( disorder_kind_id );

alter table main.disorder
    add constraint disorder_disorder_type_fk foreign key ( disorder_type_id )
        references main.disorder_type ( disorder_type_id );

alter table main.disorder
    add constraint disorder_es_fk foreign key ( es_id )
        references main.es ( es_id );

alter table main.disorder
    add constraint disorder_gc_fk foreign key ( gc_id )
        references main.gc ( gc_id );

alter table main.disorder
    add constraint disorder_git_fk foreign key ( git_id )
        references main.git ( git_id );

alter table main.disorder
    add constraint disorder_hearing_fk foreign key ( hearing_id )
        references main.hearing ( hearing_id );

alter table main.disorder
    add constraint disorder_ims_fk foreign key ( ims_id )
        references main.ims ( ims_id );

alter table main.disorder
    add constraint disorder_mps_fk foreign key ( mps_id )
        references main.mps ( mps_id );

alter table main.disorder
    add constraint disorder_mrt_fk foreign key ( mrt_id )
        references main.mrt ( mrt_id );

alter table main.disorder
    add constraint disorder_pf_fk foreign key ( pf_id )
        references main.pf ( pf_id );

alter table main.disorder
    add constraint disorder_physical_fk foreign key ( physical_id )
        references main.physical ( physical_id );

alter table main.disorder
    add constraint disorder_rf_fk foreign key ( rf_id )
        references main.rf ( rf_id );

alter table main.disorder
    add constraint disorder_skin_fk foreign key ( skin_id )
        references main.skin ( skin_id );

alter table main.disorder
    add constraint disorder_slf_fk foreign key ( slf_id )
        references main.slf ( slf_id );

alter table main.disorder
    add constraint disorder_sse_fk foreign key ( sse_id )
        references main.sse ( sse_id );

alter table main.disorder
    add constraint disorder_strabismus_fk foreign key ( strabismus_id )
        references main.strabismus ( strabismus_id );

alter table main.disorder
    add constraint disorder_vision_fk foreign key ( vision_id )
        references main.vision ( vision_id );

-- Permissions
revoke all on main.disorder from public;

--rollback drop table if exists main.disorder;
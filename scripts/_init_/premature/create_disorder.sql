--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.disorder
create table if not exists main.disorder (
    child_id           INTEGER not null,
    disability_oficial boolean not null,
    disability_sign    boolean not null,
    physical_id        smallint not null,
    slf_id             smallint not null,
    gc_id              smallint not null,
    sse_id             smallint not null,
    rf_id              smallint not null,
    pf_id              smallint not null,
    strabismus_id      smallint not null,
    disorder_kind_id   smallint not null,
    disorder_type_id   smallint not null,
    ims_id             smallint not null,
    mps_id             smallint not null,
    es_id              smallint not null,
    cvs_id             smallint not null,
    vision_id          smallint not null,
    git_id             smallint not null,
    bs_id              smallint not null,
    mrt_id             smallint not null,
    skin_id            smallint not null,
    ct_id              smallint not null,
    hearing_id         smallint not null,
    user_id            INTEGER not null,
    ts                 TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp not null
);

comment on table main.disorder is
    'disabilities as of 2 years';

COMMENT ON COLUMN main.disorder.user_id is
    'UserID making the change';

COMMENT ON COLUMN main.disorder.ts is
    'Change timestamp';

alter table main.disorder 
	add constraint disorder_pk \r\n\t\tprimary key ( child_id );

alter table main.disorder
    
	add constraint disorder_bs_fk FOREIGN KEY ( bs_id )
        REFERENCES main.bs ( bs_id );

alter table main.disorder
    
	add constraint disorder_child_fk FOREIGN KEY ( child_id )
        REFERENCES main.child ( child_id );

alter table main.disorder
    
	add constraint disorder_ct_fk FOREIGN KEY ( ct_id )
        REFERENCES main.ct ( ct_id );

alter table main.disorder
    
	add constraint disorder_cvs_fk FOREIGN KEY ( cvs_id )
        REFERENCES main.cvs ( cvs_id );

alter table main.disorder
    
	add constraint disorder_disorder_kind_fk FOREIGN KEY ( disorder_kind_id )
        REFERENCES main.disorder_kind ( disorder_kind_id );

alter table main.disorder
    
	add constraint disorder_disorder_type_fk FOREIGN KEY ( disorder_type_id )
        REFERENCES main.disorder_type ( disorder_type_id );

alter table main.disorder
    
	add constraint disorder_es_fk FOREIGN KEY ( es_id )
        REFERENCES main.es ( es_id );

alter table main.disorder
    
	add constraint disorder_gc_fk FOREIGN KEY ( gc_id )
        REFERENCES main.gc ( gc_id );

alter table main.disorder
    
	add constraint disorder_git_fk FOREIGN KEY ( git_id )
        REFERENCES main.git ( git_id );

alter table main.disorder
    
	add constraint disorder_hearing_fk FOREIGN KEY ( hearing_id )
        REFERENCES main.hearing ( hearing_id );

alter table main.disorder
    
	add constraint disorder_ims_fk FOREIGN KEY ( ims_id )
        REFERENCES main.ims ( ims_id );

alter table main.disorder
    
	add constraint disorder_mps_fk FOREIGN KEY ( mps_id )
        REFERENCES main.mps ( mps_id );

alter table main.disorder
    
	add constraint disorder_mrt_fk FOREIGN KEY ( mrt_id )
        REFERENCES main.mrt ( mrt_id );

alter table main.disorder
    
	add constraint disorder_pf_fk FOREIGN KEY ( pf_id )
        REFERENCES main.pf ( pf_id );

alter table main.disorder
    
	add constraint disorder_physical_fk FOREIGN KEY ( physical_id )
        REFERENCES main.physical ( physical_id );

alter table main.disorder
    
	add constraint disorder_rf_fk FOREIGN KEY ( rf_id )
        REFERENCES main.rf ( rf_id );

alter table main.disorder
    
	add constraint disorder_skin_fk FOREIGN KEY ( skin_id )
        REFERENCES main.skin ( skin_id );

alter table main.disorder
    
	add constraint disorder_slf_fk FOREIGN KEY ( slf_id )
        REFERENCES main.slf ( slf_id );

alter table main.disorder
    
	add constraint disorder_sse_fk FOREIGN KEY ( sse_id )
        REFERENCES main.sse ( sse_id );

alter table main.disorder
    
	add constraint disorder_strabismus_fk FOREIGN KEY ( strabismus_id )
        REFERENCES main.strabismus ( strabismus_id );

alter table main.disorder
    
	add constraint disorder_vision_fk FOREIGN KEY ( vision_id )
        REFERENCES main.vision ( vision_id );

-- Permissions
revoke all on main.disorder from public;

--rollback drop table if exists main.disorder;
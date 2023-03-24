--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.disorder
CREATE TABLE main.disorder (
    child_id           INTEGER NOT NULL,
    disability_oficial boolean NOT NULL,
    disability_sign    boolean NOT NULL,
    physical_id        SMALLINT NOT NULL,
    slf_id             SMALLINT NOT NULL,
    gc_id              SMALLINT NOT NULL,
    sse_id             SMALLINT NOT NULL,
    rf_id              SMALLINT NOT NULL,
    pf_id              SMALLINT NOT NULL,
    strabismus_id      SMALLINT NOT NULL,
    disorder_kind_id   SMALLINT NOT NULL,
    disorder_type_id   SMALLINT NOT NULL,
    ims_id             SMALLINT NOT NULL,
    mps_id             SMALLINT NOT NULL,
    es_id              SMALLINT NOT NULL,
    cvs_id             SMALLINT NOT NULL,
    vision_id          SMALLINT NOT NULL,
    git_id             SMALLINT NOT NULL,
    bs_id              SMALLINT NOT NULL,
    mrt_id             SMALLINT NOT NULL,
    skin_id            SMALLINT NOT NULL,
    ct_id              SMALLINT NOT NULL,
    hearing_id         SMALLINT NOT NULL,
    user_id            INTEGER NOT NULL,
    ts                 TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp NOT NULL
);

COMMENT ON TABLE main.disorder IS
    'disabilities as of 2 years';

COMMENT ON COLUMN main.disorder.user_id IS
    'UserID making the change';

COMMENT ON COLUMN main.disorder.ts IS
    'Change timestamp';

ALTER TABLE main.disorder ADD CONSTRAINT disorder_pk PRIMARY KEY ( child_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_bs_fk FOREIGN KEY ( bs_id )
        REFERENCES main.bs ( bs_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_child_fk FOREIGN KEY ( child_id )
        REFERENCES main.child ( child_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_ct_fk FOREIGN KEY ( ct_id )
        REFERENCES main.ct ( ct_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_cvs_fk FOREIGN KEY ( cvs_id )
        REFERENCES main.cvs ( cvs_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_disorder_kind_fk FOREIGN KEY ( disorder_kind_id )
        REFERENCES main.disorder_kind ( disorder_kind_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_disorder_type_fk FOREIGN KEY ( disorder_type_id )
        REFERENCES main.disorder_type ( disorder_type_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_es_fk FOREIGN KEY ( es_id )
        REFERENCES main.es ( es_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_gc_fk FOREIGN KEY ( gc_id )
        REFERENCES main.gc ( gc_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_git_fk FOREIGN KEY ( git_id )
        REFERENCES main.git ( git_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_hearing_fk FOREIGN KEY ( hearing_id )
        REFERENCES main.hearing ( hearing_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_ims_fk FOREIGN KEY ( ims_id )
        REFERENCES main.ims ( ims_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_mps_fk FOREIGN KEY ( mps_id )
        REFERENCES main.mps ( mps_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_mrt_fk FOREIGN KEY ( mrt_id )
        REFERENCES main.mrt ( mrt_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_pf_fk FOREIGN KEY ( pf_id )
        REFERENCES main.pf ( pf_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_physical_fk FOREIGN KEY ( physical_id )
        REFERENCES main.physical ( physical_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_rf_fk FOREIGN KEY ( rf_id )
        REFERENCES main.rf ( rf_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_skin_fk FOREIGN KEY ( skin_id )
        REFERENCES main.skin ( skin_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_slf_fk FOREIGN KEY ( slf_id )
        REFERENCES main.slf ( slf_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_sse_fk FOREIGN KEY ( sse_id )
        REFERENCES main.sse ( sse_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_strabismus_fk FOREIGN KEY ( strabismus_id )
        REFERENCES main.strabismus ( strabismus_id );

ALTER TABLE main.disorder
    ADD CONSTRAINT disorder_vision_fk FOREIGN KEY ( vision_id )
        REFERENCES main.vision ( vision_id );

-- Permissions
revoke all on main.disorder from public;

--rollback drop table if exists main.disorder;
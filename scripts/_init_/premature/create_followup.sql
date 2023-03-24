--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.followup
CREATE TABLE main.followup (
    followup_comment   varchar,
    followup_time      SMALLINT NOT NULL,
    child_id           INTEGER NOT NULL,
    strabismus         boolean,
    dss                boolean,
    asd                boolean,
    ee                 boolean,
    fad                boolean,
    wd_id              SMALLINT NOT NULL,
    sd                 boolean,
    ps_id              SMALLINT NOT NULL,
    coordination_id    SMALLINT NOT NULL,
    disorder_structure varchar
);

ALTER TABLE main.followup
    ADD CHECK ( followup_time IN ( 0, 1, 1.5, 2 ) );

COMMENT ON COLUMN main.followup.dss IS
    'Delayed speech skills';

COMMENT ON COLUMN main.followup.asd IS
    'Autism spectrum disorder';

COMMENT ON COLUMN main.followup.ee IS
    'Excessive excitability';

COMMENT ON COLUMN main.followup.fad IS
    'Falling asleep disturbance';

COMMENT ON COLUMN main.followup.sd IS
    'Sleep disturbance';

ALTER TABLE main.followup ADD CONSTRAINT followup_pk PRIMARY KEY ( child_id,
                                                                   followup_time );

ALTER TABLE main.followup
    ADD CONSTRAINT followup_child_fk FOREIGN KEY ( child_id )
        REFERENCES main.child ( child_id );

ALTER TABLE main.followup
    ADD CONSTRAINT followup_coordination_fk FOREIGN KEY ( coordination_id )
        REFERENCES main.coordination ( coordination_id );

ALTER TABLE main.followup
    ADD CONSTRAINT followup_ps_fk FOREIGN KEY ( ps_id )
        REFERENCES main.ps ( ps_id );

ALTER TABLE main.followup
    ADD CONSTRAINT followup_wd_fk FOREIGN KEY ( wd_id )
        REFERENCES main.wd ( wd_id );

-- Permissions
revoke all on main.followup from public;

--rollback drop table if exists main.followup;

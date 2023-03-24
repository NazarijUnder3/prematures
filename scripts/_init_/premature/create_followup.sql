--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.followup
create table if not exists main.followup (
    followup_comment   varchar,
    followup_time      smallint not null,
    child_id           INTEGER not null,
    strabismus         boolean,
    dss                boolean,
    asd                boolean,
    ee                 boolean,
    fad                boolean,
    wd_id              smallint not null,
    sd                 boolean,
    ps_id              smallint not null,
    coordination_id    smallint not null,
    disorder_structure varchar
);

alter table main.followup
    ADD CHECK ( followup_time IN ( 0, 1, 1.5, 2 ) );

COMMENT ON COLUMN main.followup.dss is
    'Delayed speech skills';

COMMENT ON COLUMN main.followup.asd is
    'Autism spectrum disorder';

COMMENT ON COLUMN main.followup.ee is
    'Excessive excitability';

COMMENT ON COLUMN main.followup.fad is
    'Falling asleep disturbance';

COMMENT ON COLUMN main.followup.sd is
    'Sleep disturbance';

alter table main.followup 
	add constraint followup_pk \r\n\t\tprimary key ( child_id,
                                                                   followup_time );

alter table main.followup
    
	add constraint followup_child_fk FOREIGN KEY ( child_id )
        REFERENCES main.child ( child_id );

alter table main.followup
    
	add constraint followup_coordination_fk FOREIGN KEY ( coordination_id )
        REFERENCES main.coordination ( coordination_id );

alter table main.followup
    
	add constraint followup_ps_fk FOREIGN KEY ( ps_id )
        REFERENCES main.ps ( ps_id );

alter table main.followup
    
	add constraint followup_wd_fk FOREIGN KEY ( wd_id )
        REFERENCES main.wd ( wd_id );

-- Permissions
revoke all on main.followup from public;

--rollback drop table if exists main.followup;

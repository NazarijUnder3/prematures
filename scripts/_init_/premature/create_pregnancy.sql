--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.pregnancy
create table if not exists main.pregnancy (
    pregnancy_id                integer not null
    , mother_id                   smallint not null
    , mother_age                  smallint not null
    , dad_age_id                  smallint not null
    , multipregnancy_condition_id smallint not null
    , multipregnancy_result_id    smallint not null
    , multipregnancy_id           smallint not null
    , compitation_id              smallint not null
    , amniotic_fluid_id           smallint not null
    , fluid_id                    smallint not null
    , status_id                   smallint not null
    , bmi_id                      smallint not null
    , antenatal                   boolean not null
    , infertility                 boolean not null
    , presentation_id             smallint not null
    , pregnancy_count             smallint not null
    , birth_count                 smallint not null
    , delivery_id                 smallint not null
    , user_id                     integer not null
    , ts                          timestamp with time zone default current_timestamp not
    null
);

alter table main.pregnancy 
	add constraint pregnancy_pk 
		primary key ( pregnancy_id );

comment on table main.pregnancy is
    'Pregnancy Information';

comment on column main.pregnancy.mother_age is
    'At the birth';

comment on column main.pregnancy.user_id is
    'UserID making the change';

comment on column main.pregnancy.ts is
    'Change timestamp';
	
alter table main.pregnancy 
	add constraint pregnancy_pregnancy_count_chk 
		check ( pregnancy_count between 1 and 20 );

alter table main.pregnancy 
	add constraint pregnancy_birth_count_chk 
		check ( birth_count between 1 and 20 );

alter table main.pregnancy 
	add constraint pregnancy_pregnancy_count_birth_count_chk 
		check ( pregnancy_count >= birth_count
);

alter table main.pregnancy
    add constraint pregnancy_amniotic_fluid_fk 
		foreign key ( amniotic_fluid_id )
        	references main.amniotic_fluid ( amniotic_fluid_id );

alter table main.pregnancy
    add constraint pregnancy_bmi_fk 
		foreign key ( bmi_id )
        	references main.bmi ( bmi_id );

alter table main.pregnancy
    add constraint pregnancy_compitation_fk 
		foreign key ( compitation_id )
        	references main.compitation ( compitation_id );

alter table main.pregnancy
    add constraint pregnancy_dad_fk 
		foreign key ( dad_age_id )
        	references main.dad ( dad_age_id );

alter table main.pregnancy
    add constraint pregnancy_delivery_fk 
		foreign key ( delivery_id )
        	references main.delivery ( delivery_id );

alter table main.pregnancy
    add constraint pregnancy_fluid_fk 
		foreign key ( fluid_id )
        	references main.fluid ( fluid_id );

alter table main.pregnancy
    add constraint pregnancy_mother_fk 
		foreign key ( mother_id )
        	references main.mother ( mother_id );

alter table main.pregnancy
    add constraint pregnancy_multipregnancy_condition_fk 
		foreign key ( multipregnancy_condition_id
    )
        	references main.multipregnancy_condition ( multipregnancy_condition_id );

alter table main.pregnancy
    add constraint pregnancy_multipregnancy_fk 
		foreign key ( multipregnancy_id )
        	references main.multipregnancy ( multipregnancy_id );

alter table main.pregnancy
    add constraint pregnancy_multipregnancy_result_fk 
		foreign key ( multipregnancy_result_id
    )
        	references main.multipregnancy_result ( multipregnancy_result_id );

alter table main.pregnancy
    add constraint pregnancy_presentation_fk 
		foreign key ( presentation_id )
        	references main.presentation ( presentation_id );

alter table main.pregnancy
    add constraint pregnancy_status_fk 
		foreign key ( status_id )
        	references main.status ( status_id );


-- Permissions
revoke all on main.pregnancy from public;

--rollback drop table if exists main.pregnancy;
--liquibase formatted sql




--changeset NP:1 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table if exists main.pregnancy 
	drop constraint if exists pregnancy_presentation_fk
;

--rollback alter table if exists main.pregnancy add constraint pregnancy_presentation_fk foreign key (presentation_id) references main.presentation (presentation_id);



--changeset NP:2 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table main.pregnancy 
	drop column if exists presentation_id
;

--rollback alter table main.pregnancy add column presentation_id smallint;



--changeset NP:3 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table main.child
	add column presentation_id smallint
;

--rollback alter table main.child drop column if exists presentation_id;



--changeset NP:4 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table if exists main.child 
	add constraint child_presentation_fk 
		foreign key (presentation_id) 
			references main.presentation (presentation_id);
;

--rollback alter table if exists main.child drop constraint if exists child_presentation_fk;



--changeset NP:5 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table if exists main.pregnancy 
	drop constraint if exists pregnancy_amniotic_fluid_fk
;

--rollback alter table if exists main.pregnancy add constraint pregnancy_amniotic_fluid_fk foreign key (amniotic_fluid_id) references main.amniotic_fluid (amniotic_fluid_id);



--changeset NP:6 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table main.pregnancy 
	drop column if exists amniotic_fluid_id
;

--rollback alter table main.pregnancy add column amniotic_fluid_id smallint;



--changeset NP:7 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table main.child
	add column amniotic_fluid_id smallint
;

--rollback alter table main.child drop column if exists amniotic_fluid_id;



--changeset NP:8 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table if exists main.child 
	add constraint child_amniotic_fluid_fk 
		foreign key (amniotic_fluid_id) 
			references main.amniotic_fluid (amniotic_fluid_id);
;

--rollback alter table if exists main.child drop constraint if exists child_amniotic_fluid_fk;



--changeset NP:9 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table if exists main.pregnancy 
	drop constraint if exists pregnancy_fluid_fk
;

--rollback alter table if exists main.pregnancy add constraint pregnancy_fluid_fk foreign key (fluid_id) references main.fluid (fluid_id);



--changeset NP:10 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table main.pregnancy 
	drop column if exists fluid_id
;

--rollback alter table main.pregnancy add column fluid_id smallint;



--changeset NP:11 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table main.child
	add column fluid_id smallint
;

--rollback alter table main.child drop column if exists fluid_id;



--changeset NP:12 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table if exists main.child 
	add constraint child_fluid_fk 
		foreign key (fluid_id) 
			references main.fluid (fluid_id);
;

--rollback alter table if exists main.child drop constraint if exists child_fluid_fk;



--changeset NP:13 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table if exists main.child 
	drop column if exists gestation
;

--rollback alter table if exists main.child add column gestation smallint;



--changeset NP:14 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table if exists main.pregnancy 
	add column gestation smallint
;

--rollback alter table if exists main.pregnancy	drop column if exists gestation;
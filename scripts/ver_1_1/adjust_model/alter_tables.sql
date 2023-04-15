--liquibase formatted sql




--changeset NP:1 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table mother
alter table if exists main.mother 
	alter column mother_id 
		add generated always as identity
;

--rollback alter table if exists main.mother alter column mother_id drop identity if exists;



--changeset NP:2 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table main.pregnancy 
	drop constraint if exists pregnancy_multipregnancy_condition_fk
;

--rollback alter table main.pregnancy add constraint pregnancy_multipregnancy_condition_fk foreign key ( multipregnancy_condition_id) references main.multipregnancy_condition ( multipregnancy_condition_id );



--changeset NP:3 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table main.pregnancy 
	drop column if exists multipregnancy_condition_id
;

--rollback alter table main.pregnancy add column multipregnancy_condition_id smallint;



--changeset NP:4 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table main.child
	add column multipregnancy_condition_id smallint
;

--rollback alter table main.child drop column if exists multipregnancy_condition_id;



--changeset NP:5 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table main.child
	add constraint child_multipregnancy_condition_fk 
		foreign key (multipregnancy_condition_id)
			references main.multipregnancy_condition (multipregnancy_condition_id)
;

--rollback alter table main.child drop constraint child_multipregnancy_condition_fk;
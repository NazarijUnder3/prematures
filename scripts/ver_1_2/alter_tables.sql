--liquibase formatted sql




--changeset NP:1 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table if exists main.pregnancy 
	drop constraint if exists pregnancy_compitation_fk
;

--rollback alter table if exists main.pregnancy add constraint pregnancy_compitation_fk foreign key (compitation_id) references main.compitation (compitation_id);



--changeset NP:2 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table pregnancy
alter table main.pregnancy 
	drop column if exists compitation_id
;

--rollback alter table main.pregnancy add column compitation_id smallint;



--changeset NP:3 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table main.child
	add column compitation_id smallint
;

--rollback alter table main.child drop column if exists compitation_id;



--changeset NP:4 labels:alter_table dbms:postgresql context:dev,qa,uat,prod
--comment: alter table child
alter table if exists main.child 
	add constraint child_compitation_fk 
		foreign key (compitation_id) 
			references main.compitation (compitation_id);
;

--rollback alter table if exists main.child drop constraint if exists child_compitation_fk;
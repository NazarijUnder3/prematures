--liquibase formatted sql




--changeset NP:1 labels:insert_data dbms:postgresql context:dev,qa,uat,prod
--comment: insert into alt hospital
insert into main.alt_hospital 
	values (6, 'Мид')
;

--rollback select 1;
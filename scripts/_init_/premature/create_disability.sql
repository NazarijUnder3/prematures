--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table main.leukomalacia



-- Permissions
revoke all on main.leukomalacia from public;

--rollback drop table if exists main.leukomalacia;
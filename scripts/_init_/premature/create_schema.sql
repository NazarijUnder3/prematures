--liquibase formatted sql



--
-- Create schemas
--

--changeset NP:1 labels:create_schema dbms:postgresql context:dev,qa,uat,prod
--comment: create schema main

create schema if not exists main;

comment on schema main is 'Out-of-table main/history logging tables and trigger functions';

grant usage on schema main to main;
grant execute on all functions in schema main to main;
revoke all on schema main from public;

set search_path=main, public;

--rollback not required;



--
-- Create extensions
--

--changeset NP:2 labels:create_extension dbms:postgresql context:dev,qa,uat,prod
--comment: create extension hstore
create extension if not exists hstore with schema public;

--rollback drop extension hstore;
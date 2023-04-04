--liquibase formatted sql



--
-- Create schemas
--

--changeset NP:1 labels:create_schema dbms:postgresql context:dev,qa,uat,prod
--comment: create schema audit

create schema if not exists audit;

comment on schema audit is 'Out-of-table audit/history logging tables and trigger functions';

grant usage on schema audit to audit;
grant execute on all functions in schema audit to audit;
revoke all on schema audit from public;

set search_path=audit, public;

--rollback not required;



--
-- Create extensions
--

--changeset NP:2 labels:create_extension dbms:postgresql context:dev,qa,uat,prod
--comment: create extension hstore
create extension if not exists hstore with schema public;

--rollback drop extension hstore cascade;

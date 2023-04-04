--liquibase formatted sql



--
-- Create schemas
--

--changeset NP:1 labels:create_schema dbms:postgresql context:dev,qa,uat,prod
--comment: create schema main

create schema if not exists main;

comment on schema main is 'Premature tables';

grant usage on schema main to main;
grant execute on all functions in schema main to main;
revoke all on schema main from public;

set search_path=main, public;

--rollback not required;
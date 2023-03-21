--liquibase formatted sql



--
-- Create views
--

--changeset NP:1 labels:create_view dbms:postgresql context:dev,qa,uat,prod
--comment: create view audit.vi_audit_table
create or replace view audit.vi_audit_table as 
    select distinct t.trigger_schema as schema
            , t.event_object_table as controled_table
        from information_schema.triggers t
        where t.trigger_name in ('change_trigger_row', 'change_trigger_stm') 
        order by schema, controled_table
;

comment on view audit.vi_audit_table is 'View all tables with audit set up';

--rollback drop view if exists audit.vi_audit_table;


--changeset NP:2 labels:create_view dbms:postgresql context:dev,qa,uat,prod
--comment: create view audit.vi_audit_trigger_status
create or replace view audit.vi_audit_trigger_status as 
    select  ns.nspname as schema 
            , c.relname as controled_table
            , t.tgname as trigger_name
            , case tgenabled 
                when 'O' then 'ENABLED ORIGIN LOCAL'
                when 'D' then 'DISABLED'
                when 'R' then 'ENABLED IN REPLICA'
                when 'A' then 'ENABLED ALWAYS'
            end as status
        from pg_catalog.pg_trigger t
            inner join pg_catalog.pg_class c on c.oid = t.tgrelid
            inner join pg_catalog.pg_namespace ns on ns.oid = c.relnamespace 
        where t.tgname = any (array['change_trigger_row', 'change_trigger_stm'])
        order by schema, controled_table
;

comment on view audit.vi_audit_trigger_status is 'View the status of the audit triggers';

--rollback drop view if exists audit.vi_audit_trigger_status;


--changeset NP:3 labels:create_view dbms:postgresql context:dev,qa,uat,prod
--comment: create view audit.vi_event
create or replace view audit.vi_event as 
    select event_id, schema_name as schema, object_name as table
            , time_tx, tx_id, tx_status
            , app_name, client_addr, client_query 
            , operation, old_data, new_data
        from audit.change_queue
        order by event_id
;

comment on view audit.vi_event is 'View all events in the event_id order';

--rollback drop view if exists audit.vi_event;
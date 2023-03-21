--liquibase formatted sql



--
-- Create tables
--

--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table audit.change_queue
create table if not exists audit.change_queue (
    event_id bigint generated always as identity 
        (start with 1 increment by 1 cache 500)
    , time_tx timestamp with time zone not null
    , tx_id bigint
    , tx_id_assigned bigint
    , object_id oid not null
    , statement_only boolean not null
    , schema_name varchar(65) not null
    , object_name varchar(65) not null
    , object_type varchar(15) not null
    , user_name varchar(65)
    , tx_status varchar(20)
    , app_name varchar(65)
    , client_addr inet
    , client_port integer
    , operation char(1) not null check (operation in ('I','U','D','T'))
    , old_data hstore
    , new_data hstore
    , client_query text
) partition by range (time_tx);

alter table audit.change_queue
    add constraint change_queue_pk 
        primary key (event_id, time_tx)
;

comment on table  audit.change_queue                is 'History of audit.ble actions on audit.d tables, from audit.if_modified_func()';
comment on column audit.change_queue.event_id       is 'Unique identifier for each audit.ble event';
comment on column audit.change_queue.schema_name    is 'Database schema audit.d table for this event is in';
comment on column audit.change_queue.object_name    is 'Non-schema-qualified table name of table event occured in';
comment on column audit.change_queue.object_id      is 'Table OID. Changes with drop/create. Get with ''tablename''::regclass';
comment on column audit.change_queue.object_type    is 'Type of the object. Set to ''table''';
comment on column audit.change_queue.user_name      is 'Login / session user whose statement caused the audit.d event';
comment on column audit.change_queue.time_tx        is 'Transaction start timestamp for tx in which audit.d event occurred';
comment on column audit.change_queue.tx_id          is 'Identifier of transaction that made the change. May wrap, but unique paired with time_tx';
comment on column audit.change_queue.tx_id_assigned is 'Same as tx_id but returns null instead of assigning a new transaction ID if none is already assigned';
comment on column audit.change_queue.tx_status      is 'Status of the given transaction: committed, aborted, in progress, or null if the transaction ID is too old';
comment on column audit.change_queue.client_addr    is 'IP address of client that issued query. Null for unix domain socket';
comment on column audit.change_queue.client_port    is 'Remote peer IP port address of client that issued query. Undefined for unix socket';
comment on column audit.change_queue.client_query   is 'Top-level query that caused this audit.ble event. May be more than one statement';
comment on column audit.change_queue.app_name       is 'Application name set when this audit.event occurred. Can be changed in-session by client';
comment on column audit.change_queue.operation      is 'Statement type; INSERT, DELETE, UPDATE, TRUNCATE';
comment on column audit.change_queue.old_data       is 'Record value. Null for statement-level trigger. For INSERT this is the new tuple. For DELETE and UPDATE it is the old tuple';
comment on column audit.change_queue.new_data       is 'New values of fields changed by UPDATE. Null except for row-level UPDATE events';
comment on column audit.change_queue.statement_only is '"true" if audit.event is from an FOR EACH STATEMENT trigger, "false" for FOR EACH ROW';

create index changes_tx_status_idx on audit.change_queue(tx_status);

-- Permissions
revoke all on audit.change_queue from public;

--rollback drop table if exists audit.change_queue;



--changeset NP:2 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table audit.track_table_list
create table if not exists audit.track_table_list (
      schema_name varchar(60) not null
    , table_name varchar(60) not null
    , table_process boolean not null default true
    , track_row boolean not null default true
    , track_stm boolean not null default true
    , exclude_column text[] default null
);

alter table audit.track_table_list 
    add constraint track_table_list_pk 
        primary key (schema_name, table_name)
;

comment on table  audit.track_table_list                is 'List of the tables for changes tracking';
comment on column audit.track_table_list.schema_name    is 'Name of the schema';
comment on column audit.track_table_list.table_name     is 'Table name to be tracked';
comment on column audit.track_table_list.table_process  is 'Active?';
comment on column audit.track_table_list.exclude_column is 'List of table columns changes on which will not be tracked';

-- Permissions
revoke all on audit.track_table_list from public;

--rollback drop table if exists audit.track_table_list;

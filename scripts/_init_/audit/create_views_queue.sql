--liquibase formatted sql



--
-- Create views
--

--changeset NP:1 labels:create_view dbms:postgresql context:dev,qa,uat,prod
--comment: create view audit.vi_operation_day
create or replace view audit.vi_operation_day as 
    select date_trunc('day', time_tx)
            , count(*) as cnt
            , round((count(*)::float / 60)::numeric, 0) as per_min
            , count(*) filter(where operation = 'I') as inserts
            , count(*) filter(where operation = 'U') as updates
            , count(*) filter(where operation = 'D') as deletes
            , count(*) filter(where operation = 'T') as truncates
        from audit.change_queue
        group by date_trunc('day', time_tx)
        order by 1
;

comment on view audit.vi_operation_day is 'Events distribution by day and operation';

--rollback drop view if exists audit.vi_operation_day;



--changeset NP:2 labels:create_view dbms:postgresql context:dev,qa,uat,prod
--comment: create view audit.vi_operation_hour
create or replace view audit.vi_operation_hour as 
    select date_trunc('hour', time_tx)
            , count(*) as cnt
            , round((count(*)::float / 60)::numeric, 0) as per_min
            , count(*) filter(where operation = 'INSERT') as inserts
            , count(*) filter(where operation = 'UPDATE') as updates
            , count(*) filter(where operation = 'DELETE') as deletes
            , count(*) filter(where operation = 'TRUNCATE') as truncates
        from audit.change_queue
        group by date_trunc('hour', time_tx)
        order by 1
    ;

comment on view audit.vi_operation_hour is 'Events distribution by hour and operation';

--rollback drop view if exists audit.vi_operation_hour;



--changeset NP:3 labels:create_view dbms:postgresql context:dev,qa,uat,prod
--comment: create view audit.vi_queue_event_total
create or replace view audit.vi_queue_event_total as 
    select count(*) 
        from audit.change_queue
    ;

comment on view audit.vi_queue_event_total is 'Total number of events';

--rollback drop view if exists audit.vi_queue_event_total;



--changeset NP:4 labels:create_view dbms:postgresql context:dev,qa,uat,prod
--comment: create view audit.vi_queue_event_tx_status
create or replace view audit.vi_queue_event_tx_status as 
    select tx_status, count(*)
        from audit.change_queue
        group by tx_status
    ;

comment on view audit.vi_queue_event_tx_status is 'Events distribution by transactions status on PG';

--rollback drop view if exists audit.vi_queue_event_tx_status;



--changeset NP:6 labels:create_view dbms:postgresql context:dev,qa,uat,prod
--comment: create view audit.vi_queue_tx_total
create or replace view audit.vi_queue_tx_total as 
    with transactions as (
        select distinct tx_id
            from audit.change_queue 
    )
    select count(*) tx_total
        from audit.change_queue
    ;

comment on view audit.vi_queue_tx_total is 'Total number of transaction';

--rollback drop view if exists audit.vi_queue_tx_total;



--changeset NP:7 labels:create_view dbms:postgresql context:dev,qa,uat,prod
--comment: create view audit.vi_queue_tx_count
create or replace view audit.vi_queue_tx_count as 
    with transactions as (
        select distinct tx_id, tx_status
            from audit.change_queue 
    )
    select tx_status, count(*)
        from transactions
        group by tx_status
    ;

comment on view audit.vi_queue_tx_count is 'Events distribution by transactions status on PG';

--rollback drop view if exists audit.vi_queue_tx_count;



--changeset NP:9 labels:create_view dbms:postgresql context:dev,qa,uat,prod
--comment: create view audit.vi_queue_tx_big
create or replace view audit.vi_queue_tx_big as 
    select object_name, time_tx, tx_id, tx_status, operation, client_query, count(*)
        from audit.change_queue ac 
        group by object_name, time_tx, tx_id, tx_status, operation, client_query
            having count(*) > 100
        order by object_name, time_tx, tx_id, tx_status, operation, client_query
    ;

comment on view audit.vi_queue_tx_big is 'Transactions with more than 100 changes';

--rollback drop view if exists audit.vi_queue_tx_big;



--changeset NP:10 labels:create_view dbms:postgresql context:dev,qa,uat,prod
--comment: create view audit.vi_queue_tx_change_count
create or replace view audit.vi_queue_tx_change_count as 
    with transactions as (
        select tx_id, count(*) as change_vectors
            from audit.change_queue
            group by tx_id
        )
    select change_vectors as changes_per_tx
            , coalesce(count(change_vectors), 0) as total
        from transactions 
        group by change_vectors 
        order by 1
    ;

comment on view audit.vi_queue_tx_change_count is 'Histogram of number of change vectors in transaction';

--rollback drop view if exists audit.vi_queue_tx_change_count;



--changeset NP:11 labels:create_view dbms:postgresql context:dev,qa,uat,prod
--comment: create view audit.vi_queue_tx_huge
create or replace view audit.vi_queue_tx_huge as 
    with 
        transactions as (
            select tx_id, count(*) as change_vectors
                from audit.change_queue
                group by tx_id
            )
    select object_name, time_tx, tx_id, client_addr, client_query 
        from audit.change_queue
        where tx_id in (
                        select distinct tx_id
                            from transactions 
                            where change_vectors >= 1000
                        )
        order by time_tx
    ;

comment on view audit.vi_queue_tx_huge is 'Transaction with more thant 1000 changes';

--rollback drop view if exists audit.vi_queue_tx_huge;

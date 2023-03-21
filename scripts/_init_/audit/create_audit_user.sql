--
-- Create roles
--

create role cdc with 
	nosuperuser
	nocreatedb
	nocreaterole
	noinherit
	login
	noreplication
	nobypassrls
	connection limit -1
;

alter user cdc password 'cDc4sqlDB';

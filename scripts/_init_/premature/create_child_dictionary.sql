--liquibase formatted sql



--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.pcr
create table if not exists main.pcr (
    pcr_id   smallint not null,
    pcr_name varchar not null
);

comment on table main.pcr is
    'PCR analysis';

alter table main.pcr 
	add constraint pcr_pk
		primary key ( pcr_id );

alter table main.pcr 
	add constraint pcr_pcr_name_un 
		unique ( pcr_name );

-- Permissions
revoke all on main.pcr from public;

--rollback drop table if exists main.pcr;


--changeset NP:2 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.pcr
insert 
	into main.pcr
	values
		(1, 'отрицательный')
		, (2, 'ЦМВ')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.rt_kfg
create table if not exists main.rt_kfg (
    rt_kfg_id   smallint not null,
    rt_kfg_name varchar not null
);

comment on table main.rt_kfg is
    'Birth injury\cephalohematoma';

alter table main.rt_kfg 
	add constraint rt_kfg_pk
		primary key ( rt_kfg_id );

alter table main.rt_kfg 
	add constraint rt_kfg_rt_kfg_name_un 
		unique ( rt_kfg_name );

-- Permissions
revoke all on main.rt_kfg from public;

--rollback drop table if exists main.rt_kfg;


--changeset NP:4 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.rt_kfg
insert 
	into main.rt_kfg
	values
		(1, 'нет')
		, (2, 'КФГ')
		, (3, 'РТ')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.hospital
create table if not exists main.hospital (
    hospital_id   smallint not null,
    hospital_name varchar not null
);

comment on table main.hospital is
    'List of hospitals';

alter table main.hospital 
	add constraint hospital_pk
		primary key ( hospital_id );

alter table main.hospital 
	add constraint hospital_hospital_name_un 
		unique ( hospital_name );

-- Permissions
revoke all on main.hospital from public;

--rollback drop table if exists main.hospital;


--changeset NP:6 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.hospital
insert 
	into main.hospital
	values
		(1, 'Роддом №1')
		, (2, 'Роддом №2')
		, (3, 'Роддом №3')
		, (4, 'Роддом №5')
		, (5, 'Роддом №6')
		, (6, 'Роддом №7 (МиД)')
		, (7, 'Клинический родильный дом Минской области')
		, (8, 'Роддом Молодечно')
		, (9, 'Роддом Борисов')
		, (10, 'Роддом Солигорск')
		, (11, 'Брестский областной родильный дом')
		, (12, 'Роддом Пинск')
		, (13, 'Роддом Кобрин')
		, (14, 'Роддом Барановичи')
		, (15, 'Роддом г. Берёза')
		, (16, 'Роддом Орша')
		, (17, 'Родильный дом города Новополоцка')
		, (18, 'Областной роддом Гомеля')
		, (19, 'Гомельская городская клиническая больница № 2')
		, (20, 'Роддом Речица')
		, (21, 'Роддом Мозырь')
		, (22, 'Роддом Светлогорск')
		, (23, 'Роддом Рогачев')
		, (24, 'Роддом Калинковичи')
		, (25, 'Роддом Жлобин')
		, (26, 'Больница скорой медицинской помощи')
		, (27, 'Областной роддом Гродно')
		, (28, 'Слонимская центральная районная больница')
		, (29, 'Роддом при УЗ "Могилевская городская больница скорой медицинской помощи"')
		, (30, 'Могилевская больница №1')
		, (31, 'Роддом Бобруйск')
		, (32, 'Роддом №1 Витебск (ВОРД)')
		, (33, 'Роддом №2 Витебск')
		, (34, 'Роддом №3 Витебск')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:7 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.reflex
create table if not exists main.reflex (
    reflex_id   smallint not null,
    reflex_name varchar not null
);

comment on table main.reflex is
    'Reflexes';

alter table main.reflex 
	add constraint reflex_pk
		primary key ( reflex_id );

alter table main.reflex 
	add constraint reflex_reflex_name_un 
		unique ( reflex_name );

-- Permissions
revoke all on main.reflex from public;

--rollback drop table if exists main.reflex;


--changeset NP:8 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.reflex
insert 
	into main.reflex
	values
		(1, 'высокие')
		, (2, 'повышенные')
		, (3, 'соответствуют')
		, (4, 'угнетение ЦНС')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:9 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.white_body
create table if not exists main.white_body (
    white_body_id   smallint not null,
    white_body_name varchar not null
);

alter table main.white_body 
	add constraint white_body_pk
		primary key ( white_body_id );

alter table main.white_body 
	add constraint white_body_white_body_name_un 
		unique ( white_body_name );

-- Permissions
revoke all on main.white_body from public;

--rollback drop table if exists main.white_body;


--changeset NP:10 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.white_body
insert 
	into main.white_body
	values
		(1, 'нет')
		, (2, 'ПВЛ')
		, (3, 'переходная стадия')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:11 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.locality
create table if not exists main.locality (
    locality_id        smallint not null
    , locality_name      varchar not null
    , locality_parent_id smallint
);

alter table main.locality 
	add constraint locality_pk 
		primary key ( locality_id );

alter table main.locality 
	add constraint locality_locality_name_un 
		unique ( locality_name
);

alter table main.locality
    add constraint locality_locality_fk 
		foreign key ( locality_parent_id )
			references main.locality ( locality_id );

-- Permissions
revoke all on main.locality from public;

--rollback drop table if exists main.locality;


--changeset NP:12 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.locality
insert 
	into main.locality
	values
		(0, 'РБ', NULL)
		, (5, 'Минская область', 0)
		, (7, 'город Минск', 0)
		, (8, 'Березино', 5)
		, (9, 'Борисов', 5)
		, (10, 'Вилейка', 5)
		, (11, 'Воложин', 5)
		, (12, 'Дзержинск', 5)
		, (13, 'Клецк', 5)
		, (14, 'Копыль', 5)
		, (15, 'Крупки', 5)
		, (16, 'Логойск', 5)
		, (17, 'Любань', 5)
		, (18, 'Молодечно', 5)
		, (19, 'Мядель', 5)
		, (20, 'Несвиж', 5)
		, (21, 'Марьина Горка', 5)
		, (22, 'Слуцк', 5)
		, (23, 'Смолевичи', 5)
		, (24, 'Солигорск', 5)
		, (25, 'Старые Дороги', 5)
		, (26, 'Столбцы', 5)
		, (27, 'Узда', 5)
		, (28, 'Червень', 5)
		, (29, 'Жодино', 5)
		, (3, 'Гомельская область', 0)
		, (30, 'город Гомель', 3)
		, (31, 'Брагин', 3)
		, (32, 'Буда-Кошелево', 3)
		, (33, 'Ветка', 3)
		, (34, 'Добруш', 3)
		, (35, 'Ельск', 3)
		, (36, 'Житковичи', 3)
		, (37, 'Жлобин', 3)
		, (38, 'Калинковичи', 3)
		, (39, 'Корма', 3)
		, (40, 'Лельчицы', 3)
		, (41, 'Лоев', 3)
		, (42, 'Мозырь', 3)
		, (43, 'Наровля', 3)
		, (44, 'Октябрьский', 3)
		, (45, 'Петриков', 3)
		, (46, 'Речица', 3)
		, (47, 'Рогачев', 3)
		, (48, 'Светлогорск', 3)
		, (49, 'Чечерск', 3)
		, (50, 'Хойники', 3)
		, (4, 'Гродненская область', 0)
		, (51, 'город Гродно', 4)
		, (52, 'Б.Берестовица', 4)
		, (53, 'Волковыск', 4)
		, (54, 'Вороново', 4)
		, (55, 'Дятлово', 4)
		, (56, 'Зельва', 4)
		, (57, 'Ивье', 4)
		, (58, 'Кореличи', 4)
		, (59, 'Лида', 4)
		, (60, 'Мосты', 4)
		, (61, 'Новогрудок', 4)
		, (62, 'Ошмяны', 4)
		, (63, 'Островец', 4)
		, (64, 'Свислочь', 4)
		, (65, 'Слоним', 4)
		, (66, 'Сморгонь', 4)
		, (67, 'Щучин', 4)
		, (1, 'Брестская область', 0)
		, (68, 'город Брест', 1)
		, (69, 'Барановичи', 1)
		, (70, 'Береза', 1)
		, (71, 'Ганцевичи', 1)
		, (72, 'Дрогичин', 1)
		, (73, 'Жабинка', 1)
		, (74, 'Иваново', 1)
		, (75, 'Ивацевичи', 1)
		, (76, 'Каменец', 1)
		, (77, 'Кобрин', 1)
		, (78, 'Лунинец', 1)
		, (79, 'Ляховичы', 1)
		, (80, 'Малорита', 1)
		, (81, 'Пинск', 1)
		, (82, 'Пружаны', 1)
		, (83, 'Столин', 1)
		, (2, 'Витебская', 0)
		, (84, 'область', 2)
		, (85, 'Браслав', 2)
		, (86, 'Бешенковичи', 2)
		, (87, 'Верхнедвинск', 2)
		, (88, 'Глубокое', 2)
		, (89, 'Городок', 2)
		, (90, 'Докшицы', 2)
		, (91, 'Дубровно', 2)
		, (92, 'Лепель', 2)
		, (93, 'Лиозно', 2)
		, (94, 'Миоры', 2)
		, (95, 'Орша', 2)
		, (96, 'Полоцк', 2)
		, (97, 'Поставы', 2)
		, (98, 'Россоны', 2)
		, (99, 'Сенно', 2)
		, (100, 'Толочин', 2)
		, (101, 'Ушачи', 2)
		, (102, 'Чашники', 2)
		, (103, 'Шарковщина', 2)
		, (104, 'Шумилино', 2)
		, (6, 'Могилевская область', 0)
		, (105, 'город Могилев', 6)
		, (106, 'Белыничи', 6)
		, (107, 'Бобруйск', 6)
		, (108, 'Быхов', 6)
		, (109, 'Горки', 6)
		, (110, 'Глуск', 6)
		, (111, 'Дрибин', 6)
		, (112, 'Кировск', 6)
		, (113, 'Климовичи', 6)
		, (114, 'Кличев', 6)
		, (115, 'Костюковичи', 6)
		, (116, 'Краснополье', 6)
		, (117, 'Кричев', 6)
		, (118, 'Круглое', 6)
		, (119, 'Мстиславль', 6)
		, (120, 'Осиповичи', 6)
		, (121, 'Славгород', 6)
		, (122, 'Хотимск', 6)
		, (123, 'Чаусы', 6)
		, (124, 'Чериков', 6)
		, (125, 'Шклов', 6)
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:13 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.sepsis_ethiology
create table if not exists main.sepsis_ethiology (
    sepsis_ethiology_id   smallint not null,
    sepsis_ethiology_name varchar not null
);

comment on table main.sepsis_ethiology is
    'Etiology of sepsis\intrauterine (congenital) infections';

alter table main.sepsis_ethiology 
	add constraint sepsis_ethiology_pk
		primary key ( sepsis_ethiology_id );

alter table main.sepsis_ethiology 
	add constraint sepsis_ethiology_sepsis_ethiology_name_un 
		unique ( sepsis_ethiology_name );

-- Permissions
revoke all on main.sepsis_ethiology from public;

--rollback drop table if exists main.sepsis_ethiology;


--changeset NP:14 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.sepsis_ethiology
insert 
	into main.sepsis_ethiology
	values
		(1, 'БДУ')
		, (2, 'ЦМВ')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:15 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.convulsion
create table if not exists main.convulsion (
    convulsion_id   smallint not null,
    convulsion_name varchar not null
);

comment on table main.convulsion is
    'Convulsions';

alter table main.convulsion 
	add constraint convulsion_pk
		primary key ( convulsion_id );

alter table main.convulsion 
	add constraint convulsion_convulsion_name_un 
		unique ( convulsion_name );

-- Permissions
revoke all on main.convulsion from public;

--rollback drop table if exists main.convulsion;


--changeset NP:16 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.convulsion
insert 
	into main.convulsion
	values
		(1, 'нет')
		, (2, 'АСН')
		, (3, 'СС')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:17 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.sepsis
create table if not exists main.sepsis (
    sepsis_id   smallint not null,
    sepsis_name varchar not null
);

comment on table main.sepsis is
    'Intrauterine (congenital) infections\sepsis';

alter table main.sepsis 
	add constraint sepsis_pk
		primary key ( sepsis_id );

alter table main.sepsis 
	add constraint sepsis_sepsis_name_un 
		unique ( sepsis_name );

-- Permissions
revoke all on main.sepsis from public;

--rollback drop table if exists main.sepsis;


--changeset NP:18 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.sepsis
insert 
	into main.sepsis
	values
		(1, 'нет')
		, (2, 'ВУИ')
		, (3, 'ВУИ, сепсис')
		, (4, 'ВУИ, сепсис, НЭК')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:19 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.eco
create table if not exists main.eco (
    eco_id    smallint not null,
    eco_name  varchar not null,
    "comment" varchar
);

comment on table main.eco is
    'In vitro fertilization';

alter table main.eco 
	add constraint eco_pk
		primary key ( eco_id );

alter table main.eco 
	add constraint eco_eco_name_un 
		unique ( eco_name );

-- Permissions
revoke all on main.eco from public;

--rollback drop table if exists main.eco;


--changeset NP:20 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.eco
insert 
	into main.eco
	values
		(1, '1-я')
		, (2, '2-я')
		, (3, '3-я')
		, (4, '6-я')
		, (5, 'ЭКО БДУ')
		, (6, 'нет')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:21 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.gender
create table if not exists main.gender (
    gender_id   smallint not null,
    gender_name varchar not null
);

comment on table main.gender is
    'Genders';

alter table main.gender 
	add constraint gender_pk
		primary key ( gender_id );

alter table main.gender 
	add constraint gender_gender_name_un 
		unique ( gender_name );

-- Permissions
revoke all on main.gender from public;

--rollback drop table if exists main.gender;


--changeset NP:22 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.gender
insert 
	into main.gender
	values
		(1, 'М')
		, (2, 'Ж')
	on conflict 
		do nothing
;

--rollback select 1;
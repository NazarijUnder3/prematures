--liquibase formatted sql



--changeset NP:1 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.vision
create table if not exists main.vision (
    vision_id   smallint not null,
    vision_name varchar not null
);

alter table main.vision 
	add constraint vision_pk
		primary key ( vision_id );

alter table main.vision 
	add constraint vision_vision_name_un 
		unique ( vision_name );

-- Permissions
revoke all on main.vision from public;

--rollback drop table if exists main.vision;


--changeset NP:2 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.vision
insert 
	into main.vision
	values
		(1, 'норма')
		, (2, 'колобомы')
		, (3, 'РПН')
		, (4, 'ЧАЗН, косоглазие')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:3 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.git
create table if not exists main.git (
    git_id   smallint not null,
    git_name varchar not null
);

comment on table main.git is
    'Gastrointestinal tract';

alter table main.git 
	add constraint git_pk
		primary key ( git_id );

alter table main.git 
	add constraint git_git_name_un 
		unique ( git_name );

-- Permissions
revoke all on main.git from public;

--rollback drop table if exists main.git;


--changeset NP:4 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.git
insert 
	into main.git
	values
		(1, 'норма')
		, (2, 'БДУ')
		, (3, 'парез кишечника')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:5 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.rf
create table if not exists main.rf (
    rf_id   smallint not null,
    rf_name varchar not null
);

alter table main.rf 
	add constraint rf_pk
		primary key ( rf_id );

alter table main.rf 
	add constraint rf_rf_name_un 
		unique ( rf_name );

-- Permissions
revoke all on main.rf from public;

--rollback drop table if exists main.rf;


--changeset NP:6 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.rf
insert 
	into main.rf
	values
		(1, 'норма')
		, (2, 'НРР')
		, (3, 'ЗРР')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:7 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.bs
create table if not exists main.bs (
    bs_id   smallint not null,
    bs_name varchar not null
);

alter table main.bs 
	add constraint bs_pk
		primary key ( bs_id );

alter table main.bs 
	add constraint bs_bs_name_un 
		unique ( bs_name );

-- Permissions
revoke all on main.bs from public;

--rollback drop table if exists main.bs;


--changeset NP:8 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.bs
insert 
	into main.bs
	values
		(1, 'норма')
		, (2, 'нет')
		, (3, 'БДУ')
		, (4, 'ДТС')
		, (5, 'контрактуры')
		, (6, 'микроцефалия')
		, (7, 'ЭВС, контрактуры')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:9 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.mrt
create table if not exists main.mrt (
    mrt_id   smallint not null,
    mrt_name varchar not null
);

comment on table main.mrt is
    'MRT scan';

alter table main.mrt 
	add constraint mrt_pk
		primary key ( mrt_id );

alter table main.mrt 
	add constraint mrt_mrt_name_un 
		unique ( mrt_name );

-- Permissions
revoke all on main.mrt from public;

--rollback drop table if exists main.mrt;


--changeset NP:10 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.mrt
insert 
	into main.mrt
	values
		(1, 'норма')
		, (2, 'не выполняли')
		, (3, 'БДУ')
		, (4, 'ПВГ, РПСАП')
		, (5, 'ПВЛ, АРБЖ')
		, (6, 'РЖС')
		, (7, 'ЭМЛ')
		, (8, 'ПВ кистозная трансформация, РПСАП, ВМГ')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:11 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.ct
create table if not exists main.ct (
    ct_id   smallint not null,
    ct_name varchar not null
);

comment on table main.ct is
    'CT scan';

alter table main.ct 
	add constraint ct_pk
		primary key ( ct_id );

alter table main.ct 
	add constraint ct_ct_name_un 
		unique ( ct_name );

-- Permissions
revoke all on main.ct from public;

--rollback drop table if exists main.ct;


--changeset NP:12 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.ct
insert 
	into main.ct
	values
		(1, 'норма')
		, (2, 'не выполняли')
		, (3, 'БДУ')
		, (4, 'ЛМ, РПСАП, киста ПП')
		, (5, 'мульти кистозная трансформация')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:13 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.skin
create table if not exists main.skin (
    skin_id   smallint not null,
    skin_name varchar not null
);

comment on table main.skin is
    'Skin, stigmas';

alter table main.skin 
	add constraint skin_pk
		primary key ( skin_id );

alter table main.skin 
	add constraint skin_skin_name_un 
		unique ( skin_name );

-- Permissions
revoke all on main.skin from public;

--rollback drop table if exists main.skin;


--changeset NP:14 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.skin
insert 
	into main.skin
	values
		(1, 'норма')
		, (2, 'нет')
		, (3, 'БДУ')
		, (4, 'гемангиома')
		, (5, 'ГЭРБ, БЭН')
		, (6, 'Вр. папиллома шеи')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:15 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.hearing
create table if not exists main.hearing (
    hearing_id   smallint not null,
    hearing_name varchar not null
);

alter table main.hearing 
	add constraint hearing_pk
		primary key ( hearing_id );

alter table main.hearing 
	add constraint hearing_hearing_name_un 
		unique ( hearing_name );

-- Permissions
revoke all on main.hearing from public;

--rollback drop table if exists main.hearing;


--changeset NP:16 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.hearing
insert 
	into main.hearing
	values
		(1, 'норма')
		, (2, 'нет')
		, (3, 'БДУ')
		, (4, 'нарушение')
		, (5, 'Хр.НСТ')
		, (6, 'Хр.НСТ 1 ст. справа')
		, (7, 'Хр.НСТ 4 ст. справа')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:17 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.physical
create table if not exists main.physical (
    physical_id   smallint not null,
    physical_name varchar not null
);

comment on table main.physical is
    'Motor disability';

alter table main.physical 
	add constraint physical_pk
		primary key ( physical_id );

alter table main.physical 
	add constraint physical_physical_name_un 
		unique ( physical_name );

-- Permissions
revoke all on main.physical from public;

--rollback drop table if exists main.physical;


--changeset NP:18 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.physical
insert 
	into main.physical
	values
		(1, 'нет')
		, (2, 'сп.парез')
		, (3, 'ДЦП')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:19 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.strabismus
create table if not exists main.strabismus (
    strabismus_id   smallint not null,
    strabismus_name varchar not null
);

comment on table main.strabismus is
    'Strabismus';

alter table main.strabismus 
	add constraint strabismus_pk
		primary key ( strabismus_id );

alter table main.strabismus 
	add constraint strabismus_strabismus_name_un 
		unique ( strabismus_name );

-- Permissions
revoke all on main.strabismus from public;

--rollback drop table if exists main.strabismus;


--changeset NP:20 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.strabismus
insert 
	into main.strabismus
	values
		(1, 'нет')
		, (2, 'да')
		, (3, 'ЧАЗН')
		, (4, 'ЧАЗН, косоглазие')
		, (5, 'ЧАЗН, косоглазие, оперир.глаукома')
		, (6, 'астигматизм')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:21 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.pf
create table if not exists main.pf (
    pf_id   smallint not null,
    pf_name varchar not null
);

alter table main.pf 
	add constraint pf_pk
		primary key ( pf_id );

alter table main.pf 
	add constraint pf_pf_name_un 
		unique ( pf_name );

-- Permissions
revoke all on main.pf from public;

--rollback drop table if exists main.pf;


--changeset NP:22 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.pf
insert 
	into main.pf
	values
		(1, 'норма')
		, (2, 'НПФ')
		, (3, 'РАС')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:23 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.disorder_kind
create table if not exists main.disorder_kind (
    disorder_kind_id   smallint not null
    , disorder_kind_name varchar not null
);

comment on table main.disorder_kind is
    'Nature of violations';

alter table main.disorder_kind add constraint disorder_kind_pk 
		primary key ( disorder_kind_id );

alter table main.disorder_kind add constraint disorder_kind_disorder_kind_name_un 
		unique ( disorder_kind_name );

-- Permissions
revoke all on main.disorder_kind from public;

--rollback drop table if exists main.disorder_kind;


--changeset NP:24 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.disorder_kind
insert 
	into main.disorder_kind
	values
		(1, 'норма')
		, (2, 'нарушение сна')
		, (3, 'РДН, нарешуние сна')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:25 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.sse
create table if not exists main.sse (
    sse_id   smallint not null,
    sse_name varchar not null
);

alter table main.sse 
	add constraint sse_pk
		primary key ( sse_id );

alter table main.sse 
	add constraint sse_sse_name_un 
		unique ( sse_name );

-- Permissions
revoke all on main.sse from public;

--rollback drop table if exists main.sse;


--changeset NP:26 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.sse
insert 
	into main.sse
	values
		(1, 'нет')
		, (2, 'СС')
		, (3, 'Э')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:27 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.gc
create table if not exists main.gc (
    gc_id   smallint not null,
    gc_name varchar not null
);

alter table main.gc 
	add constraint gc_pk
		primary key ( gc_id );

alter table main.gc 
	add constraint gc_gc_name_un 
		unique ( gc_name );

-- Permissions
revoke all on main.gc from public;

--rollback drop table if exists main.gc;


--changeset NP:28 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.gc
insert 
	into main.gc
	values
		(1, 'нет')
		, (2, 'ГЦ')
		, (3, 'ГЦ, ВПШ')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:29 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.mps
create table if not exists main.mps (
    mps_id   smallint not null,
    mps_name varchar not null
);

alter table main.mps 
	add constraint mps_pk
		primary key ( mps_id );

alter table main.mps 
	add constraint mps_mps_name_un 
		unique ( mps_name );

-- Permissions
revoke all on main.mps from public;

--rollback drop table if exists main.mps;


--changeset NP:30 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.mps
insert 
	into main.mps
	values
		(1, 'нет')
		, (2, 'норма')
		, (3, 'БДУ')
		, (4, 'гидроцеле')
		, (5, 'гипоспадия, варикоцеле')
		, (6, 'каликоэктазия')
		, (7, 'кальцинат почки')
		, (8, 'крипторхизм')
		, (9, 'крипторхизм, нефрокальциноз')
		, (10, 'мегауретр')
		, (11, 'МКБ; конкремент почки')
		, (12, 'паховая грыжа')
		, (13, 'пиелокаликоэктазия')
		, (14, 'пиелоэктазия')
		, (15, 'пиелоэктазия, гидроцеле')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:31 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.ims
create table if not exists main.ims (
    ims_id   smallint not null,
    ims_name varchar not null
);

alter table main.ims 
	add constraint ims_pk
		primary key ( ims_id );

alter table main.ims 
	add constraint ims_ims_name_un 
		unique ( ims_name );

-- Permissions
revoke all on main.ims from public;

--rollback drop table if exists main.ims;


--changeset NP:32 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.ims
insert 
	into main.ims
	values
		(1, 'Вт. иммунодефицит')
		, (2, 'норма')
		, (3, 'БДУ')
		, (4, 'ГТ, недост-сть гумор. иммунитета')
		, (5, 'дисбаланс иммунологической реактивности')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:33 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.es
create table if not exists main.es (
    es_id   smallint not null,
    es_name varchar not null
);

alter table main.es 
	add constraint es_pk
		primary key ( es_id );

alter table main.es 
	add constraint es_es_name_un 
		unique ( es_name );

-- Permissions
revoke all on main.es from public;

--rollback drop table if exists main.es;


--changeset NP:34 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.es
insert 
	into main.es
	values
		(1, 'нет')
		, (2, 'норма')
		, (3, 'БДУ')
		, (4, 'субклинич.гипотиреоз')
		, (5, 'гипоплазия тимуса')
		, (6, 'ГЩЖ')
		, (7, 'ГЩЖ, врожд.гипотиреоз')
		, (8, 'ГЩЖ, субклинич.гипотиреоз')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:35 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.disorder_type
create table if not exists main.disorder_type (
    disorder_type_id   smallint not null,
    disorder_type_name varchar not null
);

comment on table main.disorder_type is
    'List of disorders';

alter table main.disorder_type 
	add constraint disorder_type_pk
		primary key ( disorder_type_id );

alter table main.disorder_type 
	add constraint disorder_type_disorder_type_name_un 
		unique ( disorder_type_name );

-- Permissions
revoke all on main.disorder_type from public;

--rollback drop table if exists main.disorder_type;


--changeset NP:36 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.disorder_type
insert 
	into main.disorder_type
	values
		(1, 'БНН')
		, (2, 'НН')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:37 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.slf
create table if not exists main.slf (
    slf_id   smallint not null,
    slf_name varchar not null
);

alter table main.slf 
	add constraint slf_pk
		primary key ( slf_id );

alter table main.slf 
	add constraint slf_slf_name_un 
		unique ( slf_name );

-- Permissions
revoke all on main.slf from public;

--rollback drop table if exists main.slf


--changeset NP:38 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.slf
insert 
	into main.slf
	values
		(1, 'нет')
		, (2, 'не вертикализирован')
		, (3, 'АС')
	on conflict 
		do nothing
;

--rollback select 1;



--changeset NP:39 labels:create_table dbms:postgresql context:dev,qa,uat,prod
--comment: create table if not exists main.cvs
create table if not exists main.cvs (
    cvs_id   smallint not null,
    cvs_name varchar not null
);

alter table main.cvs 
	add constraint cvs_pk
		primary key ( cvs_id );

alter table main.cvs 
	add constraint cvs_cvs_name_un 
		unique ( cvs_name );

-- Permissions
revoke all on main.cvs from public;

--rollback drop table if exists main.cvs


--changeset NP:40 labels:fill_table dbms:postgresql context:dev,qa,uat,prod
--comment: fill table main.cvs
insert 
	into main.cvs
	values
		(1, 'нет')
		, (2, 'норма')
		, (3, 'анемия')
		, (4, 'ВПС')
		, (5, 'ВПС, анемия')
		, (6, 'ВПС, ДМПП')
		, (7, 'ВПС, ДМПП, анемия')
		, (8, 'ВПС: оперирован')
		, (9, 'декстракардия')
		, (10, 'ДХЛЖ')
		, (11, 'МАРС')
		, (12, 'МАРС, анемия')
		, (13, 'МАРС, ДЖЛЖ')
		, (14, 'МАРС: ООО, ДХЛЖ')
		, (15, 'ООО')
		, (16, 'ООО, анемия')
	on conflict 
		do nothing
;

--rollback select 1;
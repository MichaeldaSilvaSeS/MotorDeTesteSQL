if exists (select 'X' from sysobjects where name = 'TBIR9950' and type  = 'U')
	drop table TBIR9950
go

create table TBIR9950(
	cod_err int,
	des_err varchar(30),
	primary key(cod_err)
)
go

-- falharTeste ou vencerTeste
if exists (select 'X' from sysobjects where name = 'TBIR9951' and type  = 'U')
	drop table TBIR9951
go

create table TBIR9951(
	cod_exe int,
	cod_tst varchar(30) null,
	cod_ord int null,
	flg_tst char(1),
	des_msg varchar(30),
	dat_exe smalldatetime,
	cod_seq int
)
go

-- criarPlano
if exists (select 'X' from sysobjects where name = 'TBIR9952' and type  = 'U')
	drop table TBIR9952
go

create table TBIR9952(
	cod_pln_tst  int,
	desc_pln_tst varchar(30),
	primary key(cod_pln_tst, desc_pln_tst)
)
go

if exists (select 'X' from sysobjects where name = 'TBIR9953' and type  = 'U')
	drop table TBIR9953
go

create table TBIR9953(
	cod_pln_tst  int,
	desc_pln_tst varchar(30),
	cod_exe      int,
	dat_ini      smalldatetime,
	dat_fim      smalldatetime null,
	primary key(cod_pln_tst,cod_exe)
)
go

-- adicionarTeste
if exists (select 'X' from sysobjects where name = 'TBIR9954' and type  = 'U')
	drop table TBIR9954
go

create table TBIR9954(
	cod_pln_tst  int,
	cod_tst      varchar(30),
	cod_ord      int
)
go
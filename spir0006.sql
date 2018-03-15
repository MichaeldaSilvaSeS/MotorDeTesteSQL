if exists (select 'X' from sysobjects where name = 'teste' and type  = 'P')
	drop procedure teste
go

create procedure teste
	@cod_exe int = -1 in
as
begin
	exec vencerTeste @cod_exe, 'Sucesso'
	exec falharTeste @cod_exe, 0, 'Falha'
end
go

if exists (select 'X' from sysobjects where name = 'abc' and type  = 'U')
	drop table abc
go

create table abc (
	id   int,
	des varchar(30)
)

insert into abc values (1,'desc1')
insert into abc values (2,'desc2')
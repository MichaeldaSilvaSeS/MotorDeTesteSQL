if exists (select 'X' from sysobjects where name = 'TBIR0099' and type  = 'U')
	drop table TBIR0099
go

create table TBIR0099 (
	id  int,
	des varchar(30),
	dat smalldatetime null,
	primary key(id)
)
go

if exists (select 'X' from sysobjects where name = 'TIIR0099' and type  = 'TR')
	drop  trigger TIIR0099
go

create trigger TIIR0099
on TBIR0099 
for insert
as
begin
	update TBIR0099 set dat = getdate() where id in (select id from inserted)
end
go

if exists (select 'X' from sysobjects where name = 'teste' and type  = 'P')
	drop procedure teste
go

create procedure teste
	@cod_exe int = -1 in
as
begin
	insert into TBIR0099(id,des) values (1,'desc1')
	if @@error = 0
		exec vencerTeste @cod_exe, 'Sucesso'
	else
		exec falharTeste @cod_exe, 0, 'Falha'
end
go

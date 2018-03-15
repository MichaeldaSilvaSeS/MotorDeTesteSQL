
if exists (select 'X' from sysobjects where name = 'vencerTeste' and type  = 'P')
	drop procedure vencerTeste
go

create procedure vencerTeste
	@cod_exe  int = -1 in,
	@des_msg  varchar(30) = '' in
as
begin
	declare
		@des_msg_atu varchar(30),
		@cod_seq     int
	
	select @cod_seq = 1

	if @cod_exe <= -1 or not exists(select 'X' from TBIR9953 where cod_exe = @cod_exe)
	begin
		raiserror 99999 'Codigo da execucao nao preenchido'
		return -1
	end

	if @des_msg <> ''
	begin
		select @des_msg_atu = @des_msg
	end
	else
	begin
		select @des_msg_atu = 'Sucesso na execucao'
	end
	
	select @cod_seq = (isnull(max(cod_seq),0)+1) from TBIR9951 where cod_exe = @cod_exe

	insert into TBIR9951
		(cod_exe, flg_tst, des_msg, dat_exe, cod_seq)
	values
		(@cod_exe, 'S', @des_msg_atu, getdate(), @cod_seq)
end
go

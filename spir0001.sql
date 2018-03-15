
if exists (select 'X' from sysobjects where name = 'falharTeste' and type  = 'P')
	drop procedure falharTeste
go	

create procedure falharTeste
	@cod_exe int = -1 in,
	@cod_err int = -1 in,
	@des_err varchar(30) = '' in,
	@thr_exp char(1) = 'N' in
as
begin
	declare
		@des_err_atu varchar(30),
		@cod_seq     int
	
	select @cod_seq = 1

	if @cod_exe <= -1 or not exists(select 'X' from TBIR9953 where cod_exe = @cod_exe)
	begin
		raiserror 99999 'Codigo da execucao invalida'
		return -1
	end
	
	if @cod_err <= -1
	begin
		raiserror 99999 'Codigo de erro invalido'
		return -1
	end

	if @cod_err = 0 and len(@des_err) <= 1
	begin
		raiserror 99999 'Descricao do erro nao preenchida'
		return -1
	end

	if @cod_err = 0
	begin
		select @des_err_atu = @des_err
	end

	if @cod_err > 0 
	begin
		select @des_err_atu = des_err from TBIR9950 where cod_err = @cod_err 
	end

	if @des_err_atu is null
	begin
		raiserror 99999 'Codigo de erro nao encontrado'
		return -1
	end
	
	if @thr_exp = 'S'
		raiserror 99999 @des_err
		
	select @cod_seq = (isnull(max(cod_seq),0)+1) from TBIR9951 where cod_exe = @cod_exe

	insert into TBIR9951
		(cod_exe, flg_tst, des_msg, dat_exe, cod_seq)
	values
		(@cod_exe, 'F', @des_err, getdate(), @cod_seq)		
end
go

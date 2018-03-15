if exists (select 'X' from sysobjects where name = 'executarPlanoDeTeste' and type  = 'P')
	drop procedure executarPlanoDeTeste
go

create procedure executarPlanoDeTeste
	@cod_pln_tst int = -1
as
begin
	declare
		@des_msg_atu  varchar(30),
		@cod_exe      int,
		@mensagem     char(100),
		@cod_tst      varchar(30),
		@cmd_sql      varchar(50),
		@cod_ord      int,
		@desc_pln_tst varchar(30)
		
	declare c9954 cursor for
		select cod_tst,cod_ord
		from TBIR9954
		where cod_pln_tst = @cod_pln_tst
		order by cod_ord
	for read only
	
	select @cmd_sql = 'sp_help'
		
	if @cod_pln_tst <= -1 or not exists(select 'X' from TBIR9952 where cod_pln_tst = @cod_pln_tst)
	begin
		raiserror 99999 'Codigo do plano invalido'
		return -1
	end

	select @desc_pln_tst = desc_pln_tst from TBIR9952 where cod_pln_tst = @cod_pln_tst
	select @cod_exe = (isnull(max(cod_exe),0)+1) from TBIR9953
	
	insert into TBIR9953
		(cod_pln_tst, desc_pln_tst, cod_exe, dat_ini)
	values
		(@cod_pln_tst, @desc_pln_tst, @cod_exe, getdate())
		
	select @mensagem = 'Execucao '+convert(varchar(30),@cod_exe) +' no plano de teste '+convert(varchar(30),@cod_pln_tst)
	print @mensagem
	
	open c9954
	fetch c9954 into @cod_tst, @cod_ord
	
	while @@sqlstatus = 0
	begin
		select @cmd_sql = @cod_tst + ' ' + convert(varchar(30),@cod_exe)
		exec(@cmd_sql)
		
		update TBIR9951
		set cod_tst = @cod_tst, cod_ord = @cod_ord
		where cod_exe = @cod_exe
		
		fetch c9954 into @cod_tst, @cod_ord
	end
	
	close c9954
	
	update TBIR9953
	set dat_fim = getdate()
	where cod_pln_tst = @cod_pln_tst and cod_exe = @cod_exe
	
end
go

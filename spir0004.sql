if exists (select 'X' from sysobjects where name = 'adicionarTeste' and type  = 'P')
	drop procedure adicionarTeste
go

create procedure adicionarTeste
	@cod_pln_tst int = -1,
	@cod_tst     varchar(30) = '',
	@cod_ord     int = 0
as
begin
	declare
		@des_msg_atu varchar(30),
		@mensagem    char(100)
		
	if @cod_pln_tst <= -1 or not exists(select 'X' from TBIR9952 where cod_pln_tst = @cod_pln_tst)
	begin
		raiserror 99999 'Codigo do plano invalido'
		return -1
	end
	
	if @cod_tst = '' or not exists(select 'X' from sysobjects where name = @cod_tst and type  = 'P')
	begin
		raiserror 99999 'Teste invalido'
		return -1
	end
	
	if @cod_ord < 0
	begin
		raiserror 99999 'Ordem invalida'
		return -1
	end
	
	if @cod_ord = 0
	begin
		select @cod_ord = (isnull(max(cod_ord),0)+1) from TBIR9954 where cod_pln_tst = @cod_pln_tst
	end
	
	insert into TBIR9954
		(cod_pln_tst, cod_tst, cod_ord)
	values
		(@cod_pln_tst, @cod_tst, @cod_ord)
		
	select @mensagem = 'Teste '+convert(varchar(30),@cod_tst) +' na sequencia '+convert(varchar(30),@cod_ord)+' adicionado ao plano de teste ' + convert(varchar(30),@cod_pln_tst)
	print @mensagem
end
go

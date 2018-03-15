
if exists (select 'X' from sysobjects where name = 'criarPlanoDeTeste' and type  = 'P')
	drop procedure criarPlanoDeTeste
go

create procedure criarPlanoDeTeste
	@desc_pln_tst  varchar(30) = '' in
as
begin
	declare
		@des_msg_atu varchar(30),
		@cod_pln_tst int,
		@mensagem    char(100)
	
	select @cod_pln_tst = 0

	if @desc_pln_tst = ''
	begin
		raiserror 99999 'Descricao do plano invalida'
		return -1
	end
	
	select @cod_pln_tst = (isnull(max(cod_pln_tst),0)+1) from TBIR9952

	insert into TBIR9952
		(cod_pln_tst, desc_pln_tst)
	values
		(@cod_pln_tst, @desc_pln_tst)
	
	select @mensagem = 'Plano de teste ' +convert(varchar(10),@cod_pln_tst)+' criado'
	print @mensagem
end
go


if exists (select 'X' from sysobjects where name = 'criarTabelaFantasma' and type  = 'P')
	drop procedure criarTabelaFantasma
go

create procedure criarTabelaFantasma
	@nom_tbl    varchar(30) = '' in,
	@cp_tbl_org char(1) = 'S' in
as
begin
	declare
		@nom_tbl_bck    varchar(30)
	
	select @nom_tbl_bck = @nom_tbl+'_bck'
	
	exec('sp_rename '+@nom_tbl+' , '+@nom_tbl_bck)
	
	if @cp_tbl_org = 'S'
		exec('select * into '+@nom_tbl+' from '+@nom_tbl_bck)
	else
		exec('select * into '+@nom_tbl+' from '+@nom_tbl_bck+' where 1 <> 1')
end
go

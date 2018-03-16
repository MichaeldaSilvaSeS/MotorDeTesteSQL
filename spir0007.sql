
if exists (select 'X' from sysobjects where name = 'criarTabelaFantasma' and type  = 'P')
	drop procedure criarTabelaFantasma
go

create procedure criarTabelaFantasma
	@nom_tbl    varchar(30) = '' in,
	@cp_tbl_org char(1) = 'S' in
as
begin
	declare
		@nom_tbl_bck    varchar(30),
		@temp_dbid	int,
		@temp_objid	int
	
	select @nom_tbl_bck = @nom_tbl+'_bck7'
	
	exec sp_configure "allow updates",1
	
	update sysobjects
	set name = @nom_tbl_bck
		where id = object_id(@nom_tbl) and type = 'U'
		
	update sysattributes
	set object_cinfo = @nom_tbl_bck
		where object_cinfo = @nom_tbl and class = 9
	/*	
	update sysindexes
	set name = @nom_tbl_bck
		where id = object_id(@nom_tbl) and indid = 0
		
	select @temp_dbid = db_id()
	select @temp_objid = object_id(@nom_tbl)

	dbcc refreshides(@temp_dbid, @temp_objid, 0)

	update sysindexes
		set name = "t" + @nom_tbl_bck
			where id = object_id(@nom_tbl)
				and indid = 255
				
	dbcc refreshides(@temp_dbid, @temp_objid, 255)
	*/
	dbcc chgobjname(@nom_tbl, @nom_tbl_bck)
	
	commit
	
	if @cp_tbl_org = 'S'
		exec('select * into '+@nom_tbl+' from '+@nom_tbl_bck)
	else
		exec('select * into '+@nom_tbl+' from '+@nom_tbl_bck+' where 1 <> 1')
		
	exec sp_configure "deny updates",1
	
	commit
end
go

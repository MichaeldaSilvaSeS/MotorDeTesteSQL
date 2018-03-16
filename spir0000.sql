exec criarPlanoDeTeste 'Plano 1'
exec adicionarTeste 1, 'teste'
exec executarPlanoDeTeste 1

select 'X' from sysobjects where name like 'abc%' and type  = 'U'
exec criarTabelaFantasma 'abc' , 'N'
select 'X' from sysobjects where name like 'abc%' and type  = 'U'

exec executarPlanoDeTeste 1
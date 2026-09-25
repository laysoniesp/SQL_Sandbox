USE [bdpedido]
GO

-- Q1:A empresa deseja identificar os 2 funcionários que realizaram a maior quantidade 
-- de  pedidos.  Elabore  uma  consulta  que  apresente  o  nome  do  funcionário  e  a 
-- quantidade de pedidos realizados, mostrando somente os dois primeiros colocados.

select p.CodigoDoFuncionario, f.Nome, COUNT(*) quantidade,
count(*)/707.0*100 as porcentagem
from Pedidos p
join Funcionarios f
on p.CodigoDoFuncionario = f.CodigoDoFuncionario
group by p.CodigoDoFuncionario, f.Nome
order by quantidade desc
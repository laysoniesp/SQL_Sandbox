USE [bdpedido];
GO

select * from Produtos

-- O Produto mais caro por categoria --

SELECT c.NomeDaCategoria, MAX(p.PrecoUnitario) AS MaiorPreco
FROM Produtos AS p
INNER JOIN Categorias AS c
	ON p.CodigoDaCategoria = c.CodigoDaCategoria
GROUP BY p.CodigoDaCategoria, c.NomeDaCategoria
ORDER BY c.NomeDaCategoria

-- Outro troço --

select f.Nome, count(*)
from Pedidos P
join Funcionarios F
    on p.CodigoDoFuncionario = f.CodigoDoFuncionario
group by f.Nome

-- Ave maria, Nisston passa a aula de BD avançado igual arquitetura de dados --
-- To mais perdido que cego em tiroteio, mas vamos que vamos, bora estudar e aprender mais sobre SQL e banco de dados. --
-- Olha esse "count", "join", "inner join", "group by", "order by", "max", "where", "as", "min" e outros comandos. --

-- day, month, year --

select distinct year(DataDoPedido)
FROM Pedidos 

select YEAR(DataDoPedido),'Ano Pedido',
        MONTH(DataDoPedido), 'Mes Pedido',
        count(*), 'Total'
from Pedidos
where MONTH(DataDoPedido) = 12
group by YEAR(DataDoPedido), MONTH(DataDoPedido)




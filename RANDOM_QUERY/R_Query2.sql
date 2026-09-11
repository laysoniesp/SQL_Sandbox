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
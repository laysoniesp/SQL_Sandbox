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

select YEAR(DataDoPedido) as [Ano Pedido],
        MONTH(DataDoPedido) as [Mes Pedido],
        count(*) as [Total]
from Pedidos
where MONTH(DataDoPedido) = 12
group by YEAR(DataDoPedido), MONTH(DataDoPedido)

-- Quanto foi vendido em quantidade de produtos oriundos do Japão por ano

SELECT
    YEAR(pe.DataDoPedido) AS Ano,
    SUM(dp.Quantidade) AS QuantidadeVendida
FROM Produtos AS p
INNER JOIN Fornecedores AS f
    ON p.CodigoDoFornecedor = f.CodigoDoFornecedor
INNER JOIN [Detalhes_do_Pedido] AS dp
    ON p.CodigoDoProduto = dp.CodigoDoProduto
INNER JOIN Pedidos AS pe
    ON dp.NumeroDoPedido = pe.NumeroDoPedido
WHERE f.Pais = 'Japão'
GROUP BY YEAR(pe.DataDoPedido)
ORDER BY Ano;

-- Outro --

select d.CodigoDoProduto, p.NomeDoProduto, sum(d.Quantidade) as QuantidadeVendida
from Detalhes_do_Pedido d
join Produtos p
    on d.CodigoDoProduto = p.CodigoDoProduto
join Fornecedores f
    on p.CodigoDoFornecedor = f.CodigoDoFornecedor
where f.Pais = 'Japão'
group by d.CodigoDoProduto, p.NomeDoProduto    

-- Preço --

select d.CodigoDoProduto, p.NomeDoProduto, sum(d.Quantidade) as QuantidadeVendida,
    sum(d.Quantidade * p.PrecoUnitario) as ValorTotal
from Detalhes_do_Pedido d
join Produtos p
    on d.CodigoDoProduto = p.CodigoDoProduto
join Fornecedores f
    on p.CodigoDoFornecedor = f.CodigoDoFornecedor
where f.Pais = 'Japão'
group by d.CodigoDoProduto, p.NomeDoProduto

-- Having --

select d.CodigoDoProduto, p.NomeDoProduto, sum(d.Quantidade) as QuantidadeVendida,
    sum(d.Quantidade * p.PrecoUnitario) as ValorTotal
from Detalhes_do_Pedido d
join Produtos p
    on d.CodigoDoProduto = p.CodigoDoProduto
join Fornecedores f
    on p.CodigoDoFornecedor = f.CodigoDoFornecedor
where f.Pais = 'Japão'
group by d.CodigoDoProduto, p.NomeDoProduto
having sum(d.Quantidade) > 500

-- Sub Query --

-- Quem são os clientes da Alemanha que fizeram algum pedido --

select * from Clientes
where Pais = 'Alemanha' and CodigoDoCliente in (
    select CodigoDoCliente from Pedidos
)
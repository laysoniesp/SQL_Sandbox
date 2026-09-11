USE [bdpedido];
GO

-- Q1

SELECT 
    p.NumeroDoPedido,
    c.NomeDaEmpresa,
    c.Telefone,
    c.Fax
FROM Pedidos p
INNER JOIN Clientes c ON p.CodigoDoCliente = c.CodigoDoCliente;

-- Q2

SELECT 
    c.CodigoDoCliente,
    c.NomeDaEmpresa,
    p.DataDoPedido,
    p.Frete
FROM Pedidos p
INNER JOIN Clientes c ON p.CodigoDoCliente = c.CodigoDoCliente;

-- Q3

SELECT 
    f.CodigoDoFuncionario,
    f.Nome,
    f.Cargo,
    p.CodigoDoCliente,
    p.DataDoPedido
FROM Pedidos p
INNER JOIN Funcionarios f ON p.CodigoDoFuncionario = f.CodigoDoFuncionario;

-- Q4

SELECT 
    p.NumeroDoPedido,
    p.DataDoPedido,
    p.DataDeEntrega,
    t.NomeDaEmpresa AS Transportadora
FROM Pedidos p
INNER JOIN Transportadoras t ON p.CodigoDaTransportadora = t.CodigoDaTransportadora;

-- Q5

SELECT 
    f.Nome AS NomeDoFuncionario,
    p.NumeroDoPedido,
    c.NomeDaEmpresa AS Cliente
FROM Pedidos p
INNER JOIN Funcionarios f ON p.CodigoDoFuncionario = f.CodigoDoFuncionario
INNER JOIN Clientes c ON p.CodigoDoCliente = c.CodigoDoCliente;

-- Q6

SELECT 
    pr.NomeDoProduto,
    cat.NomeDaCategoria,
    forn.NomeDaEmpresa AS Fornecedor
FROM Produtos pr
INNER JOIN Categorias cat ON pr.CodigoDaCategoria = cat.CodigoDaCategoria
INNER JOIN Fornecedores forn ON pr.CodigoDoFornecedor = forn.CodigoDoFornecedor;

-- Q7

SELECT 
    pr.NomeDoProduto,
    dp.PrecoUnitário,
    dp.Quantidade,
    ped.NumeroDoPedido,
    t.NomeDaEmpresa AS Transportadora
FROM Detalhes_do_Pedido dp
INNER JOIN Produtos pr ON dp.CodigoDoProduto = pr.CodigoDoProduto
INNER JOIN Pedidos ped ON dp.NumeroDoPedido = ped.NumeroDoPedido
INNER JOIN Transportadoras t ON ped.CodigoDaTransportadora = t.CodigoDaTransportadora;

-- Q8

SELECT 
    pr.NomeDoProduto,
    ped.DataDoPedido,
    c.NomeDaEmpresa AS Cliente
FROM Detalhes_do_Pedido dp
INNER JOIN Produtos pr ON dp.CodigoDoProduto = pr.CodigoDoProduto
INNER JOIN Pedidos ped ON dp.NumeroDoPedido = ped.NumeroDoPedido
INNER JOIN Clientes c ON ped.CodigoDoCliente = c.CodigoDoCliente;

-- Q9

SELECT 
    f.NomeDaEmpresa AS Fornecedor,
    pr.NomeDoProduto,
    pr.PrecoUnitario,
    ped.DataDoPedido,
    c.NomeDaEmpresa AS Cliente
FROM Detalhes_do_Pedido dp
INNER JOIN Produtos pr ON dp.CodigoDoProduto = pr.CodigoDoProduto
INNER JOIN Fornecedores f ON pr.CodigoDoFornecedor = f.CodigoDoFornecedor
INNER JOIN Pedidos ped ON dp.NumeroDoPedido = ped.NumeroDoPedido
INNER JOIN Clientes c ON ped.CodigoDoCliente = c.CodigoDoCliente;

-- Q10

SELECT DISTINCT 
    f.Nome AS NomeDoFuncionario,
    c.NomeDaEmpresa AS Cliente
FROM Pedidos ped
INNER JOIN Funcionarios f ON ped.CodigoDoFuncionario = f.CodigoDoFuncionario
INNER JOIN Clientes c ON ped.CodigoDoCliente = c.CodigoDoCliente;

-- Q11

SELECT 
    cat.NomeDaCategoria,
    pr.NomeDoProduto,
    dp.PrecoUnitário AS PrecoDeVenda,
    dp.Quantidade,
    dp.Desconto
FROM Detalhes_do_Pedido dp
INNER JOIN Produtos pr ON dp.CodigoDoProduto = pr.CodigoDoProduto
INNER JOIN Categorias cat ON pr.CodigoDaCategoria = cat.CodigoDaCategoria;

-- Q12

SELECT 
    ped.NumeroDoPedido,
    ped.DataDoPedido,
    c.NomeDaEmpresa AS Cliente,
    t.NomeDaEmpresa AS Transportadora
FROM Pedidos ped
INNER JOIN Clientes c ON ped.CodigoDoCliente = c.CodigoDoCliente
INNER JOIN Transportadoras t ON ped.CodigoDaTransportadora = t.CodigoDaTransportadora;

-- Q13

SELECT 
    pr.CodigoDoProduto,
    pr.NomeDoProduto,
    f.CodigoDoFornecedor,
    f.NomeDaEmpresa AS Fornecedor
FROM Produtos pr
INNER JOIN Fornecedores f ON pr.CodigoDoFornecedor = f.CodigoDoFornecedor;

-- Q14

SELECT 
    f.Nome AS NomeDoFuncionario,
    ped.NumeroDoPedido,
    t.NomeDaEmpresa AS Transportadora
FROM Pedidos ped
INNER JOIN Funcionarios f ON ped.CodigoDoFuncionario = f.CodigoDoFuncionario
INNER JOIN Transportadoras t ON ped.CodigoDaTransportadora = t.CodigoDaTransportadora;

-- Q15

SELECT DISTINCT 
    pr.NomeDoProduto
FROM Produtos pr
INNER JOIN Detalhes_do_Pedido dp ON pr.CodigoDoProduto = dp.CodigoDoProduto;

-- Q16

SELECT 
    f.Nome AS NomeDoFuncionario,
    SUM(dp.Quantidade * dp.PrecoUnitário) AS ValorTotalPedidos,
    SUM(dp.Quantidade * dp.PrecoUnitário) * 0.05 AS Comissao_5,
    SUM(dp.Quantidade * dp.PrecoUnitário) * 0.10 AS Comissao_10
FROM Funcionarios f
INNER JOIN Pedidos p ON f.CodigoDoFuncionario = p.CodigoDoFuncionario
INNER JOIN Detalhes_do_Pedido dp ON p.NumeroDoPedido = dp.NumeroDoPedido
GROUP BY f.CodigoDoFuncionario, f.Nome;

-- Q17

SELECT 
    c.NomeDaCategoria,
    SUM(dp.Quantidade) AS TotalMercadoriasVendidas
FROM Categorias c
INNER JOIN Produtos p ON c.CodigoDaCategoria = p.CodigoDaCategoria
INNER JOIN Detalhes_do_Pedido dp ON p.CodigoDoProduto = dp.CodigoDoProduto
GROUP BY c.CodigoDaCategoria, c.NomeDaCategoria;

-- Q18

SELECT 
    t.NomeDaEmpresa AS Transportadora,
    ISNULL(SUM(p.Frete), 0) AS TotalFretePago,
    COUNT(p.NumeroDoPedido) AS TotalPedidosAtendidos
FROM Transportadoras t
LEFT JOIN Pedidos p ON t.CodigoDaTransportadora = p.CodigoDaTransportadora
GROUP BY t.CodigoDaTransportadora, t.NomeDaEmpresa;

-- Q19

SELECT 
    c.NomeDaEmpresa AS Cliente,
    SUM(dp.Quantidade * dp.PrecoUnitário * dp.Desconto) AS TotalDescontoConcedido
FROM Clientes c
INNER JOIN Pedidos p ON c.CodigoDoCliente = p.CodigoDoCliente
INNER JOIN Detalhes_do_Pedido dp ON p.NumeroDoPedido = dp.NumeroDoPedido
GROUP BY c.CodigoDoCliente, c.NomeDaEmpresa;

-- Q20

SELECT 
    f.Nome AS NomeDoFuncionario,
    SUM(dp.Quantidade * dp.PrecoUnitário * dp.Desconto) AS TotalDescontoConcedido
FROM Funcionarios f
INNER JOIN Pedidos p ON f.CodigoDoFuncionario = p.CodigoDoFuncionario
INNER JOIN Detalhes_do_Pedido dp ON p.NumeroDoPedido = dp.NumeroDoPedido
GROUP BY f.CodigoDoFuncionario, f.Nome;

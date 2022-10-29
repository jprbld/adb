USE Moveis
GO

-- Crie uma View com as seguintes informacoes:
-- - Codigo, Nome e Porcentagem do Vendedor
-- - Valor total de cada venda realizada

-- A partir dos dados dessa View corrigir a porcentagem (de comissao) para 20% 
-- dos vendedores que realizaram mais de R$ 5.000,00 de vendas

SELECT * FROM Vendedor
SELECT * FROM Venda

SELECT	V.codigo, 
		V.nome, 
		V.porcentagem, 
		Venda.valorTotal 
FROM Vendedor AS V
INNER JOIN Venda ON V.codigo = Venda.vendedorCodigo
GO


CREATE OR ALTER VIEW VW_Venda AS
SELECT	V.codigo, 
		V.nome, 
		V.porcentagem, 
		Venda.valorTotal 
FROM Vendedor AS V
INNER JOIN Venda ON V.codigo = Venda.vendedorCodigo
GO

SELECT codigo, SUM(valorTotal) AS [total] FROM VW_Venda
GROUP BY codigo
HAVING SUM(valorTotal) >= 5000
GO

UPDATE VW_Venda 
SET porcentagem=0.2 
WHERE codigo IN (SELECT codigo FROM VW_Venda
				 GROUP BY codigo
                 HAVING SUM(valorTotal) >= 5000)
GO
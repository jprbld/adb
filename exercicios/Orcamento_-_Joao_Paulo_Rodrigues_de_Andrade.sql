/* ------------------------
Banco: Orcamento 
Autor: João Paulo Rodrigues de Andrade
Ultima altera��o: 12/09/2022
Descricao: Curso Senai ABD
-------------------------*/

CREATE DATABASE Orcamento
GO

USE Orcamento
GO

CREATE TABLE Despesas(
	codigo INT IDENTITY,
	descricao VARCHAR(60),
	categoria VARCHAR(40),
	valor SMALLMONEY,
	dataPagamento DATE,
	formaPagamento VARCHAR(40),
	CONSTRAINT PK_Pagamento PRIMARY KEY (codigo)
)
GO


INSERT INTO Despesas
VALUES -- descricao, categoria, valor, dataPagamento, formaPagamento
('Gasolina', 'Transporte', 250.00, '02/08/2022', 'cr�dito'),
('Supermercado', 'Necessidades b�sicas', 420.00, '05/08/2022', 'd�bito'),
('Conta de �gua', 'Casa', 65.00, '10/08/2022', 'd�bito em conta'),
('IPVA', 'Transporte', 100.00, '10/08/2022', 'd�bito'),
('Conta de luz', 'Casa', 80.00, '10/08/2022', 'd�bito em conta'),
('Conv�nio', 'Sa�de', 300.00, '12/08/2022', 'd�bito em conta'),
('Telefone', 'Casa', 200.00, '15/08/2022', 'd�bito em conta'),
('Internet e TV', 'Casa', 180.00, '15/08/2022', 'd�bito em conta'),
('Seguro', 'Transporte', 200.00, '15/08/2022', 'cr�dito'),
('Consulta', 'Sa�de', 250.00, '15/08/2022', 'd�bito'),
('Rem�dios', 'Sa�de', 120.00, '17/08/2022', 'cr�dito'),
('Revis�o', 'Transporte', 550.00, '20/08/2022', 'd�bito'),
('Oficina', 'Outros', 300.00, '25/08/2022', 'cr�dito'),
('Padaria', 'Necessidades b�sicas', 160.00, '30/08/2022', 'dinheiro'),
('Roupas', 'Outros', 280.00, '30/08/2022', 'd�bito'),
('Restaurante', 'Lazer', 170.00, '30/08/2022', 'd�bito'),
('Passeios', 'Lazer', 210.00, '30/08/2022', 'dinheiro')
GO


--> Datas

-- Retorna a data do servidor como um DATETIME2
SELECT SYSDATETIME()

-- Retorna a data do servidor como um DATETIMEOFFSET
SELECT SYSDATETIMEOFFSET()

-- Retorna a data do servidor como UTC (refer�ncia do Meridiano de Greenwich)
SELECT SYSUTCDATETIME()

-- Retorna a data do servidor como um DATETIME
SELECT GETDATE()


-- Extrair dia, m�s e ano
SELECT TOP(1) dataPagamento 
FROM Despesas

SELECT TOP(1) DAY(dataPagamento)
FROM Despesas

SELECT TOP(1) MONTH(dataPagamento)
FROM Despesas

SELECT TOP(1) YEAR(dataPagamento)
FROM Despesas


-- Diferen�a entre datas
SELECT DATEDIFF(DAY,'01/01/2000','01/09/2022')
SELECT DATEDIFF(MONTH,'01/01/2000','01/09/2022')
SELECT DATEDIFF(YEAR,'01/01/2000','01/09/2022')

SELECT DATEDIFF(YEAR,'01/01/2000',GETDATE())


--> Textos

INSERT INTO Despesas (descricao)
VALUES ('     Teste de Manipulacao de Textos     ')

SELECT descricao
FROM Despesas
WHERE codigo = 18

-- Remove os espa�os da esquerda
SELECT LTRIM(descricao)
FROM Despesas
WHERE codigo = 18

-- Remove os espa�os da direita
SELECT RTRIM(descricao)
FROM Despesas
WHERE codigo = 18

-- Caracteres a esqueda da posi��o indicada
SELECT LEFT(descricao, 14)
FROM Despesas
WHERE codigo = 18

-- Caracteres a direita da posi��o indicada
SELECT RIGHT(descricao, 14)
FROM Despesas
WHERE codigo = 18

-- Retorna uma parte do texto a partir de uma posi��o mais n caracteres
SELECT SUBSTRING(descricao, 15, 12)
FROM Despesas
WHERE codigo = 18

-- Retorna a quantidade de caracteres
SELECT LEN(descricao)
FROM Despesas
WHERE codigo = 18

SELECT LEN( TRIM(descricao) )
FROM Despesas
WHERE codigo = 18

SELECT LEN( SUBSTRING(descricao, 15, 12) )
FROM Despesas
WHERE codigo = 18

-- Retorna o texto em letras mai�sculas
SELECT UPPER( TRIM(descricao) )
FROM Despesas
WHERE codigo = 18

-- Retorna o texto em letras min�sculas
SELECT LOWER( TRIM(descricao) )
FROM Despesas
WHERE codigo = 18


-- Exclui o registro de teste
DELETE FROM Despesas
WHERE codigo = 18


-- 01. Consulte todas as informa��es de todas as despesas
SELECT * FROM Despesas
GO

-- 02. Consulte a descricao, o valor e a data de pagamento de todas as despesas
SELECT descricao, valor, dataPagamento
FROM Despesas
GO

-- 03. Consulte as despesas da categoria Casa
SELECT *
FROM Despesas
WHERE categoria = 'Casa'
GO

-- 04. Consulte descri��o e o valor das despesas em d�bito em conta
SELECT descricao, valor
FROM Despesas
WHERE formaPagamento LIKE 'débito'
GO

-- 05. Consulte descri��o e categoria das despesas pagas at� dia 10/08
SELECT descricao, categoria
FROM Despesas
WHERE dataPagamento <= '10-08-2022'
GO

-- 06. Consulte as despesas com valor acima de R$ 150,00
SELECT *
FROM Despesas
WHERE valor > 150
GO

-- 07. Consulte as despesas que n�o est�o em d�bito em conta
SELECT *
FROM Despesas
WHERE formaPagamento <> 'débito em conta'
GO

-- 08. Altere a despesa com Oficina para Categoria Transporte
UPDATE despesas
SET categoria = 'Transporte'
WHERE descricao = 'Oficina'
GO

-- 09. Altere a despesa com descri��o Conv�nio para Conv�nio m�dico
UPDATE despesas
SET descricao = 'Convênio médico'
WHERE descricao = 'Convênio'
GO

-- 10. Altere a despesa com descri��o Consulta para Consulta m�dica
UPDATE despesas
SET descricao = 'Consulta médica'
WHERE descricao = 'Consulta'
GO

-- 11. Altere a categoria Necessidades b�sicas para Alimenta��o
UPDATE despesas
SET categoria = 'Alimentação'
WHERE categoria = 'Necessidades básicas'
GO

-- 12. Consulte as despesas que tenham a palavra d�bito na forma de pagamento
SELECT * 
FROM despesas
WHERE formaPagamento LIKE '%débito%'
GO

-- 13. Consulte as despesas que sejam relacioandas com m�dico ou m�dica
SELECT *
FROM Despesas
WHERE descricao LIKE '%médic%'
GO

-- 14. Consulte as despesas da categoria TGransporte pagas no cr�dito
SELECT * 
FROM  despesas
WHERE formaPagamento = 'crédito' AND categoria = 'Transporte'
GO
  
-- 15. Consulte as despesas pagas no d�bito ou em dinheiro
SELECT *
FROM Despesas
WHERE formaPagamento IN ('débito', 'dinheiro')
GO

-- 16. Consulte as 10 primeiras despesas pagas do m�s
SELECT TOP(10)
FROM Despesas
GO

-- 17. Consulte a descricao, dataPagamento e formaPagamento em ordem de valores da mais cara para a mais barata
--     apresentando as colunas com os titulos Descri��o da despesa, Data de pagamento e Forma de pagamento, respectivamente 
SELECT descricao AS 'Descrição despesa',
        dataPagamento AS 'Data de pagamento',
        formaPagamento AS 'Forma de pagamento'
FROM Despesas
ORDER BY valor DESC


-- 18. Consulte as despesas que foram pagas entre 10 e 20/08/2022
SELECT *
FROM Despesas
WHERE dataPagamento BETWEEN '2022-08-10' AND '2022-08-22'
GO

-- 19. Consulte as diferentes cartegorias das despesas (sem repeti-las)
SELECT distinct categoria
FROM despesas
GO

-- 20. Consulte todas as despesas em ordem de pagamento
SELECT * 
FROM despesas
ORDER BY dataPagamento
GO

-- 21. Consulte as despesas em ordem alfab�tica agrupado por categoria
SELECT *
FROM Despesas
ORDER BY categoria
GO

-- 22. Consulte as despesas em ordem decrescente de pagamento agrupado por categoria em ordem alfab�tica
SELECT categoria, dataPagamento
FROM Despesas
GROUP BY categoria, dataPagamento
ORDER BY categoria, dataPagamento DESC
GO

-- 23. Apresente a quantidade de despesas lan�adas
SELECT COUNT(*) as quantidade
FROM despesas
GO

-- 24. Apresente o valor total da despesas lan�adas
SELECT SUM(valor) as total
FROM Despesas
GO

-- 25. Apresente a m�dia aritm�tica dos valores das despesas lan�adas
SELECT AVG(valor) as media
FROM Despesas
GO

-- 26. Apresente a despesa mais cara e a mais barata
SELECT MIN(valor) as minimo,
	   MAX(valor) as maximo
FROM despesas
GO

-- 27. Apresenta a descri��o e o dia da primeira despesa paga no m�s
SELECT TOP(1) descricao, DAY(dataPagamento) as dia
FROM Despesas
ORDER BY dataPagamento
GO

-- 28. Apresenta a difere�a em dias entre o primeiro e o �ltimo pagamento das despesas
SELECT DATEDIFF(DAY,MIN(dataPagamento),MAX(dataPagamento)) as diferenca
FROM despesas
GO

-- 29. Apresenta a quantidade de dias e meses que se passaram desde o �ltimo pagamento at� hoje
SELECT DATEDIFF(DAY,MAX(dataPagamento),GETDATE()) as dias,
	   DATEDIFF(MONTH,MAX(dataPagamento),GETDATE()) as meses
FROM despesas
GO

-- 30. Consulta os subtotais, por categoria (em letras ma�sculas) em ordem decrescente de subtotais
SELECT UPPER(categoria) as Categoria, SUM(valor) as subtotal
FROM Despesas
GROUP BY categoria
ORDER BY subtotal
GO
/* ------------------------
Banco: Moveis 
Autor: Joao Paulo Rodrigues de Andrade
Ultima alteracao:
Descricao: Curso Senai ABD
-------------------------*/

CREATE DATABASE Moveis
GO

USE Moveis
GO

CREATE TABLE Cliente(
	codigo INT IDENTITY,
	nome VARCHAR(50) NOT NULL,
	cpf VARCHAR(15) NOT NULL,
	logradouro VARCHAR(60),
	bairro VARCHAR(50),
	cep VARCHAR(15),
	CONSTRAINT PK_Cliente PRIMARY KEY (codigo),
	CONSTRAINT UK_Cliente UNIQUE(cpf)
)
GO

CREATE TABLE Vendedor(
	codigo INT IDENTITY,
	nome VARCHAR(50) NOT NULL,
	cpf VARCHAR(15) NOT NULL,
	logradouro VARCHAR(60),
	bairro VARCHAR(50),
	cep VARCHAR(15),
	porcentagem FLOAT NOT NULL,
	CONSTRAINT PK_Vendedor PRIMARY KEY (codigo),
	CONSTRAINT UK_Vendedor UNIQUE(cpf)
)
GO

CREATE TABLE Tratamento(
	codigo INT IDENTITY,
	descricao VARCHAR(60),
	acrescimo FLOAT,
	CONSTRAINT PK_Tratamento PRIMARY KEY(codigo)
)
GO

CREATE TABLE Produto(
	codigo INT IDENTITY,
	tratamentoCodigo INT,
	descricao VARCHAR(60) NOT NULL,
	precoCusto SMALLMONEY NOT NULL,
	precoVenda SMALLMONEY,
	CONSTRAINT PK_Produto PRIMARY KEY (codigo),
	CONSTRAINT FK_Produto_Tratamento FOREIGN KEY (tratamentoCodigo) REFERENCES Tratamento (codigo)
)
GO

CREATE TABLE TelefoneCliente(
	codigo INT IDENTITY,
	clienteCodigo INT,
	telefone VARCHAR(15) NOT NULL,
	CONSTRAINT PK_TelefoneCliente PRIMARY KEY (codigo),
	CONSTRAINT FK_TelefoneCliente_Cliente FOREIGN KEY (clienteCodigo) REFERENCES Cliente (codigo)
)
GO

CREATE TABLE EmailCliente(
	codigo INT IDENTITY,
	clienteCodigo INT,
	email VARCHAR(30),
	CONSTRAINT PK_EmailCliente PRIMARY KEY (codigo),
	CONSTRAINT FK_EmailCliente_Cliente FOREIGN KEY (clienteCodigo) REFERENCES Cliente (codigo)
)
GO

CREATE TABLE Motorista(
	codigo INT IDENTITY,
	nome VARCHAR(50) NOT NULL,
	cnh VARCHAR(20) NOT NULL,
	CONSTRAINT PK_Motorista PRIMARY KEY (codigo),
	CONSTRAINT UK_Motorista UNIQUE(cnh)
)
GO

CREATE TABLE TelefoneMotorista(
	codigo INT IDENTITY,
	motoristaCodigo INT,
	telefone VARCHAR(15) NOT NULL,
	CONSTRAINT PK_TelefoneMotorista PRIMARY KEY (codigo),
	CONSTRAINT FK_TelefoneMotorista_Motorista FOREIGN KEY (motoristaCodigo) REFERENCES Motorista (codigo)
)
GO

CREATE TABLE Venda(
	numero INT IDENTITY,
	serie INT,
	clienteCodigo INT,
	vendedorCodigo INT,
	dataEmissao DATE NOT NULL,
	valorTotal SMALLMONEY NOT NULL,
	CONSTRAINT PK_Venda PRIMARY KEY (numero, serie),
	CONSTRAINT FK_Venda_Cliente FOREIGN KEY (clienteCodigo) REFERENCES Cliente (codigo),
	CONSTRAINT FK_Venda_Vendedor FOREIGN KEY (vendedorCodigo) REFERENCES Vendedor (codigo)
)
GO

CREATE TABLE ItemVenda(
	vendaNumero INT,
	vendaSerie INT,
	produtoCodigo INT,
	quantidade INT NOT NULL,
	valorItem SMALLMONEY NOT NULL,
	CONSTRAINT PK_ItemVenda PRIMARY KEY (vendaNumero, vendaSerie, produtoCodigo),
	CONSTRAINT FK_ItemVenda_Venda FOREIGN KEY (vendaNumero, vendaSerie) REFERENCES Venda (numero, serie),
	CONSTRAINT FK_ItemVenda_Produto FOREIGN KEY (produtoCodigo) REFERENCES Produto (codigo)
)
GO

CREATE TABLE Entrega(
	vendaNumero INT,
	vendaSerie INT,
	motoristaCodigo INT,
	CONSTRAINT PK_Entrega PRIMARY KEY (vendaNumero, vendaSerie, motoristaCodigo),
	CONSTRAINT FK_Entrega_Venda FOREIGN KEY (vendaNumero, vendaSerie) REFERENCES Venda (numero, serie),
	CONSTRAINT FK_Entrega_Motorista FOREIGN KEY (motoristaCodigo) REFERENCES Motorista (codigo)
)
GO


ALTER TABLE Vendedor
ADD cidade VARCHAR(25)
GO


ALTER TABLE Cliente
ADD cidade VARCHAR(25)
GO




-- nome, cpf, logradouro, bairro, cep, porcentagem
INSERT INTO Vendedor
VALUES ('Sheila Tuna Espirito Santo', '48936331043','Avenida S�o Joao', 'Vila Joana', '13216000', 0.1, 'Jundiai'),
	   ('Marcelo Frois Caminha', '25964866018', 'Rua Paracatu', 'Parque Imperial', '04302021', 0.1, 'S�o Paulo'),
	   ('Alice Barbalho Vilalobos', '33474720040', 'Rua Cristiano Olsen', 'Jardim Sumaru', '16015244', 0.1, 'Aracatuba'),
	   ('Abigail Barateiro Cangueiro', '56069215028', 'Rua Serra de Braganca', 'Vila Gomes Cardim', '03318000', 0.1, 'Sao Paulo')
GO
-- SELECT * FROM Vendedor	   


-- nome, cpf, logradouro, bairro, cidade, cep
INSERT INTO Cliente
VALUES ('Derek Bicudo Lagos', '91039176062', 'Rua Barao de Vitoria', 'Casa Grande', 'Diadema', '09961660'),
	   ('Jaime Camara Valerio', '02889437086', 'Rua Pereira Estefano', 'Vila da Saude', 'Sao Paulo', '04144070'),
	   ('Abel da Costa Azambuja', '02534695037', 'Avenida Tocantins', 'Vila Jardim Rio Claro', 'Jatau', '75802095'),
	   ('Zion Pedro Simoes', '97450732025', 'Rua Domingos Olimpio', 'Centro', 'Sobral', '62011140'),
	   ('Xavier Doutis Negromonte', '02364136008', 'Avenida Afonso Pena', 'Boa Viagem', 'Belo Horizonte', '30130005'),
	   ('Sofia Figueiroa Brum', '61295251094', 'Travessa Antonio Ferreira', 'Igrejinha', 'Capanema', '68700216')
GO
-- SELECT * FROM Cliente	


INSERT INTO TelefoneCliente
VALUES (1, '(18) 3276-1206'),
	   (1, '(17) 97235-5835'),
	   (1, '(16) 98913-1515'),
	   (2, '(15) 3763-3694'),
	   (3, '(64) 3537-2014'),
	   (3, '(64) 99717-4976'),
	   (4, '(85) 2185-2127'),
	   (5, '(34) 2524-3810'),
	   (5, '(35) 99885-1964'),
	   (5, '(33) 99686-6795'),
	   (5, '(38) 96952-8287'),
	   (6, '(35) 97547-5388')
GO
-- SELECT * FROM TelefoneCliente


INSERT INTO EmailCliente
VALUES (1, 'ganesha3067@gmail.com'),
	   (2, 'tayisiya9289@hotmail.com'),
	   (2, 'shayan1321@yahoo.com'),
	   (2, 'jeanmarie7897@gmail.com'),
	   (3, 'rusty9789@gmail.com'),
	   (5, 'francisco5107@yahoo.com'),
	   (5, 'dailos2526@yahoo.com'),
	   (5, 'anka1456@hotmail.com'),
	   (6, 'marlin2078@hotmail.com'),
	   (6, 'homer9516@uol.com')
GO
-- SELECT * FROM EmailCliente


-- descricao, acrescimo
INSERT INTO Tratamento
VALUES ('Tinta acrilica', 0.07),
	   ('Tinta esmalte', 0.1),
	   ('Tinta laca', 0.12)
GO
-- SELECT * FROM Tratamento


-- descricao, tratamentoCodigo, precoCusto, precoVenda
INSERT INTO Produto
VALUES (3, 'Mesa com dois bancos', 1500.00, 1725.00),
	   (NULL, 'Banco tres lugares', 700.00, 805.00),
	   (NULL, 'Livreiro cinco prateleiras', 750.00, 865.00),
	   (NULL, 'Kit quatro banquetas', 600.00, 690.00),
	   (3, 'Balcao', 800.00, 920.00),
	   (2, 'Cama casal', 1100.00, 1265.00),
	   (NULL, 'Cadeira descanso', 860.00, 990.00)
GO
-- SELECT * FROM Produto


-- nome, cnh
INSERT INTO Motorista
VALUES ('Jason Carmo Teves', '06145434500'),
	   ('Apolo Bogado Rijo', '26503431550'),
	   ('Luisa Viana Bonito', '13576973505'),
	   ('Kevin Marmou Afonso', '67848316264'),
	   ('Cintia Tristao Frajuca', '53799919545')
GO
-- SELECT * FROM Motorista


INSERT INTO TelefoneMotorista
VALUES (1, '(18) 97311-3667'),
	   (2, '(16) 98812-2567'),
	   (2, '(16) 96742-9412'),
	   (3, '(18) 98766-5223'),
	   (4, '(13) 96946-6898'),
	   (5, '(17) 98171-2214'),
	   (5, '(12) 98988-7618')
GO
-- SELECT * FROM TelefoneMotorista


-- serie, clienteCodigo, vendedorCodigo, dataEmissao, valorTotal
INSERT INTO Venda
VALUES (100, 2, 4, '02/01/2022', 1495.00),
	   (100, 1, 2, '02/01/2022', 3450.00),
	   (100, 6, 1, '03/01/2022', 2450.00),
	   (100, 4, 3, '03/01/2022', 1610.00),
	   (100, 2, 4, '03/01/2022', 2220.00)
GO
-- SELECT * FROM Venda


-- vendaNumero, vendaSerie, produtoCodigo, quantidade, valorItem
INSERT INTO ItemVenda
VALUES (1, 100, 2, 1, 805.00),
	   (1, 100, 4, 1, 690.00),
	   (2, 100, 1, 2, 3450.00),
	   (3, 100, 3, 1, 850.00),  -- 865.00
	   (3, 100, 4, 1, 650.00),  -- 690.00
	   (3, 100, 5, 1, 950.00),  -- 920.00
	   (4, 100, 2, 2, 1610.00),
	   (5, 100, 4, 2, 1300.00), -- 1380.00
	   (5, 100, 5, 2, 920.00)
GO
-- SELECT * FROM ItemVenda


INSERT INTO Entrega
VALUES (1, 100, 2),
	   (2, 100, 3),
	   (3, 100, 1),
	   (3, 100, 4),
	   (4, 100, 2),
       (5, 100, 1),
	   (5, 100, 3)
GO
-- SELECT * FROM Entrega

INSERT INTO Vendedor -- nome, cpf, logradouro, bairro, cep, porcentagem, cidade
VALUES ('Clarisse Barrela Parafita', '47249240048','Avenida S�o Jorge', 'Sao Francisco', '58950-998', 0.15, 'Itaguai'),
	   ('Valentino Vasques Mascarenhas', '83382690004', 'Rua Mato Grosso', 'Boa Vista', '79298-291', 0.1, 'Parintinso')
GO

--> Consultas de Vendas por Cliente

SELECT * FROM Venda
SELECT * FROM ItemVenda
SELECT * FROM Cliente

-- Consulte todas as as Vendas por Cliente
SELECT C.nome,
	   C.codigo,
	   V.clienteCodigo,
	   V.numero,
	   V.serie,
	   V.valorTotal
FROM Cliente AS C
INNER JOIN Venda AS V ON C.codigo = V.clienteCodigo


-- Consulte o valor total vendido para cada Cliente
SELECT C.nome,
	   SUM(V.valorTotal) AS [Total vendido]
FROM Cliente AS C
INNER JOIN Venda AS V ON C.codigo = V.clienteCodigo
GROUP BY C.nome
ORDER BY C.nome


-- Consulte todas as as Vendas por Cliente e os Produtos em cada Venda
-- JOIN com operador relacional (AND, OR)
SELECT C.nome,
	   C.codigo,
	   V.clienteCodigo,
	   V.valorTotal,
	   V.numero,
	   V.serie,
	   IV.vendaNumero,
	   IV.vendaSerie,
	   IV.produtoCodigo,
	   P.codigo,
	   P.descricao
FROM Cliente AS C
INNER JOIN Venda AS V ON C.codigo = V.clienteCodigo
INNER JOIN ItemVenda AS IV ON V.numero = IV.vendaNumero AND V.serie = IV.vendaSerie
INNER JOIN Produto AS P ON IV.produtoCodigo = P.codigo
ORDER BY V.numero, V.serie


-- Sem chaves
SELECT C.nome AS Cliente,
	   V.numero,
	   V.serie,
	   V.valorTotal,
	   P.descricao AS Produto
FROM Cliente AS C
INNER JOIN Venda AS V ON C.codigo = V.clienteCodigo
INNER JOIN ItemVenda AS IV ON V.numero = IV.vendaNumero AND V.serie = IV.vendaSerie
INNER JOIN Produto AS P ON IV.produtoCodigo = P.codigo
ORDER BY V.numero, V.serie



--> Consultas de Vendas por Vendedor

SELECT * FROM Venda
SELECT * FROM ItemVenda
SELECT * FROM Vendedor

-- Consulte todas as Vendas realizadas pelos Vendedores e os produtos vendidos
SELECT V.nome,
	   V.porcentagem,	
	   V.codigo,
	   Venda.vendedorCodigo,
	   Venda.valorTotal,
	   Venda.numero,
	   Venda.serie,
	   Item.vendaNumero,
	   Item.vendaSerie,
	   Item.produtoCodigo,
	   P.codigo,
	   P.descricao
FROM Vendedor AS V
INNER JOIN Venda ON V.codigo = Venda.vendedorCodigo
INNER JOIN ItemVenda AS Item ON Venda.numero = Item.vendaNumero AND Venda.serie = Item.vendaSerie
INNER JOIN Produto AS P ON Item.produtoCodigo = P.codigo
ORDER BY Venda.numero, Venda.serie


-- Sem as chaves
SELECT V.nome,
	   V.porcentagem,	
	   Venda.numero,
	   Venda.serie,
	   Venda.dataEmissao,
	   Venda.valorTotal,
	   P.descricao
FROM Vendedor AS V
INNER JOIN Venda ON V.codigo = Venda.vendedorCodigo
INNER JOIN ItemVenda AS Item ON Venda.numero = Item.vendaNumero AND Venda.serie = Item.vendaSerie
INNER JOIN Produto AS P ON Item.produtoCodigo = P.codigo
ORDER BY Venda.numero, Venda.serie


-- Consultar o Valor Total da vendas realizadas por cada Vendedor


SELECT V.nome,
	   FORMAT(V.porcentagem, 'P'),	
	   Venda.numero,
	   Venda.serie,
	   CONVERT(VARCHAR, Venda.dataEmissao, 103) AS [Data de emissao],
	   FORMAT(SUM(Venda.valorTotal), 'C', 'pt-br') AS [Valor Total],
	   FORMAT(SUM(Venda.valorTotal) * V.porcentagem, 'C', 'pt-br') AS Comissao    
FROM Vendedor AS V
INNER JOIN Venda ON V.codigo = Venda.vendedorCodigo
INNER JOIN ItemVenda AS Item ON Venda.numero = Item.vendaNumero AND Venda.serie = Item.vendaSerie
GROUP BY Venda.numero, Venda.serie, V.nome, V.porcentagem, Venda.dataEmissao
ORDER BY Venda.numero, Venda.serie


---> Consultas (com varia��es de JOINs)

-- Vendedor, Vendas, ItenVenda e Produto


SELECT * FROM Vendedor

-- INSERT INTO Vendedor -- nome, cpf, logradouro, bairro, cep, porcentagem, cidade
-- VALUES ('Clarisse Barrela Parafita', '47249240048','Avenida S�o Jorge', 'Sao Francisco', '58950-998', 0.15, 'Itaguai'),
-- 	   ('Valentino Vasques Mascarenhas', '83382690004', 'Rua Mato Grosso', 'Boa Vista', '79298-291', 0.1, 'Parintinso')


-- INNER JOIN 
-- Somente os vendedores que realizaram vendas e seus respectivos produtos
SELECT V.nome,
	   FORMAT(V.porcentagem, 'P') AS Porcentagem,	
	   Venda.numero,
	   Venda.serie,
	   CONVERT(VARCHAR, Venda.dataEmissao, 103) AS [Data de emissao],
	   P.descricao AS Produto,
	   FORMAT(Item.valorItem, 'C', 'pt-br') AS [Valor unitario vendido],
	   Item.quantidade,
	   FORMAT(Venda.valorTotal, 'C', 'pt-br') AS [Valor Total]
FROM Vendedor AS V
INNER JOIN Venda ON V.codigo = Venda.vendedorCodigo
INNER JOIN ItemVenda AS Item ON Venda.numero = Item.vendaNumero AND Venda.serie = Item.vendaSerie
INNER JOIN Produto AS P ON Item.produtoCodigo = P.codigo
ORDER BY V.codigo



-- LEFT OUTER JOIN ou LEFT JOIN
-- Todos os vendedores independentemente de terem realizado vendas ou n�o
SELECT V.nome,
	   FORMAT(V.porcentagem, 'P') AS Porcentagem,	
	   Venda.numero,
	   Venda.serie,
	   CONVERT(VARCHAR, Venda.dataEmissao, 103) AS [Data de emissao],
	   P.descricao AS Produto,
	   FORMAT(Item.valorItem, 'C', 'pt-br') AS [Valor unitario vendido],
	   Item.quantidade,
	   FORMAT(Venda.valorTotal, 'C', 'pt-br') AS [Valor Total]
FROM Vendedor AS V
LEFT JOIN Venda ON V.codigo = Venda.vendedorCodigo
LEFT JOIN ItemVenda AS Item ON Venda.numero = Item.vendaNumero AND Venda.serie = Item.vendaSerie
LEFT JOIN Produto AS P ON Item.produtoCodigo = P.codigo
ORDER BY V.codigo


-- LEFT OUTER EXCLUSIVE JOIN ou LEFT EXCLUSIVE JOIN
-- Somente os vendedores que n�o realizaram vendas
SELECT V.nome,
	   FORMAT(V.porcentagem, 'P') AS Porcentagem,	
	   Venda.numero,
	   Venda.serie,
	   CONVERT(VARCHAR, Venda.dataEmissao, 103) AS [Data de emissao],
	   P.descricao AS Produto,
	   FORMAT(Item.valorItem, 'C', 'pt-br') AS [Valor unitario vendido],
	   Item.quantidade,
	   FORMAT(Venda.valorTotal, 'C', 'pt-br') AS [Valor Total]
FROM Vendedor AS V
LEFT JOIN Venda ON V.codigo = Venda.vendedorCodigo
LEFT JOIN ItemVenda AS Item ON Venda.numero = Item.vendaNumero AND Venda.serie = Item.vendaSerie
LEFT JOIN Produto AS P ON Item.produtoCodigo = P.codigo
WHERE Venda.vendedorCodigo IS NULL
ORDER BY V.codigo



-- RIGHT OUTER JOIN ou RIGHT JOIN
-- Todos os produtos independentemente de term sido vendidos
SELECT V.nome,
	   FORMAT(V.porcentagem, 'P') AS Porcentagem,	
	   Venda.numero,
	   Venda.serie,
	   CONVERT(VARCHAR, Venda.dataEmissao, 103) AS [Data de emissao],
	   P.descricao AS Produto,
	   FORMAT(Item.valorItem, 'C', 'pt-br') AS [Valor unitario vendido],
	   Item.quantidade,
	   FORMAT(Venda.valorTotal, 'C', 'pt-br') AS [Valor Total]
FROM Vendedor AS V
INNER JOIN Venda ON V.codigo = Venda.vendedorCodigo
INNER JOIN ItemVenda AS Item ON Venda.numero = Item.vendaNumero AND Venda.serie = Item.vendaSerie
RIGHT JOIN Produto AS P ON Item.produtoCodigo = P.codigo
ORDER BY P.codigo


-- RIGHT OUTER EXCLUSIVE JOIN ou RIGHT EXCLUSIVE JOIN
-- Somente os produtos que nunca foram vendidos
SELECT V.nome,
	   FORMAT(V.porcentagem, 'P') AS Porcentagem,	
	   Venda.numero,
	   Venda.serie,
	   CONVERT(VARCHAR, Venda.dataEmissao, 103) AS [Data de emissao],
	   P.descricao AS Produto,
	   FORMAT(Item.valorItem, 'C', 'pt-br') AS [Valor unitario vendido],
	   Item.quantidade,
	   FORMAT(Venda.valorTotal, 'C', 'pt-br') AS [Valor Total]
FROM Vendedor AS V
INNER JOIN Venda ON V.codigo = Venda.vendedorCodigo
INNER JOIN ItemVenda AS Item ON Venda.numero = Item.vendaNumero AND Venda.serie = Item.vendaSerie
RIGHT JOIN Produto AS P ON Item.produtoCodigo = P.codigo
WHERE V.codigo IS NULL
ORDER BY P.codigo


-- FULL OUTER INCLUSIVE JOIN ou FULL JOIN
-- Todos os vendedores e produtos independenetemente de terem sido vendidos ou n�o
SELECT V.nome,
	   FORMAT(V.porcentagem, 'P') AS Porcentagem,	
	   Venda.numero,
	   Venda.serie,
	   CONVERT(VARCHAR, Venda.dataEmissao, 103) AS [Data de emissao],
	   P.descricao AS Produto,
	   FORMAT(Item.valorItem, 'C', 'pt-br') AS [Valor unitario vendido],
	   Item.quantidade,
	   FORMAT(Venda.valorTotal, 'C', 'pt-br') AS [Valor Total]
FROM Vendedor AS V
FULL JOIN Venda ON V.codigo = Venda.vendedorCodigo
FULL JOIN ItemVenda AS Item ON Venda.numero = Item.vendaNumero AND Venda.serie = Item.vendaSerie
FULL JOIN Produto AS P ON Item.produtoCodigo = P.codigo
ORDER BY P.codigo



-- FULL OUTER EXCLUSIVE JOIN ou FULL JOIN
-- Somente os vendedores que n�o realizaram vendas e os produtos que n�o forma vendidos
SELECT V.nome,
	   FORMAT(V.porcentagem, 'P') AS Porcentagem,	
	   Venda.numero,
	   Venda.serie,
	   CONVERT(VARCHAR, Venda.dataEmissao, 103) AS [Data de emissao],
	   P.descricao AS Produto,
	   FORMAT(Item.valorItem, 'C', 'pt-br') AS [Valor unitario vendido],
	   Item.quantidade,
	   FORMAT(Venda.valorTotal, 'C', 'pt-br') AS [Valor Total]
FROM Vendedor AS V
FULL JOIN Venda ON V.codigo = Venda.vendedorCodigo
FULL JOIN ItemVenda AS Item ON Venda.numero = Item.vendaNumero AND Venda.serie = Item.vendaSerie
FULL JOIN Produto AS P ON Item.produtoCodigo = P.codigo
WHERE V.codigo IS NULL OR P.codigo IS NULL
ORDER BY P.codigo



--> Consultas de Produto e Tratamento

-- 01. Consulte somente os produtos que receberam tratamento
 
-- 02. Consulte todos os produtos independentemente se receberam tratamento ou não
-- 03. Consulte somente os produtos que não receberam tratamento
-- 04. Consulte todos os tratamentos independentemente de terem sido aplicados ou não
-- 05. Consulte somente os tratamentos que nunca foram aplicados
-- 06. Consulte todos os produtos e todos os tratamentos independentemente de terem sido tratados ou aplicados
-- 07. Consulte somente os produto que não foram tratados e os tratamentos que não foram aplicados




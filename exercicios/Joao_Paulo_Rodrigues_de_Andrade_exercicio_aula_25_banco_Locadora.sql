/* ------------------------
Banco: Locadora 
Autor: Joao Paulo Rodrigues de Andrade
Ultima alteracao: 03/10
Descricao: Curso Senai ABD
-------------------------*/

-- criacao block
-- Criacao do Banco de Dados
CREATE DATABASE Locadora
GO

-- Conexao no Banco
USE Locadora
GO



CREATE TABLE Cliente(
	codigo INT IDENTITY,
	cpf NVARCHAR(20) NOT NULL, 
	rg NVARCHAR(20) NOT NULL, 
	cnh NVARCHAR(20),
	nome NVARCHAR(50) NOT NULL, 
	logradouro NVARCHAR(40),
	bairro NVARCHAR(30),
	cidade NVARCHAR(30),
	uf CHAR(2),
	cep NVARCHAR(15),
	dataNascimento DATE,
	CONSTRAINT PK_Cliente PRIMARY KEY(codigo),
	CONSTRAINT UK_Cliente_cpf UNIQUE(cpf),
	CONSTRAINT UK_Cliente_rg UNIQUE(rg),
	CONSTRAINT UK_Cliente_cnh UNIQUE(cnh)
)
GO	


-- Cria��o da Tabela Categoria
CREATE TABLE Categoria(
	codigo INT IDENTITY,
	nome NVARCHAR(50) NOT NULL, 
	descricao NVARCHAR(100),
	preco SMALLMONEY,
	CONSTRAINT PK_Categoria PRIMARY KEY(codigo)
)
GO	

-- Cria��o da Tabela Oficina
CREATE TABLE Oficina(
	codigo INT IDENTITY,
	nome NVARCHAR(100), 
	CONSTRAINT PK_Oficina PRIMARY KEY(codigo)
)
GO	

-- Cria��o da Tabela Veiculo
CREATE TABLE Veiculo(
	codigo INT IDENTITY,
	categoria_codigo INT,
	chassi NVARCHAR(25), 
	placa NVARCHAR(15),
	marca NVARCHAR(50), 
	modelo NVARCHAR(50), 
	anoModelo INT,
	anoFabricacao INT,
	CONSTRAINT PK_Veiculo PRIMARY KEY(codigo),
	CONSTRAINT UK_Veiculo UNIQUE (placa, chassi),
	CONSTRAINT FK_Veiculo_Categoria FOREIGN KEY (categoria_codigo) REFERENCES Categoria(codigo)
)
GO	

-- Cria��o da Tabela Cor
CREATE TABLE Cor(
	codigo INT IDENTITY,
	nome VARCHAR(20),
	CONSTRAINT PK_Cor PRIMARY KEY(codigo)
)
GO	


-- Cria��o da Tabela VeiculoCor
CREATE TABLE VeiculoCor(
	veiculoCodigo INT,
	corCodigo INT,
	CONSTRAINT PK_VeiculoCor PRIMARY KEY(veiculoCodigo, corCodigo),
	CONSTRAINT FK_VeiculoCor_Veiculo FOREIGN KEY (veiculoCodigo) REFERENCES Veiculo(codigo),
	CONSTRAINT FK_VeiculoCor_Cor FOREIGN KEY (corCodigo) REFERENCES Cor(codigo),
)
GO	

-- Cria��o da Tabela Locacao
CREATE TABLE Locacao(
	codigo INT IDENTITY,
	cliente_codigo INT,
	veiculo_codigo INT,
	dataHoraRetirada DATETIME,
	dataHoraDevolucao DATETIME,
	CONSTRAINT PK_Locacao PRIMARY KEY(codigo),
	CONSTRAINT FK_Locacao_Cliente FOREIGN KEY (cliente_codigo) REFERENCES Cliente(codigo),
	CONSTRAINT FK_Locacao_Veiculo FOREIGN KEY (veiculo_codigo) REFERENCES Veiculo(codigo)
)
GO	

-- Cria��o da Tabela Manutencao
CREATE TABLE Manutencao(
	codigo INT IDENTITY,
	veiculo_codigo INT,
	oficina_codigo INT,
	valor SMALLMONEY,
	dataManutencao DATE,
	descricao NVARCHAR(200)
	CONSTRAINT PK_Manutencao PRIMARY KEY(codigo),
	CONSTRAINT FK_Manutencao_Veiculo FOREIGN KEY (veiculo_codigo) REFERENCES Veiculo(codigo),
	CONSTRAINT FK_Manutencao_Oficina FOREIGN KEY (oficina_codigo) REFERENCES Oficina(codigo)
)
GO	

INSERT INTO Categoria -- nome, descricao, preco
VALUES ('Economico', 'Ve�culos com duas portas, motor 1.0, cambio manual, sem ar e direcao.', 80.00),
	   ('Padrao', 'Carros basicos com ar-condicionado + direcao hidraulica e carros compactos', 100.00),
	   ('SUV', 'Pick-ups, SUVs e SUVs compactos', 150.00),
	   ('Luxo', 'Sedans medios, executivos, blindados e de luxo', 200.00)
GO

INSERT INTO Veiculo	-- categoria_codigo, chassi, placa, marca, modelo, anoModelo, anoFabricacao
VALUES (1, '4AX jdrFAC Dt Mn8880', 'BFR-4608', 'Fiat', 'Argo', 2021, 2020 ),
       (3, '217 jHA5BA YB 234327', 'CUV-8739', 'Jeep', 'Renegade', 2022, 2021),
       (4, '89d 7WdA23 Eu XF7661', 'ESZ-5235', 'Volvo', 'XC40 Momentum T4', 2022, 2021),
	   (1, '4h3 rGc7gn mX Y74422', 'FWL-9903', 'Hyundai', 'HB20', 2022, 2021),
	   (2, '7LR DHAChV 5r 9P7216', 'CZD-2437', 'Fiat', 'Toro', 2022, 2021),
	   (4, '6Ap 4jxZUK 3k Tm5738', 'BID-5580', 'Audi', 'A3 Sedan Prestige Plus', 2021, 2020),
	   (1, '3AT 0H58Ke WB AH2823', 'EMM-5060', 'Fiat', 'Mobi', 2022, 2022),
	   (3, '4Lu L6ZkaY Sj Dw4995', 'CPR-9597', 'Toyota', 'RAV4', 2022, 2021),
	   (4, '7wa R5R1Vv xe S05938', 'BNF-7206', 'BMW', '320i', 2022, 2022)
GO

-- Inser��o de dados em Cliente especificando os campos
INSERT INTO Cliente
	(cpf, rg, cnh, nome, logradouro, bairro, cidade, uf, cep, dataNascimento)
VALUES 
	('910.391.760-62', '35.835.029-3', '53799919545', 'Derek Bicudo Lagos', 
	 'Rua Barao de Vitoria', 'Casa Grande', 'Diadema', 'SP', '09961660', '15/11/1999')
GO


-- Insercao de dados em Cliente "em lote". 
-- Todos os campos devem ser informados e na ordem de cria��o da tabela.
INSERT INTO Cliente
	(cpf, rg, cnh, nome, dataNascimento, logradouro, bairro, cidade, uf, cep)
VALUES 
('489.363.310-43', '28.080.124-5', '06145434500', 'Sheila Tuna Espirito Santo', '06/05/1961', 'Avenida Sao Joao', 'Vila Joana', 'Jundiai', 'SP', '13216000'),
('259.648.660-18', '15.905.207-5', '26503431550', 'Marcelo Frois Caminha', '14/08/1970', 'Rua Paracatu', 'Parque Imperial', 'Sao Paulo', 'SP', '04302021'),
('334.747.200-40', '13.576.973-5', '72025905194', 'Alice Barbalho Vilalobos','15/04/1978', 'Rua Cristiano Olsen', 'Jardim Sumaru', 'Aracatuba', 'SP', '16015244'),
('560.692.150-28', '12.975.292-7', '67848316264', 'Abigail Barateiro Cangueiro', '28/01/1969', 'Rua Serra de Braganca', 'Vila Gomes Cardim', 'Sao Paulo', 'SP', '03318000'),
('028.894.370-86', '26.134.510-2', '79493715759', 'Jaime Camara Valerio', '20/03/2002', 'Rua Pereira Estefano', 'Vila da Saude', 'Sao Paulo', 'SP', '04144070')
GO


-- Inser��o de dados em Oficina
INSERT INTO Oficina
VALUES ('Centro Automotivo'),
	   ('Auto Center'),
	   ('Motors Control'),
	   ('Car Service')
GO



-- veiculo_codigo, oficina_codigo, valor, dataManutencao, descricao
INSERT INTO Manutencao
VALUES (1, 1, 1250.00, '01/12/2021', 'Revisao 5000 km'),
       (4, 2, 1300.00, '15/12/2021', 'Revisao 4000 km'),
	   (7, 3, 1750.00, '05/12/2020', 'Revisao 8000 km'),
	   (2, 4, 3000.00, '10/12/2021', 'Revisao 1000 km'),
	   (5, 2, 2800.00, '12/12/2021', 'Revisao 1000 km')
GO

INSERT INTO Locacao
VALUES (1, 1, '02/01/2022', '10/01/2022'),
       (2, 1, '05/01/2022', '15/01/2022'),
	   (3, 1, '05/01/2022', '20/01/2022'),
	   (4, 2, '10/01/2022', '15/01/2022'),
	   (5, 3, '12/01/2022', '13/01/2022'),
	   (6, 3, '15/01/2022', '16/01/2022'),
	   (1, 1, '15/01/2022', '20/01/2022'),
	   (2, 2, '15/01/2022', '17/01/2022'),
	   (3, 1, '01/02/2022', '10/02/2022'),
	   (4, 2, '02/02/2022', '10/02/2022'),
	   (5, 3, '20/02/2022', '25/02/2022'),
	   (6, 3, '22/02/2022', '25/02/2022'),
	   (4, 2, '01/03/2022', '05/03/2022'),
	   (5, 1, '10/03/2022', '15/03/2022'),
	   (6, 3, '12/03/2022', '15/03/2022')
GO

INSERT INTO Cor
VALUES ('Branco'),
       ('Preto'),
	   ('Cinza'),
	   ('Vermelho')
GO


-- Veiculos: 1 - 9
-- Cor: 1 - 4

INSERT INTO VeiculoCor
VALUES (1, 1),
       (3, 1),
       (3, 2),
       (5, 3),
       (7, 4),
       (9, 1),
       (2, 3),
	   (6, 2),
       (8, 2),
       (8, 4),
	   (4, 1 )
GO

-- criacao block


-- 1. Veiculos da categoria Economico

SELECT	V.marca AS Marca,
		V.modelo AS Modelo,
		C.nome AS Categoria
FROM Veiculo AS V
INNER JOIN Categoria AS C ON V.categoria_codigo = C.codigo
WHERE C.nome = 'Economico'
GO


-- 2. Veiculos locados entre 05/01/2022 e 05/02/2022

SELECT	CONVERT(VARCHAR,L.dataHoraRetirada,103) AS Data_retirada,
		V.marca,
		V.modelo
FROM Veiculo AS V
INNER JOIN Locacao AS L ON V.codigo = L.veiculo_codigo
WHERE L.dataHoraRetirada BETWEEN '05/01/22' AND '05/02/22'
GO

-- 3. Veiculos locados em fevereiro de 2022

SELECT	CONVERT(VARCHAR,L.dataHoraRetirada,103) AS Data_retirada,
		V.marca,
		V.modelo
FROM Veiculo AS V
INNER JOIN Locacao AS L ON V.codigo = L.veiculo_codigo
WHERE MONTH(L.dataHoraRetirada) = 2
GO

-- 4. Veiculos que sao ou possuem a cor preta


SELECT	V.marca,
		V.modelo,
		C.nome AS Cor
FROM Veiculo AS V
INNER JOIN VeiculoCor AS VC ON V.codigo = VC.veiculoCodigo
INNER JOIN Cor AS C ON VC.corCodigo = C.codigo
WHERE C.nome = 'preto'
GO

-- 5. Veiculos que realizaram manutencao nas oficinas Auto Center ou Centro Automotivo

SELECT	V.marca,
		V.modelo,
		O.nome AS Oficina
FROM Veiculo AS V
INNER JOIN Manutencao AS M ON V.codigo = M.veiculo_codigo
INNER JOIN Oficina AS O ON M.oficina_codigo = O.codigo
WHERE O.nome = 'Auto Center' OR O.nome = 'Centro Automotivo'
GO

-- 6. Quantidade de veiculos por ano de fabricacao

SELECT	V.anoFabricacao AS Ano_de_fabricacao,
		COUNT (V.codigo) AS Quantidade_de_Veiculos
FROM Veiculo AS V
GROUP BY V.anoFabricacao
GO

-- 7. Veiculos que foram locados para clientes da cidade de Sao Paulo

SELECT	C.nome AS Cliente,
		C.cidade,
		V.marca,
		V.modelo
FROM Cliente AS C
INNER JOIN Locacao AS L ON C.codigo = L.cliente_codigo
INNER JOIN Veiculo AS V ON L.veiculo_codigo = V.codigo
WHERE C.cidade = 'Sao Paulo'
GROUP BY C.nome, C.cidade, V.marca, V.modelo
GO

-- 8. Quantidade de veiculos locados por cliente

SELECT	C.nome AS Cliente,
		COUNT (L.Codigo) AS [Quantidade de Veiculos]
FROM Cliente AS C
INNER JOIN Locacao AS L ON C.codigo = L.cliente_codigo
INNER JOIN Veiculo AS V ON L.veiculo_codigo = V.codigo
GROUP BY C.nome
GO

-- 9. Os dois veiculos mais locados

SELECT	TOP (2) V.marca,
		V.modelo,
		COUNT (L.Codigo) AS [Quantidade de locacoes]
FROM Veiculo AS V
INNER JOIN Locacao AS L ON V.codigo = L.veiculo_codigo
GROUP BY V.marca, V.modelo
ORDER BY [Quantidade de locacoes] DESC
GO

-- 10. Quantidade de dias que cada veiculo ficou locado

SELECT	V.marca,
		V.modelo,
		SUM(DATEDIFF(DAY,L.dataHoraRetirada, L.dataHoraDevolucao)) AS Quantidade_dias_locados
FROM Veiculo AS V
INNER JOIN Locacao AS L ON V.codigo = L.veiculo_codigo
GROUP BY V.marca, V.modelo
ORDER BY Quantidade_dias_locados DESC
GO

-- 11. Quantidade de diarias e valores recebidos por veiculo


SELECT	V.marca,
		V.modelo,
		SUM(DATEDIFF(DAY, L.dataHoraRetirada, L.dataHoraDevolucao)) AS Total_diarias,
		FORMAT(SUM(DATEDIFF(DAY, L.dataHoraRetirada, L.dataHoraDevolucao))*C.preco, 'C', 'pt-br') AS Valor_total
FROM Veiculo AS V 
INNER JOIN Locacao AS L ON V.codigo = L.veiculo_codigo	
INNER JOIN Categoria AS C ON V.categoria_codigo = C.codigo
GROUP BY V.marca, V.modelo, C.preco
GO

--12. Valor total de locacoes do Fiat Argo

SELECT	V.marca,
		V.modelo,
		SUM(DATEDIFF(DAY, L.dataHoraRetirada, L.dataHoraDevolucao)) AS [Quantidade de dias locados],
		FORMAT(C.preco, 'C', 'pt-br') AS Valor_diaria,
		FORMAT(SUM(DATEDIFF(DAY, L.dataHoraRetirada, L.dataHoraDevolucao))*C.preco, 'C', 'pt-br') AS Valor_total
FROM Veiculo AS V 
INNER JOIN Locacao AS L ON V.codigo = L.veiculo_codigo	
INNER JOIN Categoria AS C ON V.categoria_codigo = C.codigo
WHERE V.marca = 'Fiat' AND V.modelo = 'Argo'
GROUP BY V.marca, V.modelo, C.preco
GO

--13. Veiculos que nao passaram por manutencao

SELECT	V.marca,
		V.modelo
FROM Veiculo AS V
LEFT JOIN Manutencao AS M ON V.codigo = M.veiculo_codigo
WHERE M.veiculo_codigo IS NULL
GO

--14. Veiculos que nunca foram locados

SELECT	V.marca,
		V.modelo
FROM Veiculo AS V
FULL JOIN Locacao AS L ON V.codigo = L.veiculo_codigo	
WHERE L.veiculo_codigo IS NULL
GO

--15. Veiculo em que mais se gastou com manutencao

SELECT	TOP (1)V.marca,
		V.modelo,
		FORMAT(M.valor, 'C', 'pt-br') AS Valor_diaria
FROM Veiculo AS V
INNER JOIN Manutencao AS M ON V.codigo = M.veiculo_codigo
ORDER BY Valor_diaria DESC
GO
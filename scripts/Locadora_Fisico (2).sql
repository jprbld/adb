/* ------------------------
Banco: Locadora 
Autor:
�ltima altera��o:
Descri��o: Curso Senai ABD
-------------------------*/

-- Cria��o do Banco de Dados
CREATE DATABASE Locadora
GO

-- Conex�o no Banco
USE Locadora
GO

-- Cria��o de Tabela
CREATE TABLE Cliente(
	codigo INT,
	cpf NVARCHAR(20), 
	rg NVARCHAR(20), 
	cnh NVARCHAR(15),
	endereco NVARCHAR(100), 
	logradouro NVARCHAR(40),
	dataNascimento DATE
)
GO	

-- Exclus�o de tabela
DROP TABLE Cliente
GO

-- Cria��o de Tabela com argumentos e restri��es
CREATE TABLE Cliente(
	codigo INT IDENTITY,
	cpf NVARCHAR(20) NOT NULL, 
	rg NVARCHAR(20) NOT NULL, 
	cnh NVARCHAR(15),
	nome NVARCHAR(50) NOT NULL, 
	endereco NVARCHAR(100),
	dataNascimento DATE,
	CONSTRAINT PK_Cliente PRIMARY KEY(codigo),
	CONSTRAINT UK_Cliente_cpf UNIQUE(cpf),
	CONSTRAINT UK_Cliente_rg UNIQUE(rg),
	CONSTRAINT UK_Cliente_cnh UNIQUE(cnh)
)
GO	

-- Altera��o de tabela excluindo coluna
ALTER TABLE Cliente
DROP COLUMN endereco
GO

-- Altera��o de tabela adicionando colunas
ALTER TABLE Cliente
Add logradouro NVARCHAR(40),
	bairro NVARCHAR(30),
	cidade NVARCHAR(30),
	uf CHAR(2),
	cep NVARCHAR(15)
GO

-- Altera��o de tabela modificando coluna
ALTER TABLE Cliente 
ALTER COLUMN cnh NVARCHAR(20)
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


-- Cria��o da Tabela Cor
CREATE TABLE Cor(
	codigo INT IDENTITY,
	nome VARCHAR(20),
	CONSTRAINT PK_Cor PRIMARY KEY(codigo)
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

-- Cria��o da Tabela Locacao
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



-- Inser��o de dados em Categoria
INSERT INTO Categoria -- nome, descricao, preco
VALUES ('Economico', 'Veiculos com duas portas, motor 1.0, cambio manual, sem ar e direcao.', 80.00),
	   ('Padrao', 'Carros basicos com ar-condicionado + direcao hidraulica e carros compactos', 100.00),
	   ('SUV', 'Pick-ups, SUVs e SUVs compactos', 150.00),
	   ('Luxo', 'Sedans medios, executivos, blindados e de luxo', 200.00)


-- Consulta de todos os registros da tabela Categoria
SELECT * FROM Categoria
-- categoria_codigo v�lidos: 1, 2, 3 e 4


-- Inser��o de dados em Veiculo
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


-- Consulta de todos os registros da tabela Veiculo
SELECT * FROM Veiculo


-- Inser��o de dados em Cliente especificando os campos
INSERT INTO Cliente
	(cpf, rg, cnh, nome, logradouro, bairro, cidade, uf, cep, dataNascimento)
VALUES 
	('910.391.760-62', '35.835.029-3', '53799919545', 'Derek Bicudo Lagos', 
	 'Rua Barao de Vitoria', 'Casa Grande', 'Diadema', 'SP', '09961660', '15/11/1999')


-- Consulta de todos os registros da tabela Cliente
SELECT * FROM Cliente


-- Inser��o de dados em Cliente "em lote". 
-- Todos os campos devem ser informados e na ordem de cria��o da tabela.
INSERT INTO Cliente
VALUES ('489.363.310-43', '28.080.124-5', '06145434500', 'Sheila Tuna Espirito Santo', '06/05/1961', 'Avenida Sao Joao', 'Vila Joana', 'Jundiai', 'SP', '13216000'),
	   ('259.648.660-18', '15.905.207-5', '26503431550', 'Marcelo Frois Caminha', '14/08/1970', 'Rua Paracatu', 'Parque Imperial', 'Sao Paulo', 'SP', '04302021'),
	   ('334.747.200-40', '13.576.973-5', '72025905194', 'Alice Barbalho Vilalobos', '15/04/1978', 'Rua Cristiano Olsen', 'Jardim Sumaru', 'Aracatuba', 'SP', '16015244'),
       ('560.692.150-28', '12.975.292-7', '67848316264', 'Abigail Barateiro Cangueiro', '28/01/1969', 'Rua Serra de Bragan�a', 'Vila Gomes Cardim', 'Sao Paulo', 'SP', '03318000'),
	   ('028.894.370-86', '26.134.510-2', '79493715759', 'Jaime Camara Valerio', '20/03/2002', 'Rua Pereira Estefano', 'Vila da Saude', 'Sao Paulo', 'SP', '04144070')

-- Consulta de todos os registros da tabela Cliente
SELECT * FROM Cliente


-- Inser��o de dados em Oficina
INSERT INTO Oficina
VALUES ('Centro Automotivo'),
	   ('Auto Center'),
	   ('Motors Control'),
	   ('Car Service')

-- Consulta de todos os registros da tabela Oficina
SELECT * FROM Oficina


-- veiculo_codigo, oficina_codigo, valor, dataManutencao, descricao
INSERT INTO Manutencao
VALUES (1, 1, 1250.00, '01/12/2021', 'Revisao 5000 km'),
       (4, 2, 1300.00, '15/12/2021', 'Revisao 4000 km'),
	   (7, 3, 1750.00, '05/12/2020', 'Revisao 8000 km'),
	   (2, 4, 3000.00, '10/12/2021', 'Revisao 1000 km'),
	   (5, 2, 2800.00, '12/12/2021', 'Revisao 1000 km')

-- Consulta de todos os registros da tabela Manutencao
SELECT * FROM Manutencao


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

-- Consulta de todos os registros da tabela Locacao
SELECT * FROM Locacao


INSERT INTO Cor
VALUES ('Branco'),
       ('Preto'),
	   ('Cinza'),
	   ('Vermelho')

-- Consulta de todos os registros da tabela Cor
SELECT * FROM Cor


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


-----> Consultas

-- Consualtas gerais para visualizar os campos e registros
SELECT * FROM Cliente
SELECT * FROM Categoria
SELECT * FROM Veiculo
SELECT * FROM Cor
SELECT * FROM Locacao
SELECT * FROM Manutencao
SELECT * FROM Oficina


----> Nomenclatura utulizada para os elementos de uma consulta

-- Proje��o
SELECT marca, modelo, anoFabricacao
-- Origem
FROM Veiculo
-- Jun��o (JOIN)
   -- Demais tabelas 
-- Sele��o
WHERE marca = 'Fiat'


----- Consultar as Categorias e seus Veiculos

-- Acrescentando uma segunda tabela no FROM gera um Plano Cartesiano entre as duas tabelas
SELECT *
FROM Categoria, Veiculo


-- Utilizando duas (ou mais) tabelas em uma consulta � importante identificar 
-- a qual tabela o atributo (ou proje��o) pertence
SELECT Categoria.codigo,
	   Categoria.nome,
	   Categoria.preco,
	   Veiculo.codigo,
	   Veiculo.categoria_codigo,
	   Veiculo.marca,
	   Veiculo.modelo
FROM Categoria, Veiculo


-- Essa identifica��o (da tabela) pode ser realizada por meio de um "alias" (apelido),
-- assim como, os atributos
SELECT C.nome,
	   C.preco,
	   C.codigo AS [PK de Categoria],
	   V.categoria_codigo AS [FK em Veiculo],
	   V.codigo AS [PK de Veiculo],
	   V.marca,
	   V.modelo
FROM Categoria AS C, Veiculo AS V


-- Por meio do WHERE � possivel vincular os registros relacionados nas tabelas,
-- filtrando assim, somente os registros relacionados
SELECT C.nome,
	   C.preco,
	   C.codigo AS [PK de Categoria],
	   V.categoria_codigo AS [FK em Veiculo],
	   V.codigo AS [PK de Veiculo],
	   V.marca,
	   V.modelo
FROM Categoria AS C, Veiculo AS V
WHERE C.codigo = V.categoria_codigo
-- ORDER BY C.nome
ORDER BY [PK de Categoria]


-- O v�nculo feito pelo WHERE equivale a forma mais simples da instru��o JOIN (INNER JOIN)
-- Obtem-se o mesmo resultado.
SELECT C.nome,
	   C.preco,
	   C.codigo AS [PK de Categoria],
	   V.categoria_codigo AS [FK em Veiculo],
	   V.marca,
	   V.modelo
FROM Categoria C
INNER JOIN Veiculo V ON C.codigo = V.categoria_codigo
ORDER BY [PK de Categoria]


-- A n�o ser que seja necess�rio, os campos (chaves) respons�veis pelos relacionamentos
-- n�o precisam estar nas proje��es
SELECT C.nome,
	   C.preco,
	   V.marca,
	   V.modelo
FROM Categoria AS C, Veiculo AS V
WHERE C.codigo = V.categoria_codigo
ORDER BY C.nome


-- A partir da defini��o do v�nculo dos registros entre as tabelas
-- as proje��es (campos) e ordena��es podem variar
SELECT V.modelo,
	   V.marca,
	   C.nome AS Categoria,
	   C.preco
FROM Categoria AS C, Veiculo AS V
WHERE C.codigo = V.categoria_codigo
ORDER BY V.modelo


-- A "responsabilidade" original do WHERE � a sele��o de registros, portanto,
-- sempre utilize o JOIN para realizar as jun��es de tabelas
SELECT V.modelo,
	   V.marca,
	   C.nome AS Categoria,
	   C.preco
FROM Categoria C
INNER JOIN Veiculo V ON C.codigo = V.categoria_codigo
ORDER BY V.modelo



----- Consultar as Manuten��es e as Oficinas onde foram realizadas

-- Por meio o WHERE visualizando as chaves
SELECT M.descricao,
       M.oficina_codigo,
	   O.codigo,
	   O.nome
FROM Manutencao AS M, Oficina AS O
WHERE M.oficina_codigo = O.codigo
ORDER BY O.nome


-- Somente os campos que interessam
SELECT M.descricao AS Manutencao,
	   O.nome AS Oficina
FROM Manutencao AS M, Oficina AS O
WHERE M.oficina_codigo = O.codigo
ORDER BY O.nome


-- Diferentes proje��es, apelidos e ordena��es
SELECT M.dataManutencao AS [Data da Manutencao],
	   M.descricao AS Manutencao,
	   O.nome AS Oficina
FROM Manutencao AS M, Oficina AS O
WHERE M.oficina_codigo = O.codigo
ORDER BY [Data da Manutencao]


-- A jun��o realizada pelo JOIN (como recomendado)
SELECT M.dataManutencao AS [Data da Manutencao],
	   M.descricao AS Manutencao,
	   O.nome AS Oficina
FROM Manutencao AS M
INNER JOIN Oficina AS O ON M.oficina_codigo = O.codigo
ORDER BY [Data da Manutencao]



----- Consulte os Veiculos que fizeram Manuten��o e em qual(is) Oficina

-- Consultas gerais
SELECT * FROM Veiculo
SELECT * FROM Manutencao
SELECT * FROM Oficina

-- Por meio o WHERE visualizando as chaves
SELECT V.modelo,
	   V.marca,
	   V.codigo,
	   M.veiculo_codigo,
	   M.descricao,
	   M.valor,
	   M.oficina_codigo,
	   O.codigo,
	   O.nome
FROM Veiculo AS V, 
     Manutencao AS M,
	 Oficina AS O
WHERE V.codigo = M.veiculo_codigo AND
      M.oficina_codigo = O.codigo


-- Somente os campos que interessam
SELECT V.modelo,
	   V.marca,
	   M.descricao,
	   M.valor,
	   O.nome
FROM Veiculo AS V, 
     Manutencao AS M,
	 Oficina AS O
WHERE V.codigo = M.veiculo_codigo AND
      M.oficina_codigo = O.codigo


-- A jun��o realizada pelo JOIN (como recomendado)
SELECT V.modelo,
	   V.marca,
	   M.descricao,
	   M.valor,
	   O.nome
FROM Veiculo AS V
INNER JOIN Manutencao AS M ON V.codigo = M.veiculo_codigo
INNER JOIN Oficina AS O ON M.oficina_codigo = O.codigo



----- Consulte as Categorias, seus Veiculos, as Manuten��o realizadas e em qual(is) Oficina

-- Por meio o WHERE visualizando as chaves
SELECT C.nome,
	   C.codigo,
	   V.categoria_codigo,
	   V.modelo,
	   V.marca,
	   V.codigo,
	   M.veiculo_codigo,
	   M.descricao,
	   M.valor,
	   M.oficina_codigo,
	   O.codigo,
	   O.nome
FROM Categoria AS C,
	 Veiculo AS V, 
     Manutencao AS M,
	 Oficina AS O
WHERE C.codigo = V.categoria_codigo AND
	  V.codigo = M.veiculo_codigo AND
      M.oficina_codigo = O.codigo


-- Somente os campos que interessam
SELECT C.nome AS Categoria,
	   V.modelo AS Modelo,
	   V.marca AS Marca,
	   M.descricao AS Descricao,
	   M.dataManutencao AS [Data da manuten��o],
	   O.nome AS Oficina
FROM Categoria AS C,
	 Veiculo AS V, 
     Manutencao AS M,
	 Oficina AS O
WHERE C.codigo = V.categoria_codigo 
  AND V.codigo = M.veiculo_codigo 
  AND M.oficina_codigo = O.codigo
ORDER BY M.dataManutencao


-- A jun��o realizada pelo JOIN (como recomendado)
SELECT C.nome AS Categoria,
	   V.modelo AS Modelo,
	   V.marca AS Marca,
	   M.descricao AS Descricao,
	   M.dataManutencao AS [Data da manuten��o],
	   O.nome AS Oficina
FROM Categoria AS C
	INNER JOIN Veiculo AS V ON C.codigo = V.categoria_codigo 
	INNER JOIN Manutencao AS M ON V.codigo = M.veiculo_codigo
	INNER JOIN Oficina AS O ON M.oficina_codigo = O.codigo
ORDER BY M.dataManutencao



-- Consulte os Clientes e quais Veiculos eles locaram
-- Cliente: nome, cidade
-- Locacao: data e hora da retirada e da devolu��o
-- Veiculo: modelo e marca

-- Consultas gerais
SELECT * FROM Cliente
SELECT * FROM Locacao
SELECT * FROM Veiculo

-- Por meio o WHERE visualizando as chaves
SELECT C.nome,
       C.cidade,
	   C.codigo,
	   L.cliente_codigo,
	   L.dataHoraRetirada,
	   L.dataHoraDevolucao,
	   L.veiculo_codigo,
	   V.codigo,
	   V.modelo,
	   V.marca
FROM Cliente AS C,
     Locacao AS L,
	 Veiculo AS V
WHERE C.codigo = L.cliente_codigo
  AND L.veiculo_codigo = V.codigo
ORDER BY C.nome


-- Somente os campos que interessam
-- Com exemplo de CAST de DATETIME para DATE
SELECT C.nome AS Cliente,
       C.cidade AS Cidade,
	   CAST(L.dataHoraRetirada AS DATE) AS [Data de retirada],
	   CAST(L.dataHoraDevolucao AS DATE) AS [Data de devolucao],
	   V.modelo AS Modelo,
	   V.marca AS Marca
FROM Cliente AS C,
     Locacao AS L,
	 Veiculo AS V
WHERE C.codigo = L.cliente_codigo
  AND L.veiculo_codigo = V.codigo
ORDER BY Cliente


-- A jun��o realizada pelo JOIN (como recomendado)
SELECT C.nome AS Cliente,
       C.cidade AS Cidade,
	   CAST(L.dataHoraRetirada AS DATE) AS [Data de retirada],
	   CAST(L.dataHoraDevolucao AS DATE) AS [Data de devolucao],
	   V.modelo AS Modelo,
	   V.marca AS Marca
FROM Cliente AS C
	INNER JOIN Locacao AS L ON C.codigo = L.cliente_codigo
	INNER JOIN Veiculo AS V ON L.veiculo_codigo = V.codigo
ORDER BY Cliente


-- Exemplo de CONVERT para "formata��o" do DATETIME
SELECT C.nome AS Cliente,
       C.cidade AS Cidade,
	   CONVERT(VARCHAR,L.dataHoraRetirada,103) AS [Data retirada],
	   CONVERT(VARCHAR,L.dataHoraDevolucao,103) AS [Data devolucao],
	   V.modelo AS Modelo,
	   V.marca AS Marca
FROM Locacao AS L
INNER JOIN Cliente AS C ON C.codigo = L.cliente_codigo
INNER JOIN Veiculo AS V ON V.codigo = L.veiculo_codigo
ORDER BY Cliente


/* Formatos de Data e Hora poss�veis com o CONVERT

    getdate() padrao_internacional

    -- Ano com 2 digitos
    convert(varchar, getdate(),   0) ' 0: mmm dd aaaa hh:mm XX'
    convert(varchar, getdate(),   1) ' 1: mm/dd/aa'
    convert(varchar, getdate(),   2) ' 2: aa.mm.dd'
    convert(varchar, getdate(),   3) ' 3: dd/mm/aa - Brasil 2 dig'
    convert(varchar, getdate(),   4) ' 4: dd.mm.aa'
    convert(varchar, getdate(),   5) ' 5: dd-mm-aa'
    convert(varchar, getdate(),   6) ' 6: dd mmm aa'
    convert(varchar, getdate(),   7) ' 7: mmm dd, aa'
    convert(varchar, getdate(),   8) ' 8: hh:mm:ss'
    convert(varchar, getdate(),   9) ' 9: mmm dd aaaa hh:mm:ss:mi XX'
    convert(varchar, getdate(),  10) '10: mm-dd-aa'
    convert(varchar, getdate(),  11) '11: aa/mm/dd'
    convert(varchar, getdate(),  12) '12: aammdd'
    convert(varchar, getdate(),  13) '13: dd mmm aaaa hh:mm:ss:mi'
    convert(varchar, getdate(),  14) '14: hh:mm:ss:mi'

    -- Ano com 4 digitos
    convert(varchar, getdate(), 100) '100 = 0'
    convert(varchar, getdate(), 101) '101: dd-mm-aaaa'
    convert(varchar, getdate(), 102) '102: aaa.mm.dd'
    convert(varchar, getdate(), 103) '103: dd/mm/aaaa - Brasil 4 dig'
    convert(varchar, getdate(), 104) '104: dd.mm.aaaa'
    convert(varchar, getdate(), 105) '105: dd-mm-aaaa'
    convert(varchar, getdate(), 106) '106: dd mmm aaaa'
    convert(varchar, getdate(), 107) '107: mmm dd, aaaa'
    convert(varchar, getdate(), 108) '108: hh:mm:ss'
    convert(varchar, getdate(), 109) '109 = 09'
    convert(varchar, getdate(), 110) '110: mm-dd-aaaa'
    convert(varchar, getdate(), 111) '111: aaaa-mm-dd'
    convert(varchar, getdate(), 112) '112: aaaammdd'
    convert(varchar, getdate(), 113) '113 = 13'
    convert(varchar, getdate(), 114) '114 = 14'
*/

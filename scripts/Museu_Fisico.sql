/* ------------------------
Banco: Museu 
Autor:
�ltima altera��o:
Descri��o: Curso Senai ABD
-------------------------*/

CREATE DATABASE Museu
GO

USE Museu
GO

CREATE TABLE Doador(
	codigo INT IDENTITY,
	nome VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Doador PRIMARY KEY (codigo)
)
GO

CREATE TABLE Pavilhao(
	codigo INT IDENTITY,
	logradouro VARCHAR(50),
	cep VARCHAR(15) NOT NULL,
	bairro VARCHAR(40),
	descricao VARCHAR(200) NOT NULL,
	CONSTRAINT PK_Pavilhao PRIMARY KEY (codigo) 
)
GO

CREATE TABLE PatrocinadorSecao(
	codigo INT IDENTITY,
	pavilhaoCodigo INT,
	nome VARCHAR(50) NOT NULL,
	tema VARCHAR(100) NOT NULL,
	CONSTRAINT PK_PatrocinadorSecao PRIMARY KEY (codigo),
	CONSTRAINT FK_PatrocinadorSecao_Pavilhao 
		FOREIGN KEY (pavilhaoCodigo) REFERENCES Pavilhao(codigo)
)
GO

CREATE TABLE Peca(
	codigo INT IDENTITY,
	doadorCodigo INT,
	patrocinadorSecaoCodigo INT,
	nome VARCHAR(50) NOT NULL,
	nacionalidade VARCHAR(25) NOT NULL,
	dataPeca INT NOT NULL,
	CONSTRAINT PK_Peca PRIMARY KEY (codigo),
	CONSTRAINT FK_Peca_Doador FOREIGN KEY (doadorCodigo) REFERENCES Doador(codigo),
	CONSTRAINT FK_Peca_PatrocinadorSecao FOREIGN KEY (patrocinadorSecaoCodigo) 
		REFERENCES PatrocinadorSecao(codigo),
)
GO

INSERT INTO Doador
VALUES ('Bartolomeu Marreiro Paix�o'),
	   ('Olivia Valadim Leiria'),
       ('Alexandra Macedo Porci�ncula')

SELECT * FROM Doador


INSERT INTO Pavilhao
VALUES ('Rua Paracatu', '04302021', 'Parque Imperial', 'Pavilh�o A'),
	   ('Rua Serra de Bragan�a', '03318000', 'Vila Gomes Cardim', 'Pavilh�o B'),
	   ('Rua Pereira Est�fano', '04144070', 'Vila da Sa�de', 'Pavilh�o C'),
	   ('Rua Bar�o de Vit�ria', '09961660', 'Casa Grande', 'Pavilh�o D')

SELECT * FROM Pavilhao



INSERT INTO PatrocinadorSecao
VALUES (2, 'Andriy Prada Tavares', 'Arte Moderna'),
       (4, 'Sienna Parracho Vilanova', 'Arte Contemporanea'),
	   (4, 'Tarsila do Amaral', 'Arte Barroca'),
       (1, 'Lueji Cangueiro Arruda', 'Arte Abstrata')

SELECT * FROM PatrocinadorSecao



-- doadorCodigo, patrocinadorSecaoCodigo, nome, nacionalidade, dataPeca
INSERT INTO Peca	
VALUES (1, 2, 'Hackovski', 'Brasil', 2020),
       (2, 3, 'VonNippy', 'Argentina', 2018),
       (3, 2, 'HystericalNippy', 'Col�mbia', 2019),
	   (3, 1, 'TruculentHack', 'Equador', 2019),
	   (2, 1, 'Nippychenko', 'Guiana', 2019),
	   (1, 4, 'Hackun', 'Uruguai', 2019),
	   (1, 4, 'Squalidlitz', 'Honduras', 2019),
	   (2, 4, 'BeethovenZone', 'Rep�blica Dominicana', 2019),
	   (3, 2, 'Zoneovski', 'M�xico', 2019),
	   (2, 2, 'Popkun', 'Chile', 2019),
	   (2, 3, 'Lavishchenko', 'Nicar�gua', 2019)

SELECT * FROM Peca



---> Consultas

-- 01. Quais foram os doadores das pe�as cadastradas?
-- 02. Quais pe�as est�o em cada se�ao?
-- 03. Quais se��es est�o em quais pavilh�es?
-- 04. Apresente as se��es, suas pe�as e seus respectivos doadores
-- 05. Apresente as pe�a, seu doador, a se��o, o patrocinador e o pavilh�o da exposi��o

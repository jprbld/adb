/* ------------------------
Banco: Museu 
Autor:
Ultima alteracao:
Descricao: Curso Senai ABD
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
VALUES ('Bartolomeu Marreiro Paixao'),
	   ('Olivia Valadim Leiria'),
       ('Alexandra Macedo Porcioncula')

SELECT * FROM Doador

INSERT INTO Pavilhao
VALUES ('Rua Paracatu', '04302021', 'Parque Imperial', 'Pavilhao A'),
	   ('Rua Serra de Braganca', '03318000', 'Vila Gomes Cardim', 'Pavilhao B'),
	   ('Rua Pereira Estefano', '04144070', 'Vila da Saude', 'Pavilhao C'),
	   ('Rua Barao de Vitoria', '09961660', 'Casa Grande', 'Pavilhao D')

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
       (3, 2, 'HystericalNippy', 'Colombia', 2019),
	   (3, 1, 'TruculentHack', 'Equador', 2019),
	   (2, 1, 'Nippychenko', 'Guiana', 2019),
	   (1, 4, 'Hackun', 'Uruguai', 2019),
	   (1, 4, 'Squalidlitz', 'Honduras', 2019),
	   (2, 4, 'BeethovenZone', 'Republica Dominicana', 2019),
	   (3, 2, 'Zoneovski', 'Mexico', 2019),
	   (2, 2, 'Popkun', 'Chile', 2019),
	   (2, 3, 'Lavishchenko', 'Nicaragua', 2019)

SELECT * FROM Peca

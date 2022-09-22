/* ------------------------
Banco: Museu 
Autor:
Última alteração:
Descrição: Curso Senai ABD
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
VALUES ('Bartolomeu Marreiro Paixão'),
	   ('Olivia Valadim Leiria'),
       ('Alexandra Macedo Porciúncula')

SELECT * FROM Doador


INSERT INTO Pavilhao
VALUES ('Rua Paracatu', '04302021', 'Parque Imperial', 'Pavilhão A'),
	   ('Rua Serra de Bragança', '03318000', 'Vila Gomes Cardim', 'Pavilhão B'),
	   ('Rua Pereira Estéfano', '04144070', 'Vila da Saúde', 'Pavilhão C'),
	   ('Rua Barão de Vitória', '09961660', 'Casa Grande', 'Pavilhão D')

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
       (3, 2, 'HystericalNippy', 'Colômbia', 2019),
	   (3, 1, 'TruculentHack', 'Equador', 2019),
	   (2, 1, 'Nippychenko', 'Guiana', 2019),
	   (1, 4, 'Hackun', 'Uruguai', 2019),
	   (1, 4, 'Squalidlitz', 'Honduras', 2019),
	   (2, 4, 'BeethovenZone', 'República Dominicana', 2019),
	   (3, 2, 'Zoneovski', 'México', 2019),
	   (2, 2, 'Popkun', 'Chile', 2019),
	   (2, 3, 'Lavishchenko', 'Nicarágua', 2019)

SELECT * FROM Peca



---> Consultas

-- 01. Quais foram os doadores das peças cadastradas?
-- 02. Quais peças estão em cada seçao?
-- 03. Quais seções estão em quais pavilhões?
-- 04. Apresente as seções, suas peças e seus respectivos doadores
-- 05. Apresente as peça, seu doador, a seção, o patrocinador e o pavilhão da exposição

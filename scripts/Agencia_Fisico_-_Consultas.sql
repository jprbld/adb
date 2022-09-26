/* ------------------------
Banco: Agencia 
Autor:
Última alteração:
Descrição: Curso Senai ABD
-------------------------*/

CREATE DATABASE Agencia
GO

USE Agencia
GO

CREATE TABLE Empresa(
	Codigo INT IDENTITY,
	nome VARCHAR(50),
	CONSTRAINT PK_EMPRESA PRIMARY KEY(codigo)
)
GO

CREATE TABLE Cargo(
	codigo INT IDENTITY,
	descricao VARCHAR(50),
	CONSTRAINT PK_CARGO PRIMARY KEY(codigo)
)
GO

CREATE TABLE Cncst(
	codigo INT IDENTITY,
	nomeCompleto VARCHAR(100),
	eixoTecnologico VARCHAR(100),
	cargaHoraria INT,
	CONSTRAINT PK_CNCST PRIMARY KEY(codigo)
)
GO

CREATE TABLE Curso(
	codigo INT IDENTITY,
	cncstCodigo INT,
	nome VARCHAR(50),
	CONSTRAINT PK_CURSO PRIMARY KEY(codigo),
	CONSTRAINT FK_CURSO_CNCST FOREIGN KEY (cncstCodigo) REFERENCES Cncst (codigo)
)
GO

CREATE TABLE Vaga(
	codigo INT IDENTITY,
	empresaCodigo INT,
	cargoCodigo INT,
	salario MONEY,
	horario INT,
	CONSTRAINT PK_VAGA PRIMARY KEY(codigo),
	CONSTRAINT FK_VAGA_EMPRESA FOREIGN KEY (empresaCodigo) REFERENCES EMPRESA (codigo),
	CONSTRAINT FK_VAGA_CARGO FOREIGN KEY (cargoCodigo) REFERENCES CARGO (codigo)
)
GO

CREATE TABLE Candidato(
	codigo INT IDENTITY,
	nome VARCHAR(50),
	cpf VARCHAR(15),
	dataNascimento DATE,
	CONSTRAINT PK_CANDIDATO PRIMARY KEY (codigo),
	CONSTRAINT UK_CANDIDATO UNIQUE (cpf),
)
GO

CREATE TABLE CandidatoVaga(
	candidatoCodigo INT,
	vagaCodigo INT,
	CONSTRAINT FK_CandidatoVaga_Candidato FOREIGN KEY (CandidatoCodigo) REFERENCES Candidato (codigo),
	CONSTRAINT FK_CandidatoVaga_Vaga FOREIGN KEY (vagaCodigo) REFERENCES Vaga (codigo)
)
GO

CREATE TABLE CandidatoCurso(
	CandidatoCodigo INT,
	CursoCodigo INT,
	CONSTRAINT FK_CandidatoCurso_Candidato FOREIGN KEY (candidatoCodigo) REFERENCES Candidato (codigo),
	CONSTRAINT FK_CandidatoCurso_Curso FOREIGN KEY (cursoCodigo) REFERENCES Curso (codigo)
)
GO



-- Inserções

INSERT INTO Empresa
VALUES ('Apple'),
	   ('Microsoft'),
	   ('Alphabet'),
	   ('Amazon'),
	   ('Meta')


INSERT INTO Cargo
VALUES ('Engenharia de dados'),
	   ('Especialista em cibersegurança'),
	   ('Engenharia de software'),
	   ('Desenvolvedor Frontend/Mobile'),
	   ('Analista de Business Intelligence'),
	   ('Especialista em midias digitais')


-- nomeCompleto, eixoTecnologico, cargaHoraria
INSERT INTO Cncst
VALUES ('CURSO SUPERIOR DE TECNOLOGIA EM AGROCOMPUTAÇÃO', 'INFORMAÇÃO E COMUNICAÇÃO', 2400),
	   ('CURSO SUPERIOR DE TECNOLOGIA EM ANÁLISE E DESENVOLVIMENTO DE SISTEMAS', 'INFORMAÇÃO E COMUNICAÇÃO', 2000),
	   ('CURSO SUPERIOR DE TECNOLOGIA EM BANCO DE DADOS', 'INFORMAÇÃO E COMUNICAÇÃO', 2000),
       ('CURSO SUPERIOR DE TECNOLOGIA EM DEFESA CIBERNÉTICA', 'INFORMAÇÃO E COMUNICAÇÃO', 2000),
	   ('CURSO SUPERIOR DE TECNOLOGIA EM GESTÃO DA TECNOLOGIA DA INFORMAÇÃO', 'INFORMAÇÃO E COMUNICAÇÃO', 2000),
	   ('CURSO SUPERIOR DE TECNOLOGIA EM GESTÃO DE TELECOMUNICAÇÕES', 'INFORMAÇÃO E COMUNICAÇÃO', 2400),
	   ('CURSO SUPERIOR DE TECNOLOGIA EM JOGOS DIGITAIS', 'INFORMAÇÃO E COMUNICAÇÃO', 2000),
	   ('CURSO SUPERIOR DE TECNOLOGIA EM REDES DE COMPUTADORES', 'INFORMAÇÃO E COMUNICAÇÃO', 2000),
	   ('CURSO SUPERIOR DE TECNOLOGIA EM REDES DE TELECOMUNICAÇÕES', 'INFORMAÇÃO E COMUNICAÇÃO', 2000),
	   ('CURSO SUPERIOR DE TECNOLOGIA EM SEGURANÇA DA INFORMAÇÃO', 'INFORMAÇÃO E COMUNICAÇÃO', 2000),
	   ('CURSO SUPERIOR DE TECNOLOGIA EM SISTEMAS DE TELECOMUNICAÇÕES', 'INFORMAÇÃO E COMUNICAÇÃO', 2400),
	   ('CURSO SUPERIOR DE TECNOLOGIA EM SISTEMAS EMBARCADOS', 'INFORMAÇÃO E COMUNICAÇÃO', 2400),
	   ('CURSO SUPERIOR DE TECNOLOGIA EM SISTEMAS PARA INTERNET', 'INFORMAÇÃO E COMUNICAÇÃO', 2000)


-- CncstCodigo, nome 
INSERT INTO Curso
VALUES (2, 'ADS'),
   	   (3, 'BD'),
	   (4, 'SEGURANÇA DA INFORMAÇÃO'),
	   (5, 'GTI'),
	   (7, 'JOGOS DIGITAIS'),
	   (8, 'REDES DE COMPUTADORES'),
	   (11, 'SISTEMAS DE TELECOMUNICAÇÕES'),
	   (13, 'SISTEMAS PARA INTERNET')


-- empresaCodigo, cargoCodigo, salario, horario
INSERT INTO Vaga
VALUES (2, 1, 25000.00, 8),
	   (2, 2, 10000.00, 4),
	   (2, 3, 27000.00, 8),
	   (1, 4, 18000.00, 8),
	   (1, 5, 30000.00, 8),
	   (4, 4, 19000.00, 8),
	   (4, 5, 29000.00, 8),
	   (3, 1, 24000.00, 8),
	   (3, 3, 26500.00, 8),
	   (5, 2, 12000.00, 4),	   
	   (5, 4, 18500.00, 8),
	   (5, 1, 15000.00, 6),
	   (5, 1, 25000.00, 8),
	   (2, 1, 26000.00, 8),
	   (1, 2, 16000.00, 6),
	   (1, 4, 19500.00, 8),
	   (2, 2, 10500.00, 4),
	   (4, 3, 14500.00, 6),
	   (4, 1, 25500.00, 8),	   
	   (2, 3, 27500.00, 8)	   	   
	
	   	
-- nome, cpf, dataNascimento
INSERT INTO Candidato
VALUES ('Bruna Grilo Fragoso','745.903.500-92','13/09/1969'),
	   ('Élton Carmo Galindo','525.422.230-17','28/10/1963'),
	   ('Mariam Bouça Alves','354.661.140-30','16/09/1959'),
   	   ('Keyson Anlicoara Setúbal','136.606.940-45','24/10/1966'),
	   ('Bella Mafra Paz','922.368.400-55','20/08/1992'),
	   ('Lázaro Negreiros César','012.656.670-47','27/10/1979'),
	   ('Zaira Hilário Farias','119.419.360-91','05/05/1985'),
	   ('Elijah Bernardes Varanda','281.178.960-01','14/01/1968'),
	   ('Abdul Saraiva Domingues','000.492.180-18','26/08/1959'),
	   ('Janira Almada Escobar','469.243.420-19','06/10/1990'),
	   ('Luis Rijo Teles','248.347.330-09','17/01/1971'),
	   ('Janice Lousã Saloio','086.733.790-75','23/05/2000'),
	   ('Nathaniel Caneira Boga','622.881.790-66','09/05/1986'),
	   ('Alex Malafaia Vargas','167.141.050-53','09/07/1984'),
	   ('Marília Santarém Estrela','890.812.300-85','20/04/1963'),
	   ('Fred Queiroga Cipriano','490.020.320-30','10/02/1962'),
	   ('Cíntia Frazão Arouca','121.304.130-99','11/01/1984'),
	   ('Rayan Quaresma Vilela','300.640.700-85','20/06/1987'),
	   ('Bryan Bezerra Boeira','920.582.730-44','08/03/1984'),
	   ('Sancho Leite Martins','102.981.280-20','25/06/1995'),
	   ('Milena Murteira Aleixo','096.193.840-40','07/07/1996'),
	   ('Valentino Chamusca Caparica','081.728.680-22','16/12/1997'),
	   ('Claúdio Ulhoa Matias','087.467.060-89','12/08/1964'),
	   ('Celeste Souto Gonçalves','242.531.090-80','13/10/1967'),
	   ('Angelina Baía Brás','035.729.100-05','11/06/1966')

		   
-- candidatoCodigo, vagaCodigo 
INSERT INTO CandidatoVaga
VALUES (1, 18),
	   (17, 2),
	   (21, 14),
	   (22, 12),
	   (11, 8),
	   (16, 3),
	   (12, 7),
	   (13, 6),
	   (2, 17),
	   (3, 16),
	   (4, 15),
	   (5, 14),
	   (18, 1),
	   (19, 18),
	   (20, 16),
	   (14, 5),
	   (15, 4),
	   (23, 10),
	   (24, 8),
	   (25, 6),
	   (6, 13),
	   (7, 12),
	   (8, 11),
	   (9, 10),
	   (10, 9),
	   (17, 10),
	   (18, 8),
	   (19, 6),
	   (20, 13),
	   (10, 15),
	   (11, 14),
	   (12, 1),
	   (13, 18),
	   (14, 16),
	   (21, 12),
	   (22, 11),
	   (23, 10),
	   (24, 9),
	   (6, 7),
	   (7, 6),
	   (8, 17),
	   (9, 16),
	   (1, 2),
	   (2, 14),
	   (3, 12),
	   (4, 8),
	   (5, 3),
	   (15, 5),
	   (16, 4)


-- candidatoCodigo, cursoCodigo
INSERT INTO CandidatoCurso
VALUES (1, 7),
	   (3, 8),
	   (4, 7),
	   (6, 6),
	   (16, 7),
	   (8, 4),
	   (9, 3),
	   (11, 2),
	   (18, 5),
	   (19, 4),
	   (21, 3),
	   (12, 1),
	   (13, 1),
	   (2, 2),
	   (7, 5),
	   (14, 8),
	   (17, 6),
	   (23, 1),
	   (24, 8),
	   (22, 2)



---> Consultas

USE Agencia

SELECT * FROM Vaga
SELECT * FROM Candidato
SELECT * FROM Cargo
SELECT * FROM Empresa


-- 01. Consulte todas as vagas por cargo - Vaga (0,n) <--> (1,1) Cargo

-- 02. Consulte todas as vagas por empresa - Vaga (1,n) <--> (1,1) Empresa

-- 03. Consulte todos os cursos e seus nomes completos no CNCST - Curso (0,1) <--> (1,1) CNCST

-- 04. Consulte todos os candidatos que possuem formação 
-- Candidato (0,1) <--> (0,n) CandidatoCurso
-- CandidatoCurso (0,n) <--> (0,1) Curso

-- 05. Consulte todos os candidatos por vaga 
-- Candidato (0,1) <--> (0,n) CandidatoVaga
-- CandidatoVaga (1,n) <--> (1,1) Vaga

-- 06. Consulte todos os candidatos por vaga e cargo
-- Candidato (0,1) <--> (0,n) CandidatoVaga
-- CandidatoVaga (1,n) <--> (1,1) Vaga
-- Vaga (0,n) <--> (1,1) Cargo 

-- 07. Consulte todos os candidatos por vaga e empresa
-- Candidato (0,1) <--> (0,n) CandidatoVaga
-- CandidatoVaga (1,n) <--> (1,1) Vaga
-- Vaga (0,n) <--> (1,1) Empresa 

-- 08. Consulte todos os candidatos por vaga, cargo e empresa
-- Candidato (0,1) <--> (0,n) CandidatoVaga
-- CandidatoVaga (1,n) <--> (1,1) Vaga
-- Vaga (0,n) <--> (1,1) Cargo 
-- Vaga (0,n) <--> (1,1) Empresa 

-- 09. Quantidade de cargos por empresa
-- Cargo (1,1) <--> (0,n) Vaga
-- Vaga (1,n) <--> (1,1) Empresa

-- 10. Quantidade de candidatos por vaga
-- Candidato (0,1) <--> (0,n) CandidatoVaga
-- CandidatoVaga (1,n) <--> (1,1) Vaga
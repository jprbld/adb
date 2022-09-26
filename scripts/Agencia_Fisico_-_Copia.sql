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
	nome VARCHAR(50)
)
GO

CREATE TABLE Cargo(
	codigo INT IDENTITY,
	descricao VARCHAR(50)
)
GO

CREATE TABLE Cncst(
	codigo INT IDENTITY,
	nomeCompleto VARCHAR(100),
	eixoTecnologico VARCHAR(100),
	cargaHoraria INT
)
GO

CREATE TABLE Curso(
	codigo INT IDENTITY,
	cncstCodigo INT,
	nome VARCHAR(50)
)
GO

CREATE TABLE Vaga(
	codigo INT IDENTITY,
	empresaCodigo INT,
	cargoCodigo INT,
	salario MONEY,
	horario INT
)
GO

CREATE TABLE Candidato(
	codigo INT IDENTITY,
	nome VARCHAR(50),
	cpf VARCHAR(15),
	dataNascimento DATE,
	CONSTRAINT PK_CANDIDATO PRIMARY KEY (codigo),
	CONSTRAINT UK_CANDIDATO UNIQUE (cpf)
)
GO

CREATE TABLE CandidatoVaga(
	candidatoCodigo INT,
	vagaCodigo INT
)
GO

CREATE TABLE CandidatoCurso(
	CandidatoCodigo INT,
	CursoCodigo INT
)
GO
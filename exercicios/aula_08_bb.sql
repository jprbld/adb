
-- CREATE Database
CREATE DATABASE Biblioteca
GO

USE Biblioteca
GO

CREATE TABLE Aluno(
  codigo INT IDENTITY NOT NULL,
  nome NVARCHAR(50),
  rm NVARCHAR(10),
  bloqueado BIT,
  CONSTRAINT PK_Cliente PRIMARY KEY(codigo)
)
GO

CREATE TABLE Publicacao(
  codigo INT IDENTITY NOT NULL,
  isbn NVARCHAR(25),
  titulo NVARCHAR(50),
  disponivel BIT,
  CONSTRAINT PK_Publicacao PRIMARY KEY(codigo)
)
GO

CREATE TABLE Autor(
  codigo INT IDENTITY NOT NULL,
  nome NVARCHAR(50),
  CONSTRAINT PK_Autor PRIMARY KEY(codigo)
)
GO

CREATE TABLE Genero(
  codigo INT IDENTITY NOT NULL,
  descricao NVARCHAR(50),
  CONSTRAINT PK_Genero PRIMARY KEY(codigo)
)
GO

CREATE TABLE Prateleira(
  codigo INT IDENTITY NOT NULL,
  descricao NVARCHAR(20),
  CONSTRAINT PK_Prateleira PRIMARY KEY(codigo)
)
GO

CREATE TABLE Emprestimo(
  codigo INT IDENTITY NOT NULL,
  dataEmprestimo DATE,
  dataLimite DATE,
  dataDevolucao DATE,
  CONSTRAINT PK_Emprestimo PRIMARY KEY(codigo)
)
GO

INSERT INTO Aluno
VALUES
('Silas Pedrosa', '9987789', 0),
('Silas Pedroso', '9987788', 0),
('Luiz Barroso', '9987786', 0),
('Anita Cassia', '9987784', 0),
('Rubia Castro', '9987780', 1)
GO
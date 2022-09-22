-- sqlserver

\*
Banco locadora
*\

-- CREATE Database
IF EXISTS(
  SELECT name FROM master.dbo.sysdatabases 
  WHERE name = N'Locadora'
)
BEGIN
    SELECT 'Database Locadora already Exists' AS Message
END
ELSE
BEGIN
    CREATE DATABASE Locadora
    SELECT 'DB Locadora is Stored'
END
GO

-- -- -- DROP database
-- -- IF EXISTS 
-- --    (
-- --      SELECT name FROM master.dbo.sysdatabases 
-- --      WHERE name = N'Locadora'
-- --     )
-- -- DROP DATABASE Locadora
-- -- GO

USE Locadora
GO

-- -- -- DROP table
-- -- DROP TABLE Cliente

IF NOT EXISTS(
  SELECT * FROM sysobjects WHERE name='Cliente' and xtype='U'
)
BEGIN
  CREATE TABLE Cliente(
    codigo INT IDENTITY NOT NULL,
    cpf NVARCHAR(20) NOT NULL,
    rg NVARCHAR(20),
    cnh NVARCHAR(15),
    nome NVARCHAR(50) NOT NULL,
    logradouro NVARCHAR(40),
    bairro NVARCHAR(30),
    cidade NVARCHAR(30),
    uf CHAR(2),
    cep NVARCHAR(15),
    endereco NVARCHAR(100),
    dataNascimento DATE,
    CONSTRAINT PK_Cliente PRIMARY KEY(codigo),
    CONSTRAINT UK_Cliente_cpf UNIQUE(cpf),
    CONSTRAINT UK_Cliente_cnh UNIQUE(cnh),
    CONSTRAINT UK_Cliente_rg UNIQUE(rg)
  )
  SELECT 'Table Cliente Stored' AS Message
END
ELSE
BEGIN
  SELECT 'Table Cliente already Exists' AS Message
END
GO

-- INSERT INTO Cliente
--   (cpf, rg, cnh, nome, endereco, dataNascimento)
-- VALUES
--   ('489.363.310-43', 
--   '28.080.124-5', 
--   '06145434500', 
--   'Sheila Tuna Espirito Santo', 
--   'Avenida São João', 
--   '06/05/1961')
-- GO

-- INSERT INTO Cliente
--   (cpf, rg, cnh, nome, endereco, dataNascimento)
-- VALUES
--   ('489.363.310-43', 
--   '28.080.124-5', 
--   '06145434500', 
--   'Sheila Tuna Espirito Santo', 
--   'Avenida São Bernardo', 
--   '06/05/1961')
-- GO

-- SELECT * FROM Cliente
-- GO

INSERT INTO Cliente(
  cpf,
  rg,
  nome,
  cidade
)
VALUES(
  '123.456.789-00',
  '9.780.345',
  'Asdrubal de Oliveira',
  'Campinas'
)

SELECT * FROM Cliente

CREATE TABLE Veiculo(
  codigo INT IDENTITY NOT NULL,
  chassi NVARCHAR(50) NOT NULL,
  placa NVARCHAR(25),
  marca NVARCHAR(30),
  modelo NVARCHAR(100),
  anoFabricacao INT,
  anoModelo INT,
  cor NVARCHAR(25),
  CONSTRAINT PK_Veiculo PRIMARY KEY(codigo),
  CONSTRAINT UK_Veiculo UNIQUE(placa, chassi)
)
GO

INSERT INTO Veiculo
  (chassi, placa, marca, modelo, anoFabricacao, anoModelo, cor)
VALUES
  ('6kk pGAAuc e6 XX0764', 'KJO-3028', 'Dodge', 'Dodge, Ram 2500 H.DUTY 5.9 SLT 24V CD 4x4 Dies.', 2004, 2004, 'Preto')
GO

CREATE TABLE Categoria(
    codigo INT IDENTITY,
    nome CHAR(25) NOT NULL,
    preco DECIMAL(10,2),
    descricao NVARCHAR(100),
    CONSTRAINT PK_Categoria PRIMARY KEY(codigo)
)
GO

INSERT INTO Categoria
VALUES
('SUV', 300000,00, 'Alto Padrao'),
('Hatch', 70000,00, 'Economico'),
('Sedan', 100000, 'Espaço'),
('Hibrido', 150000, 'Leve')
GO

SELECT * FROM Categoria
GO


\*
Banco: locadora
Autor: Joao Paulo Rodrigues de Andrade
ultima alteracao: 26/08/2022
descricao: Curso Senai ABD
*\

-- CREATE Database
CREATE DATABASE Locadora
GO

USE Locadora
GO

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
  dataNascimento DATE,
  CONSTRAINT PK_Cliente PRIMARY KEY(codigo),
  CONSTRAINT UK_Cliente_cpf UNIQUE(cpf),
  CONSTRAINT UK_Cliente_cnh UNIQUE(cnh),
  CONSTRAINT UK_Cliente_rg UNIQUE(rg)
)
GO

CREATE TABLE Veiculo(
  codigo INT IDENTITY NOT NULL,
  chassi NVARCHAR(25) NOT NULL,
  placa NVARCHAR(15),
  marca NVARCHAR(25),
  modelo NVARCHAR(25),
  anoFabricacao INT,
  anoModelo INT,
  cor NVARCHAR(25),
  CONSTRAINT PK_Veiculo PRIMARY KEY(codigo),
  CONSTRAINT UK_Veiculo UNIQUE(placa, chassi)
)
GO

CREATE TABLE Categoria(
    codigo INT IDENTITY,
    nome CHAR(25) NOT NULL,
    preco DECIMAL(10,2),
    descricao NVARCHAR(100),
    CONSTRAINT PK_Categoria PRIMARY KEY(codigo)
)
GO

CREATE TABLE Veiculo(
  codigo INT IDENTITY NOT NULL,
  codigo_categoria INT,
  chassi NVARCHAR(25) NOT NULL,
  placa NVARCHAR(15),
  marca NVARCHAR(25),
  modelo NVARCHAR(25),
  anoFabricacao INT,
  anoModelo INT,
  CONSTRAINT PK_Veiculo PRIMARY KEY(codigo),
  CONSTRAINT UK_Veiculo_placa UNIQUE(placa)
  CONSTRAINT UK_Veiculo_chassi UNIQUE(chassi)
  CONSTRAINT FK_Veiculo_categoria FOREIGN KEY (codigo_categoria) REFERENCES Categoria(codigo)
)
GO

CREATE TABLE Locacao(
  codigo INT IDENTITY,
  codigo_cliente INT,
  codigo_veiculo INT,
  dataHoraRetirada DATETIME NOT NULL,
  dataHoraDevolucao DATETIME
  CONSTRAINT PK_Locacao PRIMARY KEY (codigo)
  CONSTRAINT FK_Locacao_cliente FOREIGN KEY (codigo_cliente) REFERENCES Cliente(codigo)
  CONSTRAINT FK_Locacao_veiculo FOREIGN KEY(codigo_veiculo) REFERENCES Veiculo(codigo)
)
GO

CREATE TABLE Oficina(
  codigo INT IDENTITY,
  nome NVARCHAR(100)(
  CONSTRAINT PK_Oficina PRIMARY KEY (codigo)
)
GO

CREATE TABLE Manutencao(
  codigo INT IDENTITY,
  codigo_veiculo INT,
  dataManutencao DATE NOT NULL,
  valor MONEY,
  descricao NVARCHAR(500),
  cod_oficina INT
  CONSTRAINT FK_Manutencao_Oficina FOREIGN KEY (cod_oficina) REFERENCES Oficina (codigo)
)
GO

ALTER TABLE Manutencao
  ADD CONSTRAINT PK_Manutencao PRIMARY KEY(codigo)
GO
ALTER TABLE Manutencao
  ADD CONSTRAINT FK_Manutencao_Veiculo FOREIGN KEY (codigo_veiculo) REFERENCES Veiculo (codigo)
GO

INSERT INTO Cliente 
  VALUES
  ('019.393.447-57', '18.596.963-9', '72025945156', 'Danilo Almeida', 'Rua 6', 'Jabuticabal', 'Recife', 'PE', '54334556', '15/06/1988'),
  ('019.393.447-59', '18.596.983-9', '72025945152', 'Danilo Silva', 'Rua 10', 'Boa Vista', 'Recife', 'PE', '54334557', '15/06/1990'),
  ('019.393.437-59', '11.596.983-9', '72025935152', 'Bianca Carvalho', 'Rua 11', 'Santo Antonio', 'Recife', 'PE', '54334552', '03/02/1980'),
  ('019.343.437-59', '12.596.983-9', '72025935552', 'Aline Vasconcelos', 'Rua 12', 'Sao Pedro', 'Recife', 'PE', '54334555', '03/04/1984')

INSERT INTO Categoria
VALUES
('SUV', 300000,00, 'Alto Padrao'),
('Hatch', 70000,00, 'Economico'),
('Sedan', 100000, 'Espaço'),
('Hibrido', 150000, 'Leve')
GO

INSERT INTO Veiculo
(codigo_categoria, chassi, placa, marca, modelo, anoModelo, anoFabricacao)
VALUES
(1, '3D6 BHZSr0 sb A66359', 'HPO-6568', 'Jaguar', 'S-Type 4.2/ 4.2 SE/ 4.0 V8 32V', '2000', '2000'),
(3, '8xC dA6Pj1 AA H16290', 'HQB-8284', 'Buggy', 'Buggy 1.6 2-Lug.', '1988', '1988'),
(4, '8xC dA6Pj1 AA H16290', 'HOU-4633', 'CHANGAN', 'MINI STAR Utility 1.0 8V 53cv (Furg', '2012', '2012')


-- -- DELETAR tabela
-- DROP TABLE Cliente
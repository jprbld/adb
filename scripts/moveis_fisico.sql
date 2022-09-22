\*
Banco: Moveis
Autor: Joao Paulo Rodrigues de Andrade
Ultima alteracao: 
Descricao: Curso Senai ABD
*\


CREATE DATABASE Moveis
GO

USE Moveis
GO

CREATE TABLE Produto(
  codigo INT IDENTITY,
  descricao VARCHAR(60),
  precoCusto SMALLMONEY,
  precoVenda SMALLMONEY,
  CONSTRAINT PK_Produto PRIMARY KEY (codigo)
)
GO

CREATE TABLE Vendedor(
  codigo INT IDENTITY,
  nome VARCHAR(50),
  cpf VARCHAR(15),
  logradouro VARCHAR(60),
  bairro VARCHAR(50),
  cep VARCHAR(15),
  porcentagem FLOAT,
  CONSTRAINT PK_Vendedor PRIMARY KEY (codigo),
  CONSTRAINT UK_Vendedor UNIQUE (cpf)
)
GO

CREATE TABLE Cliente(
  codigo INT IDENTITY,
  nome VARCHAR(50),
  cpf VARCHAR(15),
  logradouro VARCHAR(60),
  bairro VARCHAR(60),
  cep VARCHAR(15),
  CONSTRAINT PK_Cliente PRIMARY KEY (codigo),
  CONSTRAINT UK_Cliente UNIQUE (cpf)
)
GO

CREATE TABLE TelefoneCliente(
  codigo INT IDENTITY,
  cliente_codigo INT,
  telefone VARCHAR(15)
  CONSTRAINT PK_TelefoneCliente PRIMARY KEY (codigo)
  CONSTRAINT FK_TelefoneCliente_Cliente FOREIGN KEY (cliente_codigo) REFERENCES Cliente (codigo)
)
GO

CREATE TABLE EmailCliente(
  codigo INT IDENTITY,
  cliente_codigo INT,
  email VARCHAR(15)
  CONSTRAINT PK_EmailCliente PRIMARY KEY (codigo)
  CONSTRAINT FK_EmailCliente_Cliente FOREIGN KEY (cliente_codigo) REFERENCES Cliente (codigo)
)
GO

CREATE TABLE Motorista(
  codigo INT IDENTITY,
  nome VARCHAR(50),
  cnh VARCHAR(15),
  CONSTRAINT PK_Motorista PRIMARY KEY (codigo),
  CONSTRAINT UK_Motorista UNIQUE (cnh)
)
GO

CREATE TABLE TelefoneMotorista(
  codigo INT IDENTITY,
  motorista_codigo INT,
  telefone VARCHAR(15),
  CONSTRAINT PK_TelefoneMotorista PRIMARY KEY (codigo),
  CONSTRAINT FK_TelefoneMotorista_Motorista FOREIGN KEY (motorista_codigo) REFERENCES Motorista (codigo)
)
GO

CREATE TABLE Venda(
  numero INT IDENTITY,
  serie INT,
  clienteCodigo INT,
  vendendorCodigo INT,
  dataEmissao DATE,
  valorTotal SMALLMONEY,
  CONSTRAINT PK_Venda PRIMARY KEY (numero, serie),
  CONSTRAINT FK_Venda_Cliente (clienteCodigo) REFERENCES Cliente (codigo),
  CONSTRAINT FK_Venda_Vendendor (vendendorCodigo) REFERENCES Vendedor (codigo)
)
GO

CREATE TABLE ItemVenda(
  vendaNumero INT,
  vendaSerie INT,
  produtoCodigo INT,
  quantidade INT,
  valorItem SMALLMONEY,
  CONSTRAINT PK_ItemVenda PRIMARY KEY (vendaNumero, vendaSerie, produtoCodigo),
  CONSTRAINT FK_ItemVenda_Venda FOREIGN KEY (vendaNumero, vendaSerie) REFERENCES Venda (numero, serie),
  CONSTRAINT FK_ItemVenda_produto (produtoCodigo) REFERENCES Produto (codigo)
)
GO

CREATE TABLE Entrega(
  vendaNumero INT,
  vendaSerie INT,
  motoristaCodigo INT,
  CONSTRAINT PK_Entrega PRIMARY KEY (vendaNumero, vendaSerie, motoristaCodigo),
  CONSTRAINT FK_Entrega_Venda FOREIGN KEY (vendaNumero, vendaSerie) REFERENCES Venda (numero, serie),
  CONSTRAINT FK_Entrega_Motorista (motoristaCodigo) REFERENCES Motorista (codigo)
)
GO
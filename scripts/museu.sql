CREATE DATABASE museu
GO

USE museu
GO

CREATE TABLE doador(
  cod INT IDENTITY NOT NULL,
  nome NVARCHAR(40) NOT NULL,
  CONSTRAINT PRIMARY KEY (cod)
)
GO

INSERT INTO doador
VALUES
('Cicero'),
('Camila'),
('Fabia'),
('Asdrubal')
GO

CREATE TABLE peca(
  cod INT IDENTITY NOT NULL,
  data_peca DATE,
  nacionalidade NVARCHAR(30),
  nome NVARCHAR(40) NOT NULL,
  cod_doador INT,
  CONSTRAINT PRIMARY KEY (cod),
  CONSTRAINT FK_peca_doador FOREIGN KEY cod_doador REFERENCES doador (cod)
)
GO

INSERT INTO peca
(nome, cod_doador)
VALUES
('p1', 1),
('p2', 2),
('p3', 3),
('p4', 4),
('p5', 2)
GO

CREATE TABLE patrocinador(
  cod INT IDENTITY NOT NULL,
  nome NVARCHAR(100),
  CONSTRAINT PRIMARY KEY (cod)
)
GO

INSERT INTO patrocinador
VALUES
('Aldo'),
('Amaral'),
('Aline'),
('Alicia')
GO

CREATE TABLE secao(
  cod INT IDENTITY NOT NULL,
  tema NVARCHAR(100),
  cod_patrocinador INT,
  cod_peca INT,
  CONSTRAINT PRIMARY KEY (cod),
  CONSTRAINT FK_secao_patrocinador (cod_patrocinador) REFERENCES patrocinador (cod),
  CONSTRAINT FK_secao_peca (cod_peca) REFERENCES peca (cod)
)
GO

INSERT INTO secao
(tema, cod_patrocinador, cod_peca)
VALUES
('t1', 1, 1),
('t2', 2, 2),
('t3', 3, 3),
('t4', 4, 4),

CREATE TABLE pavilhao(
  cod INT IDENTITY NOT NULL,
  descricao NVARCHAR(100),
  endereco NVARCHAR(200),
  cod_secao INT,
  CONSTRAINT PRIMARY KEY (cod),
  CONSTRAINT FK_pavilhao_secao (cod_secao) REFERENCES secao (cod)
)
GO


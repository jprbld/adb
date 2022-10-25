USE Locadora
GO

-- Recebe um estado (UF) e retorna quantos clientes a locadora possui nesse estado

CREATE OR ALTER FUNCTION TotalClientes(@Uf as VARCHAR(3)) RETURNS INT
AS
BEGIN
	DECLARE @Cont as INT

	SELECT
		@Cont = COUNT(DISTINCT(C.codigo))
	FROM Cliente AS C
	WHERE C.uf = @Uf

	RETURN @Cont
END
GO


-- Recebe a placa de um veiculo e retorna se ele passou por manutencao ou nao

CREATE OR ALTER FUNCTION VeiculoManutencao(@Placa as VARCHAR(10)) RETURNS BIT
AS
BEGIN
	DECLARE @Resp AS INT

	SELECT @Resp = COUNT(M.veiculo_codigo)
	FROM Veiculo AS V
	INNER JOIN Manutencao AS M ON V.codigo = M.veiculo_codigo
	WHERE V.placa = @Placa

RETURN 1
END
GO

SELECT * FROM Veiculo
SELECT dbo.VeiculoManutencao('BFR-4608')
GO

-- Recebe o cpf de um cliente e retorna o valor total que ele ja gastou com locacoes
CREATE OR ALTER FUNCTION ValorLocacao(@Cpf VARCHAR(15)) RETURNS VARCHAR(15)
AS
BEGIN
	DECLARE @valor VARCHAR(15)

	SELECT @valor = FORMAT(SUM(DATEDIFF(DAY, L.dataHoraRetirada, L.dataHoraDevolucao))* CA.preco,'C','pt-br')
	FROM Cliente AS C
		INNER JOIN Locacao AS L ON C.codigo = L.cliente_codigo
		INNER JOIN Veiculo AS V ON L.veiculo_codigo = V.codigo
		INNER JOIN Categoria AS CA ON V.categoria_codigo = CA.codigo
	GROUP BY C.cpf,L.cliente_codigo, CA.preco
	
	RETURN @valor
END
GO

SELECT dbo.ValorLocacao('910.391.760-62')
GO

-- Recebe o ano do modelo do veiculo e retorna a marca, modelo e cor dos veiculos

CREATE OR ALTER FUNCTION DadosFromAno(@Ano INT) RETURNS @Dados TABLE( marca VARCHAR(20), 
																  modelo VARCHAR(50),
																  nome VARCHAR(15))

AS
BEGIN

	INSERT INTO @Dados(marca, modelo, nome)
	
	SELECT 
		V.marca,
		V.modelo,
		C.nome
	
	FROM Veiculo AS V
	INNER JOIN VeiculoCor AS VC ON V.codigo = VC.veiculoCodigo
	INNER JOIN Cor AS C ON VC.corCodigo = C.codigo
	WHERE V.anoModelo = @Ano
	
	RETURN
END
GO

SELECT * FROM dbo.DadosFromAno(2020)
GO

-- Recebe um mes e ano de retirada e retorna as locacoes desse periodo (cliente, marca, modelo, retirada e devolucao)


CREATE OR ALTER FUNCTION LocacoesPeriodo(@Mes INT, @Ano INT) RETURNS @Locacoes TABLE( Cliente VARCHAR(50),
																									Marca VARCHAR(20),
																									Modelo VARCHAR(50),
																									Retirada VARCHAR(15),
																									Devolucao VARCHAR(15))

AS
BEGIN
	INSERT INTO @Locacoes(Cliente, Marca, Modelo, Retirada, Devolucao)
		SELECT
			C.nome,
			V.marca,
			V.modelo,
			CONVERT(VARCHAR, L.dataHoraRetirada, 103),
			CONVERT(VARCHAR, L.dataHoraDevolucao, 103)
			
		FROM Cliente AS C
		INNER JOIN Locacao AS L ON C.codigo = L.cliente_codigo
		INNER JOIN Veiculo AS V ON L.veiculo_codigo = V.codigo
		WHERE MONTH(L.dataHoraRetirada)= @Mes AND YEAR(L.dataHoraRetirada) = @Ano

	RETURN
END
GO


SELECT * FROM dbo.LocacoesPeriodo (01,2022)
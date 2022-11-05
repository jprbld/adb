--> Tratamento de erros 
/*
	Número do erro
	Estado
	Nível de severidade
	Linha
	Mensagem
*/

USE Moveis


SELECT *
FRON Cliente

-- Mensagem 102, Nível 15, Estado 1, Linha 1839
-- Sintaxe incorreta próxima a 'FRON'.


SELECT *
FROM Clientes

-- Mensagem 208, Nível 16, Estado 1, Linha 1845
-- Nome de objeto 'Clientes' inválido.


DECLARE @Quantidade INT
SET @Quantidade = 12345678901234567890

-- Mensagem 8115, Nível 16, Estado 2, Linha 1853
-- Erro de estouro aritmético ao converter expression no tipo de dados int.


SELECT *
FROM Cliente

-- Permite (ou não) inserções em atributos IDENTITY
SET IDENTITY_INSERT dbo.Cliente ON
SET IDENTITY_INSERT dbo.Cliente OFF

INSERT INTO Cliente
	(codigo, nome, cpf)
VALUES
	(5, 'Zé', '123456789')
GO

-- Mensagem 544, Nível 16, Estado 1, Linha 1862
-- Não é possível inserir um valor explícito para a coluna de identidade na tabela 'Cliente'
-- quando IDENTITY_INSERT está definido como OFF.

-- Mensagem 515, Nível 16, Estado 2, Linha 1865
-- Não é possível inserir o valor NULL na coluna 'cpf', 
-- tabela 'Moveis.dbo.Cliente'; a coluna não permite nulos. Falha em INSERT.

-- Mensagem 2627, Nível 14, Estado 1, Linha 1865
-- Violação da restrição PRIMARY KEY 'PK_Cliente'. 
-- Não é possível inserir a chave duplicada no objeto 'dbo.Cliente'. 
-- O valor de chave duplicada é (5).



--> TRY..CATH 

/*
	instrução 
	instrução

	BEGIN TRY
		instrução 
		instrução
		instrução
	END TRY
	BEGIN CATCH
		Instruções de tratamento (preventivo)
	END CATCH

	instrução 
	instrução
*/


BEGIN
	DECLARE @Cod INT = 5,
	        @Nome VARCHAR(50) = 'Zé',
			@Cpf VARCHAR(20)= '123456789-00'

	BEGIN TRY
		
		INSERT INTO Cliente
			(codigo, nome, cpf)
		VALUES
			(@Cod, @Nome, @Cpf)
		
		-- SELECT * FROM Cliente

		RAISERROR('Deu tudo certo!', -- Mensagem
		           10, -- Nível se severidade
				   1   -- Estado
				 )	
	END TRY

	BEGIN CATCH
		RAISERROR('Entrou no Catch...', 10, 1)
	END CATCH

END
GO


---------------------------------------------------------------------

BEGIN
	DECLARE @Cod INT = 5,
	        @Nome VARCHAR(50) = 'Zé',
			@Cpf VARCHAR(20)= '123456789-00'

	BEGIN TRY
		
		INSERT INTO Cliente
			(codigo, nome, cpf)
		VALUES
			(@Cod, @Nome, @Cpf)
		
		-- SELECT * FROM Cliente

		IF @@ROWCOUNT > 0
			BEGIN
				RAISERROR('Deu tudo certo!', 10, 1)
			END
		ELSE
			BEGIN
				RAISERROR('Falha na inclusão do Cliente!', 10, 1)
			END
		
	END TRY

	BEGIN CATCH
		RAISERROR('Finalizar os processos..', 10, 1)
		RAISERROR('Finalizar as transações..', 10, 1)
		RAISERROR('Finalizar as sessão..', 10, 1)
		RAISERROR('Direcionar o tratamento do erro..', 10, 1)

		PRINT ERROR_NUMBER()
		PRINT ERROR_MESSAGE()
		PRINT ERROR_SEVERITY()
		PRINT ERROR_STATE()
		PRINT ERROR_LINE()
	END CATCH

END
GO

---------------------------------------------------------------------
SET IDENTITY_INSERT dbo.Cliente ON
SET IDENTITY_INSERT dbo.Cliente OFF

BEGIN
	SET NOCOUNT ON
	DECLARE @Cod INT = 10,
	        @Nome VARCHAR(50) = 'Zé',
			@Cpf VARCHAR(20)= '123456789-00',
			@LinhasAfetadas INT,
			@Erro INT,
			@Mensagem VARCHAR(200),
			@Severidade INT,
			@Estado INT,
			@Linha INT

	BEGIN TRY
				
		INSERT INTO Cliente
			(codigo, nome, cpf)
		VALUES
			(@Cod, @Nome, @Cpf)
		
		-- SELECT * FROM Cliente WHERE codigo = '10'

		SET @LinhasAfetadas = @@ROWCOUNT

		IF @LinhasAfetadas > 0
			BEGIN
				RAISERROR('Deu tudo certo!', 10, 1)
			END
		ELSE
			BEGIN
				RAISERROR('Nenhuma linha afetada!', 10, 1)
			END

		RAISERROR('Última instrução do TRY...', 10, 1)

	END TRY

	BEGIN CATCH

		SET @Erro = @@ERROR

		IF @Erro = 544
			BEGIN
			    SET @Mensagem = ERROR_MESSAGE()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Não é possível inserir um valor no atributo codigo (IDENTITY)', 10, 1)
			END

		ELSE IF @Erro = 515
			BEGIN
			    SET @Mensagem = ERROR_MESSAGE()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('O atributo CPF é obrigatório.', 10, 1)
			END

		ELSE IF @Erro = 2627
			BEGIN
			    SET @Mensagem = ERROR_MESSAGE()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('A código (chave primaria) não pode ser duplicado!', 10, 1)
			END

		ELSE
			BEGIN
				SET @Erro = ERROR_NUMBER()
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				SET @Estado = ERROR_STATE()
				SET @Linha = ERROR_LINE()

				RAISERROR('Erro imprevisto: %d - %s. Severidade: %d. Estado: %d. Linha: %d', 10, 1, 
				          @Erro, @Mensagem, @Severidade, @Estado, @Linha)
			END

	END CATCH

END
GO


---------------------------------------------------------------------

BEGIN
	SET NOCOUNT ON
	DECLARE @Cod INT = 10,
	        @Nome VARCHAR(50) = 'Zé',
			@Cpf VARCHAR(20) = '123456789012345',
			@LinhasAfetadas INT,
			@Erro INT,
			@Mensagem VARCHAR(200),
			@Severidade INT,
			@Estado INT,
			@Linha INT

	BEGIN TRY
		
		-- Erro do Cliente Nativo (50000)
		IF LEN(@Cpf) > 11
			BEGIN
				RAISERROR('Erro! Quantidade de digitos excedido!', 11, 1)
			END


		INSERT INTO Cliente
			(codigo, nome, cpf)
		VALUES
			(@Cod, @Nome, @Cpf)
		
		-- SELECT * FROM Cliente WHERE codigo = '10'

		SET @LinhasAfetadas = @@ROWCOUNT

		IF @LinhasAfetadas > 0
			BEGIN
				RAISERROR('Deu tudo certo!', 10, 1)
			END
		ELSE
			BEGIN
				RAISERROR('Nenhuma linha afetada!', 10, 1)
			END

		RAISERROR('Última instrução do TRY...', 10, 1)

	END TRY

	BEGIN CATCH

		SET @Erro = @@ERROR

		IF @Erro = 544
			BEGIN
			    SET @Mensagem = ERROR_MESSAGE()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Não é possível inserir um valor no atributo codigo (IDENTITY)', 10, 1)
			END

		ELSE IF @Erro = 515
			BEGIN
			    SET @Mensagem = ERROR_MESSAGE()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('O atributo CPF é obrigatório.', 10, 1)
			END

		ELSE IF @Erro = 2627
			BEGIN
			    SET @Mensagem = ERROR_MESSAGE()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('A código (chave primaria) não pode ser duplicado!', 10, 1)
			END

		ELSE
			BEGIN
				SET @Erro = ERROR_NUMBER()
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				SET @Estado = ERROR_STATE()
				SET @Linha = ERROR_LINE()

				RAISERROR('Erro imprevisto: %d - %s. Severidade: %d. Estado: %d. Linha: %d', 10, 1, 
				          @Erro, @Mensagem, @Severidade, @Estado, @Linha)
			END

	END CATCH

END
GO
USE Agencia
GO

SELECT * FROM Vaga

/*
Script para inser��o de uma vaga - Parte 1
* Crie vari�veis para armazenar o c�digo da empresa, o codigo do cargo, o salario e o hor�rio
* Crie a instru��o INSERT utilizando as vari�veis
* Verifique a quantidade de linhas afetadas e apresente uma das duas mensagens:
  - Vaga inserida com sucesso!
  - Falha ao inserir vaga!

Observa��es:

Teste com valores v�lidos, por exemplo:
	@Empresa = 2
	@Cargo = 1
	@Salario = 15000.00
	@Horario = 8
E com valores inv�lidos (para empresa e/ou cargo)

Todas as mensagem devem ser apresentadas utilizando a fun��o RAISERROR()

*/

BEGIN
	DECLARE @Empresa INT = 100
	DECLARE @Cargo INT = 1
	DECLARE @Salario SMALLMONEY = 20000.00
	DECLARE @Horario INT = 8
	DECLARE @LinhasAfetadas INT

	INSERT INTO Vaga
	VALUES(@Empresa, @Cargo, @Salario, @Horario)

	SET @LinhasAfetadas = @@ROWCOUNT

	IF @LinhasAfetadas > 0
		BEGIN
			RAISERROR('Vaga inserida com sucesso!', 10, 1)
		END
	ELSE
		BEGIN
			RAISERROR('Falha ao inserir vaga!', 10, 1)
		END
END
GO

/*
Script para inser��o de uma vaga - Parte 2
- A partir da Parte 1 conclu�da
* Acrescente a estrututa de TRY..CATCH no script
* Trate o erro identificado na Parte 1. Apresentando:
	- O c�digo e mensagem do erro
	- E a mensagem: Incoscist�ncia em uma chave estrangeira! (Severidade: X)
*/

BEGIN
	DECLARE @Empresa INT = 100
	DECLARE @Cargo INT = 1
	DECLARE @Salario SMALLMONEY = 20000.00
	DECLARE @Horario INT = 8
	DECLARE @LinhasAfetadas INT,
			@Erro INT,
			@Mensagem VARCHAR(200),
			@Severidade INT

	BEGIN TRY

		INSERT INTO Vaga
		VALUES(@Empresa, @Cargo, @Salario, @Horario)

		SET @LinhasAfetadas = @@ROWCOUNT

		IF @LinhasAfetadas > 0
			BEGIN
				RAISERROR('Vaga inserida com sucesso!', 10, 1)
			END
		ELSE
			BEGIN
				RAISERROR('Falha ao inserir vaga!', 10, 1)
			END

	END TRY

	BEGIN CATCH

		SET @Erro = @@ERROR
		
		IF @Erro = 547
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Incoscist�ncia em uma chave estrangeira! (Severidade: %d)', 10, 1, @Severidade)
			END

	END CATCH

END
GO


/*
Script para inser��o de uma vaga - Parte 3
- A partir da Parte 2 conclu�da 
* Altere a declara��o da vari�vel @Horario para VARCHAR e atribua o valor 'Integral'
* Trate o erro que ser� gerado apresentando:
	- O c�digo e mensagem do erro
	- E a mensagem: Valor inv�lido para atributo INT (Severidade: X)
*/

BEGIN
	DECLARE @Empresa INT = 2
	DECLARE @Cargo INT = 1
	DECLARE @Salario SMALLMONEY = 20000.00
	DECLARE @Horario VARCHAR(15) = 'Integral'
	DECLARE @LinhasAfetadas INT,
			@Erro INT,
			@Mensagem VARCHAR(200),
			@Severidade INT

	BEGIN TRY

		INSERT INTO Vaga
		VALUES(@Empresa, @Cargo, @Salario, @Horario)

		SET @LinhasAfetadas = @@ROWCOUNT

		IF @LinhasAfetadas > 0
			BEGIN
				RAISERROR('Vaga inserida com sucesso!', 10, 1)
			END
		ELSE
			BEGIN
				RAISERROR('Falha ao inserir vaga!', 10, 1)
			END

	END TRY

	BEGIN CATCH

		SET @Erro = @@ERROR
		
		IF @Erro = 547
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Incoscist�ncia em uma chave estrangeira! (Severidade: %d)', 10, 1, @Severidade)
			END

		IF @Erro = 245
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Valor inv�lido para atributo INT. (Severidade: %d)', 10, 1, @Severidade)
			END

	END CATCH

END
GO

/*
Script para inser��o de uma vaga - Parte 4
- A partir da Parte 3 conclu�da 
* Acrescente um tratamento de erro para erros imprevistos recuperando (e apresentando)
  informa��es sobre o erro, sendo: o c�digo do erro, a mensagem, a severidade e a linha onde ocorreu o erro)
Obs.: A estrutura de IFs dever� ser modificada/adaptada para isso
*/

BEGIN
	DECLARE @Empresa INT = 2
	DECLARE @Cargo INT = 1
	DECLARE @Salario SMALLMONEY = 20000.00
	DECLARE @Horario VARCHAR(15) = 'Integral'
	DECLARE @LinhasAfetadas INT,
			@Erro INT,
			@Mensagem VARCHAR(200),
			@Severidade INT,
			@Linha INT

	BEGIN TRY

		INSERT INTO Vaga
		VALUES(@Empresa, @Cargo, @Salario, @Horario)

		SET @LinhasAfetadas = @@ROWCOUNT

		IF @LinhasAfetadas > 0
			BEGIN
				RAISERROR('Vaga inserida com sucesso!', 10, 1)
			END
		ELSE
			BEGIN
				RAISERROR('Falha ao inserir vaga!', 10, 1)
			END

	END TRY

	BEGIN CATCH

		SET @Erro = @@ERROR
		
		IF @Erro = 547
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Incoscist�ncia em uma chave estrangeira! (Severidade: %d)', 10, 1, @Severidade)
			END

		ELSE IF @Erro = 245
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Valor inv�lido para atributo INT. (Severidade: %d)', 10, 1, @Severidade)
			END

		ELSE
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				SET @Linha = ERROR_LINE()

				RAISERROR('Erro imprevisto: %d - %s. Severidade: %d. Linha: %d.', 10, 1, 
				          @Erro, @Mensagem, @Severidade, @Linha)
			END

	END CATCH

END
GO


/*
Script para inser��o de uma vaga - Parte 5
- A partir da Parte 4 conclu�da 

* Para as regras desse script n�o � permitida a inser��o de valores negativos para o atributo salario
* Verifique o valor contido na vari�vel sal�rio antes do INSERT e caso o valor seja negativo gere um erro 
  com severidade 16, estado 1 e a mensagem: Valor inv�lido para um atributo SMALLMONEY! 
* Ao testar essa possibilidade o script devem exibir a mensagem do "erro imprevisto" no CATCH

Obs.: n�o esque�a de retornar a vari�vel horario para INT
*/

BEGIN
	DECLARE @Empresa INT = 2
	DECLARE @Cargo INT = 1
	DECLARE @Salario SMALLMONEY = -16000.00
	DECLARE @Horario INT = 8
	DECLARE @LinhasAfetadas INT,
			@Erro INT,
			@Mensagem VARCHAR(200),
			@Severidade INT,
			@Linha INT

	BEGIN TRY

		IF @Salario < 0
			BEGIN
				RAISERROR('Valor inv�lido para um atributo SMALLMONEY!', 16, 1)
			END

		INSERT INTO Vaga
		VALUES(@Empresa, @Cargo, @Salario, @Horario)

		SET @LinhasAfetadas = @@ROWCOUNT

		IF @LinhasAfetadas > 0
			BEGIN
				RAISERROR('Vaga inserida com sucesso!', 10, 1)
			END
		ELSE
			BEGIN
				RAISERROR('Falha ao inserir vaga!', 10, 1)
			END

	END TRY

	BEGIN CATCH

		SET @Erro = @@ERROR
		
		IF @Erro = 547
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Incoscist�ncia em uma chave estrangeira! (Severidade: %d)', 10, 1, @Severidade)
			END

		ELSE IF @Erro = 245
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Valor inv�lido para atributo INT. (Severidade: %d)', 10, 1, @Severidade)
			END

		ELSE
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				SET @Linha = ERROR_LINE()

				RAISERROR('Erro imprevisto: %d - %s. Severidade: %d. Linha: %d.', 10, 1, 
				          @Erro, @Mensagem, @Severidade, @Linha)
			END

	END CATCH

END
GO

/*
Mais informa��es sobre a conex�o e a sess�o
*/


SELECT * FROM sys.dm_exec_connections
SELECT * FROM sys.dm_exec_sessions

SELECT DB_NAME() AS Banco,
	   Sessao.login_name AS Login,
	   Sessao.host_name AS Computador,
	   Sessao.program_name AS Aplica��o,
	   Conexao.connect_time AS [Tempo de conex�o],
	   Conexao.client_net_address AS IP
FROM sys.dm_exec_connections AS Conexao
INNER JOIN sys.dm_exec_sessions AS Sessao ON Conexao.session_id = Sessao.session_id
WHERE Conexao.session_id = @@SPID



BEGIN
	DECLARE @Empresa INT = 2
	DECLARE @Cargo INT = 1
	DECLARE @Salario SMALLMONEY = -16000.00
	DECLARE @Horario INT = 8
	DECLARE @LinhasAfetadas INT,
			@Erro INT,
			@Mensagem VARCHAR(200),
			@Severidade INT,
			@Linha INT,
			@Banco VARCHAR(25),
			@Login VARCHAR(25),
			@Computador VARCHAR(50),
			@Aplicacao VARCHAR(100),
			@Tempo VARCHAR(25),
			@Ip VARCHAR(30)

	BEGIN TRY

		IF @Salario < 0
			BEGIN
				RAISERROR('Valor inv�lido para um atributo SMALLMONEY!', 16, 1)
			END

		INSERT INTO Vaga
		VALUES(@Empresa, @Cargo, @Salario, @Horario)

		SET @LinhasAfetadas = @@ROWCOUNT

		IF @LinhasAfetadas > 0
			BEGIN
				RAISERROR('Vaga inserida com sucesso!', 10, 1)
			END
		ELSE
			BEGIN
				RAISERROR('Falha ao inserir vaga!', 10, 1)
			END

	END TRY

	BEGIN CATCH

		SET @Erro = @@ERROR
		
		IF @Erro = 547
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Incoscist�ncia em uma chave estrangeira! (Severidade: %d)', 10, 1, @Severidade)
			END

		ELSE IF @Erro = 245
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Valor inv�lido para atributo INT. (Severidade: %d)', 10, 1, @Severidade)
			END

		ELSE
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				SET @Linha = ERROR_LINE()

				SELECT @Banco = DB_NAME(),
					   @Login = Sessao.login_name,
					   @Computador = Sessao.host_name,
					   @Aplicacao = Sessao.program_name,
					   @Tempo = Conexao.connect_time,
					   @Ip = Conexao.client_net_address
				FROM sys.dm_exec_connections AS Conexao
				INNER JOIN sys.dm_exec_sessions AS Sessao ON Conexao.session_id = Sessao.session_id
				WHERE Conexao.session_id = @@SPID

				RAISERROR('Erro imprevisto: %d - %s. Severidade: %d. Linha: %d.', 10, 1, 
				          @Erro, @Mensagem, @Severidade, @Linha)

				RAISERROR('Dados da conex�o: Banco: %s. Login: %s. Computador: %s. Aplica��o: %s. Tempo: %s. IP: %s', 10, 1, 
				          @Banco, @Login, @Computador, @Aplicacao, @Tempo, @Ip)

			END

	END CATCH

END
GO

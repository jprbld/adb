USE Agencia
GO

SELECT * FROM Vaga

/*
Script para inserção de uma vaga - Parte 1
* Crie variáveis para armazenar o código da empresa, o codigo do cargo, o salario e o horário
* Crie a instrução INSERT utilizando as variáveis
* Verifique a quantidade de linhas afetadas e apresente uma das duas mensagens:
  - Vaga inserida com sucesso!
  - Falha ao inserir vaga!

Observações:

Teste com valores válidos, por exemplo:
	@Empresa = 2
	@Cargo = 1
	@Salario = 15000.00
	@Horario = 8
E com valores inválidos (para empresa e/ou cargo)

Todas as mensagem devem ser apresentadas utilizando a função RAISERROR()

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
Script para inserção de uma vaga - Parte 2
- A partir da Parte 1 concluída
* Acrescente a estrututa de TRY..CATCH no script
* Trate o erro identificado na Parte 1. Apresentando:
	- O código e mensagem do erro
	- E a mensagem: Incoscistência em uma chave estrangeira! (Severidade: X)
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
				RAISERROR('Incoscistência em uma chave estrangeira! (Severidade: %d)', 10, 1, @Severidade)
			END

	END CATCH

END
GO


/*
Script para inserção de uma vaga - Parte 3
- A partir da Parte 2 concluída 
* Altere a declaração da variável @Horario para VARCHAR e atribua o valor 'Integral'
* Trate o erro que será gerado apresentando:
	- O código e mensagem do erro
	- E a mensagem: Valor inválido para atributo INT (Severidade: X)
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
				RAISERROR('Incoscistência em uma chave estrangeira! (Severidade: %d)', 10, 1, @Severidade)
			END

		IF @Erro = 245
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Valor inválido para atributo INT. (Severidade: %d)', 10, 1, @Severidade)
			END

	END CATCH

END
GO

/*
Script para inserção de uma vaga - Parte 4
- A partir da Parte 3 concluída 
* Acrescente um tratamento de erro para erros imprevistos recuperando (e apresentando)
  informações sobre o erro, sendo: o código do erro, a mensagem, a severidade e a linha onde ocorreu o erro)
Obs.: A estrutura de IFs deverá ser modificada/adaptada para isso
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
				RAISERROR('Incoscistência em uma chave estrangeira! (Severidade: %d)', 10, 1, @Severidade)
			END

		ELSE IF @Erro = 245
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Valor inválido para atributo INT. (Severidade: %d)', 10, 1, @Severidade)
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
Script para inserção de uma vaga - Parte 5
- A partir da Parte 4 concluída 

* Para as regras desse script não é permitida a inserção de valores negativos para o atributo salario
* Verifique o valor contido na variável salário antes do INSERT e caso o valor seja negativo gere um erro 
  com severidade 16, estado 1 e a mensagem: Valor inválido para um atributo SMALLMONEY! 
* Ao testar essa possibilidade o script devem exibir a mensagem do "erro imprevisto" no CATCH

Obs.: não esqueça de retornar a variável horario para INT
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
				RAISERROR('Valor inválido para um atributo SMALLMONEY!', 16, 1)
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
				RAISERROR('Incoscistência em uma chave estrangeira! (Severidade: %d)', 10, 1, @Severidade)
			END

		ELSE IF @Erro = 245
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Valor inválido para atributo INT. (Severidade: %d)', 10, 1, @Severidade)
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
Mais informações sobre a conexão e a sessão
*/


SELECT * FROM sys.dm_exec_connections
SELECT * FROM sys.dm_exec_sessions

SELECT DB_NAME() AS Banco,
	   Sessao.login_name AS Login,
	   Sessao.host_name AS Computador,
	   Sessao.program_name AS Aplicação,
	   Conexao.connect_time AS [Tempo de conexão],
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
				RAISERROR('Valor inválido para um atributo SMALLMONEY!', 16, 1)
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
				RAISERROR('Incoscistência em uma chave estrangeira! (Severidade: %d)', 10, 1, @Severidade)
			END

		ELSE IF @Erro = 245
			BEGIN
				SET @Mensagem = ERROR_MESSAGE()
				SET @Severidade = ERROR_SEVERITY()
				RAISERROR('Erro: %d - %s', 10, 1, @Erro, @Mensagem)
				RAISERROR('Valor inválido para atributo INT. (Severidade: %d)', 10, 1, @Severidade)
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

				RAISERROR('Dados da conexão: Banco: %s. Login: %s. Computador: %s. Aplicação: %s. Tempo: %s. IP: %s', 10, 1, 
				          @Banco, @Login, @Computador, @Aplicacao, @Tempo, @Ip)

			END

	END CATCH

END
GO

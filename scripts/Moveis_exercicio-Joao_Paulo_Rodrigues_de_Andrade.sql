/* ------------------------
Banco: Moveis 
Autor: Joao Paulo Rodrigues de Andrade
Ultima alteracao: 21/09/2022
Descricao: Curso Senai ABD
-------------------------*/

--> Consultas de Produto e Tratamento

-- 01. Consulte somente os produtos que receberam tratamento
SELECT * 
FROM Produto AS P
INNER JOIN Tratamento AS T ON P.tratamentoCodigo = T.codigo 
GO

-- 02. Consulte todos os produtos independentemente se receberam tratamento ou não
SELECT * 
FROM Produto
GO

-- 03. Consulte somente os produtos que não receberam tratamento
SELECT * 
FROM Produto AS P
WHERE P.tratamentoCodigo IS NULL
GO

-- 04. Consulte todos os tratamentos independentemente de terem sido aplicados ou não
SELECT *
FROM Tratamento
GO

-- 05. Consulte somente os tratamentos que nunca foram aplicados
SELECT * 
FROM Tratamento AS T 
WHERE T.codigo NOT IN (
    SELECT P.tratamentoCodigo 
    FROM Produto AS P 
    INNER JOIN Tratamento AS T ON T.codigo = P.tratamentoCodigo 
)
GO

-- 06. Consulte todos os produtos e todos os tratamentos independentemente de terem sido tratados ou aplicados
SELECT * 
FROM Tratamento AS T
FULL JOIN Produto AS P ON T.codigo = P.tratamentoCodigo
GO

-- 07. Consulte somente os produto que não foram tratados e os tratamentos que não foram aplicados
SELECT *
FROM Produto AS P
FULL JOIN Tratamento AS T ON T.codigo = P.tratamentoCodigo
WHERE P.tratamentoCodigo IS NULL OR P.codigo IS NULL
GO
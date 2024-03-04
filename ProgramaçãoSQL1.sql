CREATE DATABASE aulaprogsql
GO
USE aulaprogsql
GO

DROP TABLE produto
CREATE TABLE produto (
Codigo		INT			NOT NULL,
Nome		VARCHAR(30)  NOT NULL,
Valor	DECIMAL(7,2)	NOT NULL,
Vencimento	Date	NOT NULL
PRIMARY KEY (Codigo)
)

-- 1) Fazer em SQL Server os seguintes algoritmos:
-- a) Dado um número inteiro. Calcule e mostre o seu fatorial. (Não usar entrada superior a 12)

DECLARE @valor INT,
		@cont INT,
		@resultado BIGINT
SET @valor = 11
SET @cont = 1
SET @resultado = 1
BEGIN
    WHILE @cont <= @valor
    BEGIN
        SET @resultado = @resultado * @cont
        SET @cont = @cont + 1
    END

    PRINT 'O fatorial de ' + CAST(@valor AS VARCHAR(10)) + ' é: ' + CAST(@resultado AS VARCHAR(MAX))
END
   
-- b) Dados A, B, e C de uma equação do 2o grau da fórmula AX2+BX+C=0. Verifique e mostre a
--existência de raízes reais e se caso exista, calcule e mostre. Caso não existam, exibir mensagem.

DECLARE @A FLOAT, @B FLOAT, @C FLOAT
DECLARE @delta FLOAT, @raizDelta FLOAT
DECLARE @x1 FLOAT 
DECLARE @x2 FLOAT
SET @A = 3
SET @B = -15
SET @C = 2
SET @delta = @B * @B - 4 * @A * @C
IF @delta > 0
BEGIN
    SET @raizDelta = SQRT(@delta)
    SET @x1 = (-@B + @raizDelta) / (2 * @A)
    SET @x2 = (-@B - @raizDelta) / (2 * @A)
    PRINT 'Existem duas raízes reais:'
    PRINT 'x1 = ' + CAST(@x1 AS VARCHAR(50))
    PRINT 'x2 = ' + CAST(@x2 AS VARCHAR(50))
END
ELSE IF @delta = 0
BEGIN
    SET @x1 = -@B / (2 * @A)
    PRINT 'Existe uma raiz real:'
    PRINT 'x = ' + CAST(@x1 AS VARCHAR(50))
END
ELSE
BEGIN
    PRINT 'Não existem raízes reais.'
END

-- c) Calcule e mostre quantos anos serão necessários para que Ana seja maior que Maria sabendo
--que Ana tem 1,10 m e cresce 3 cm ao ano e Maria tem 1,5 m e cresce 2 cm ao ano.

DECLARE @alturaAna FLOAT = 1.10
DECLARE @alturaMaria FLOAT = 1.50
DECLARE @crescimentoAna FLOAT = 0.03
DECLARE @crescimentoMaria FLOAT = 0.02
DECLARE @anos INT = 0

WHILE @alturaAna <= @alturaMaria
BEGIN
    SET @alturaAna = @alturaAna + @crescimentoAna
    SET @alturaMaria = @alturaMaria + @crescimentoMaria
    SET @anos = @anos + 1
END
PRINT CAST(@anos AS VARCHAR(MAX)) + ' anos'


--d) Seja a seguinte série: 1, 4, 4, 2, 5, 5, 3, 6, 6, 4, 7, 7, ...
--Escreva uma aplicação que a escreva N termos

DECLARE @num VARCHAR
DECLARE @num2 VARCHAR
DECLARE @cont1 INT
 
SET @num = 1
SET @num2 = 4
SET @cont1 = 1
WHILE (@cont1 < 6)
BEGIN
    PRINT @num + ','+ @num2 + ',' + @num2
    SET @num = @num + 1
	SET @num2 = @num2 + 1
	SET @cont1 = @cont1 + 1
END

/*
e) Considerando a tabela abaixo, gere uma massa de dados, com 50 registros, para fins de teste
com as regras estabelecidas (Não usar constraints na criação da tabela)
Produto
Codigo Nome Valor Vencimento
INT (PK) VARCHAR(30) DECIMAL(7,2) DATE

• Código inicia em 50001 e incrementa de 1 em 1
• Nome segue padrão simples: Produto 1, Produto 2, Produto 3, etc.
• Valor, gerar um número aleatório* entre 10.00 e 100.00
• Vencimento, gerar um número aleatório* entre 3 e 7 e usando a função específica para
soma de datas no SQL Server, somar o valor gerado à data de hoje.
*/
DROP TABLE produto

DECLARE @qtd INT = 1
DECLARE @codigo INT = 50001

WHILE (@qtd <= 50)
BEGIN
    DECLARE @nome VARCHAR(30)
    DECLARE @valor DECIMAL(7,2)
    DECLARE @vencimento DATE

    SET @nome = 'Produto ' + CAST(@qtd AS VARCHAR(5))
    SET @valor = RAND() * (100 - 10) + 10
    SET @vencimento = DATEADD(DAY, CAST(RAND() * (7 - 3) + 3 AS INT), GETDATE())
	

    INSERT INTO produto (Codigo, Nome, Valor, Vencimento) VALUES (@codigo, @nome, @valor, @vencimento)

    SET @qtd = @qtd + 1
    SET @codigo = @codigo + 1
END

SELECT Codigo, Nome, 'R$ ' + CAST(CAST(Valor AS DECIMAL(7,2)) AS VARCHAR(8)) AS Data_Vencimento, CONVERT(VARCHAR, Vencimento, 103) AS Vencimento
FROM produto

PRINT CAST(RAND() * 50 + 1 AS INT)

-- Valor, gerar um número aleatório* entre 10.00 e 100.00
DECLARE @numeroAleatorio FLOAT
DECLARE @numeroAleatorioFormatado VARCHAR(10)
SET @numeroAleatorio = RAND() * (100 - 10) + 10
SET @numeroAleatorioFormatado = 'R$ ' + CAST(CAST(@numeroAleatorio AS DECIMAL(7,2)) AS VARCHAR(8))
PRINT @numeroAleatorioFormatado




-- Vencimento, gerar um número aleatório* entre 3 e 7 e usando a função específica para
--soma de datas no SQL Server, somar o valor gerado à data de hoje.
DECLARE @numeroAleatorio INT
DECLARE @dataAtual DATE
SET @numeroAleatorio = CAST(RAND() * (7 - 3 + 1) + 3 AS INT)
SET @dataAtual = GETDATE()
DECLARE @dataVencimento DATE
SET @dataVencimento = DATEADD(DAY, @numeroAleatorio, @dataAtual)
PRINT CONVERT(CHAR(08),@dataVencimento,103)
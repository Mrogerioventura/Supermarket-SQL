SELECT * 
FROM supermarket;

--Baseado nesse banco de dados, tentaremos obter alguns insights respondendo as seguintes perguntas:


-- 1 - Qual � o n�mero da fatura e como ele � gerado?
SELECT top(10) [Invoice ID]
FROM dbo.supermarket;

-- 2 - Quantas filiais o supermercado possui e quais s�o suas localiza��es?

SELECT DISTINCT Branch, City
FROM supermarket
ORDER BY Branch

-- 3 - Quais s�o os diferentes tipos de clientes registrados no sistema?

SELECT DISTINCT [Customer type]
FROM supermarket;

-- 4 - Qual � a propor��o de clientes membros em compara��o com clientes normais?

SELECT COUNT([Customer type])  
FROM supermarket

SELECT [Customer type], COUNT(*) AS Total 
FROM supermarket
GROUP BY [Customer type];

-- 5 - Existe uma diferen�a significativa de g�nero entre os clientes?

SELECT Distinct [Gender], COUNT (*)
FROM supermarket
GROUP BY Gender

-- 6 - Quais s�o as principais categorias de produtos dispon�veis no supermercado?

SELECT distinct [Product line]
FROM supermarket

-- 7 - Quais s�o os pre�os m�dios dos produtos vendidos no supermercado?

SELECT AVG(CAST([Unit price] AS INTEGER))as AVG_Unit_Price
FROM supermarket


-- 8 - Qual � a quantidade m�dia de produtos adquiridos por cliente?

SELECT AVG (Quantity) AS AverageQuantity 
FROM supermarket;

-- 9 - Como o imposto de 5% � aplicado nas compras dos clientes?

SELECT TOP (10) [Unit price] as Pre�oUnit,
	   [Quantity] as Qtdade,
	   ROUND([Tax 5%],2) as Imposto,
	   ROUND([Total],2) as Unit_Mais_Imposto
FROM supermarket
WHERE Total = ([Unit price] * [Quantity]) * 1.05
GROUP BY [Unit price],Quantity, [Tax 5%], Total
Order BY [Unit price]



-- 10 - Qual � o pre�o m�dio total das compras, incluindo o imposto?

SELECT ROUND(AVG(Total),2) 
FROM supermarket

-- 11 - Quais s�o os produtos mais vendidos no supermercado?

SELECT DISTINCT TOP(10) [Product line] ,
       Quantity
FROM supermarket
GROUP BY [Product line], Quantity
ORDER BY Quantity DESC

-- 12 - Existe uma correla��o entre o tipo de cliente e a linha de produto adquirida?

SELECT [Customer type], 
	 [Product line], COUNT(*) AS Total 
FROM supermarket 
GROUP BY [Customer type], [Product line];


-- 13 - Quais s�o as filiais do supermercado que apresentam o maior volume de vendas?

SELECT Branch as Filial,
	   SUM(Quantity) as Qtde
FROM supermarket
GROUP BY Branch
Order BY Qtde DESC	


-- 14 - Existe uma diferen�a no comportamento de compra entre clientes membros e clientes normais?

SELECT [Customer type], 
	    ROUND(AVG(Quantity),2) AS AverageQuantity 
FROM supermarket 
GROUP BY [Customer type];

SELECT [Customer type], 
	    ROUND(AVG(Total),2) AS AverageTotal 
FROM supermarket 
GROUP BY [Customer type];

SELECT [Customer type],
		Payment as TipoPag,
	    COUNT (Payment) as Qtdade
FROM supermarket
WHERE Payment = 'Cash' OR Payment='Credit card' OR Payment='Ewallet'
GROUP BY [Customer type], Payment;

-- 15 - Quais s�o as cidades com maior n�mero de supermercados?

SELECT City as Cidade,
	  Count(Branch) as QtdeSM
FROM supermarket
GROUP BY Branch, City
ORDER BY Branch


-- 16 - Existe alguma sazonalidade nas vendas de produtos espec�ficos?

SELECT Date as Data,
	   AVG(Quantity) as Qtde
FROM supermarket
Where Quantity> 5
Group BY Quantity, Date 
ORDER BY Quantity

SELECT [Product line], 
	   MONTH(Date) AS Month, 
	  ROUND(AVG(Quantity),2) AS TotalQuantity 
FROM supermarket 
GROUP BY [Product line], MONTH(Date) 
ORDER BY [Product line], Month;



-- 17 - Quais s�o as marcas mais populares entre os clientes?

SELECT [Product line], COUNT(*) AS Total 
FROM supermarket
GROUP BY [Product line]
ORDER BY Total DESC;


-- 18 - Quais s�o as categorias de produtos com os pre�os mais altos e mais baixos?

SELECT [Product line], 
	    MAX([Unit price]) AS MaxPrice, 
		MIN([Unit price]) AS MinPrice 
FROM supermarket
GROUP BY [Product line];


-- 19 - Existe uma diferen�a de impostos entre as diferentes linhas de produto?

SELECT [Product line],
	   ROUND(AVG(Total * 0.05),2) AS TotalTax 
FROM supermarket
GROUP BY [Product line]; 



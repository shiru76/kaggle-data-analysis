-- Checking the data in all tables
SELECT *
FROM GlobalSuperstore..Orders
ORDER BY 1

SELECT *
FROM GlobalSuperstore..People

SELECT *
FROM GlobalSuperstore..Returns

-- Checking for duplicates
SELECT DISTINCT *
FROM GlobalSuperstore..Orders
ORDER BY 1

SELECT DISTINCT *
FROM GlobalSuperstore..People

SELECT DISTINCT *
FROM GlobalSuperstore..Returns

-- Checking the number of times the Order ID was used
SELECT [Order ID], COUNT(*)
FROM GlobalSuperstore..Orders
GROUP BY [Order ID]
HAVING COUNT(*) > 1

-- Ship modes available
SELECT DISTINCT [Ship Mode]
FROM GlobalSuperstore..Orders

-- Order Date should be less than Ship Date
-- Checking if there are Ship Date less than Order Date
SELECT [Order Date], [Ship Date], [Ship Mode]
FROM GlobalSuperstore..Orders
WHERE [Ship Date] >= [Order Date]

-- Get the time range per ship mode
WITH TEMP AS(
	SELECT DISTINCT [Ship Mode], DATEDIFF(DAY, [Order Date], [Ship Date]) AS Num_Days
	FROM GlobalSuperstore..Orders
)
SELECT [Ship Mode], MIN(Num_Days) AS Min_Num_Days, MAX(Num_Days) AS Max_Num_Days
FROM TEMP
WHERE [Ship Mode] = 'Same Day'
GROUP BY [Ship Mode]
UNION
SELECT [Ship Mode], MIN(Num_Days) AS Min_Num_Days, MAX(Num_Days) AS Max_Num_Days
FROM TEMP
WHERE [Ship Mode] = 'First Class'
GROUP BY [Ship Mode]
UNION
SELECT [Ship Mode], MIN(Num_Days) AS Min_Num_Days, MAX(Num_Days) AS Max_Num_Days
FROM TEMP
WHERE [Ship Mode] = 'Second Class'
GROUP BY [Ship Mode]
UNION
SELECT [Ship Mode], MIN(Num_Days) AS Min_Num_Days, MAX(Num_Days) AS Max_Num_Days
FROM TEMP
WHERE [Ship Mode] = 'Standard Class'
GROUP BY [Ship Mode]

-- Number of orders per ship mode
SELECT [Ship Mode], COUNT([Order ID]) AS Order_Count
FROM GlobalSuperstore..Orders
GROUP BY [Ship Mode]
ORDER BY Order_Count DESC

-- Number of orders per segment
SELECT [Segment], COUNT([Order ID]) AS Order_Count
FROM GlobalSuperstore..Orders
GROUP BY [Segment]
ORDER BY Order_Count DESC

-- Number of orders per city
SELECT [City], COUNT([Order ID]) AS Order_Count
FROM GlobalSuperstore..Orders
GROUP BY [City]
ORDER BY Order_Count DESC

-- Number of orders per state
SELECT [State], COUNT([Order ID]) AS Order_Count
FROM GlobalSuperstore..Orders
GROUP BY [State]
ORDER BY Order_Count DESC

-- Number of orders per country
SELECT [Country], COUNT([Order ID]) AS Order_Count
FROM GlobalSuperstore..Orders
GROUP BY [Country]
ORDER BY Order_Count DESC

-- Number of orders per region
SELECT [Region], COUNT([Order ID]) AS Order_Count
FROM GlobalSuperstore..Orders
GROUP BY [Region]
ORDER BY Order_Count DESC

-- Number of orders per market
SELECT [Market], COUNT([Order ID]) AS Order_Count
FROM GlobalSuperstore..Orders
GROUP BY [Market]
ORDER BY Order_Count DESC

-- Most ordered product
SELECT [Product ID], SUM(Quantity) AS Order_Count
FROM GlobalSuperstore..Orders
GROUP BY [Product ID]
ORDER BY Order_Count DESC

-- Most ordered items based on sub category
SELECT [Sub-Category], COUNT([Order ID]) AS Order_Count
FROM GlobalSuperstore..Orders
GROUP BY [Sub-Category]
--HAVING [Sub-Category] = 'Chairs'
ORDER BY Order_Count DESC

-- Sales vs Profit of Sub-Category
SELECT [Sub-Category], SUM([Sales]) AS Total_Sales, SUM([Profit]) AS Total_Profit
FROM GlobalSuperstore..Orders
GROUP BY [Sub-Category]
--HAVING [Sub-Category] = 'Chairs'
ORDER BY [Sub-Category]

-- Most returned items
SELECT Orders.[Product Name], COUNT(Orders.[Product Name]) AS Count_Returned_Items
FROM Orders
INNER JOIN Returns ON Orders.[Order ID] = Returns.[Order ID]
WHERE Returns.[Returned] = 'Yes'
GROUP BY Orders.[Product Name]
ORDER BY Count_Returned_Items DESC


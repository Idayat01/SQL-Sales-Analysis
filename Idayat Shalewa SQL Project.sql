--SALAKO IDAYAT SHALEWA SQL PROJECT

--CREATING DATABASE
CREATE DATABASE Retail_Sales;

--USE RETAIL SALES DATABASE
USE Retail_Sales;

--CHECKING FOR TOP 10 VALUES IN THE DATASET
SELECT TOP  10 *
FROM [dbo].[Retail_Sales Data];

--CHECKING FOR NULLS
SELECT *
FROM [dbo].[Retail_Sales Data]
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

--DELETING THE NULL VALUES
DELETE FROM [dbo].[Retail_Sales Data]
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

--RETRIEVE ALL COLUMN FOR SALES MADE ON 2022-11-05
SELECT *
FROM [dbo].[Retail_Sales Data]
WHERE sale_date = '2022-11-05';

--TRANSACTIOS WHERE CATEGORY IS 'CLOTHING' QUANTITY SOLD IS >4 IN NOVEMBER 2022
SELECT *
FROM [dbo].[Retail_Sales Data]
WHERE category = 'Clothing'
  AND quantiy > 4
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

--CHECKING FOR CLOTHING SALES IN NOV 2022
  SELECT *
FROM [dbo].[Retail_Sales Data]
WHERE category = 'Clothing'
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

--LIST OF CATEGORY
SELECT DISTINCT category
FROM [dbo].[Retail_Sales Data];

--TOTAL SALES OF EACH CATEGORY
SELECT category, 
       SUM(total_sale) AS total_sales
FROM [dbo].[Retail_Sales Data]
GROUP BY category
ORDER BY total_sales DESC;

--AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEM FROM THE BEAUTY CATEGORY
SELECT AVG(age) AS Avg_Age_Beauty_Customers
FROM [dbo].[Retail_Sales Data]
WHERE category = 'Beauty';

 --TRANSACTIONS WHERE TOTAL SALE IS >1000
 SELECT *
FROM [dbo].[Retail_Sales Data]
WHERE total_sale > 1000;

--TOTAL NUMBER OF TRANSACTIONS MADE BY EACH GENDER IN EACH CATEGORY
SELECT 
    category,
    gender,
    COUNT(transactions_id)AS total_numberof_transactions
FROM [dbo].[Retail_Sales Data]
GROUP BY category, gender
ORDER BY category, gender;

--AVERAGE SALE OF EACH MONTH IN YEAR DATA
SELECT 
    YEAR(sale_date) AS sale_year,
    MONTH(sale_date) AS sale_month,
    AVG(total_sale) AS avg_monthly_sale
FROM [dbo].[Retail_Sales Data]
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY sale_year, sale_month;

--BEST SELLING MONTH IN EACH YEAR
WITH MonthlySales AS (
    SELECT 
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        AVG(total_sale) AS avg_monthly_sale
    FROM [dbo].[Retail_Sales Data]
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT sale_year, sale_month, avg_monthly_sale
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY sale_year 
                              ORDER BY avg_monthly_sale DESC) AS rn
    FROM MonthlySales
) AS ranked
WHERE rn = 1
ORDER BY sale_year;


--TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALE
SELECT TOP 5
    customer_id,
    SUM(total_sale) AS total_sales
FROM [dbo].[Retail_Sales Data]
GROUP BY customer_id
ORDER BY total_sales DESC;


--CREATE EACH SHIFT(MORNING, AFTERNOON, EVENING) AND NUMBER OF ORDERS
SELECT  
    CASE  
        WHEN CAST(sale_time AS TIME) < '12:00:00' THEN 'Morning'  
        WHEN CAST(sale_time AS TIME) BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'  
        ELSE 'Evening'  
    END AS Shift,  
    COUNT(*) AS Number_of_Orders  
FROM [dbo].[Retail_Sales Data]  
GROUP BY  
    CASE  
        WHEN CAST(sale_time AS TIME) < '12:00:00' THEN 'Morning'  
        WHEN CAST(sale_time AS TIME) BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'  
        ELSE 'Evening'  
    END  
ORDER BY Number_of_Orders DESC;












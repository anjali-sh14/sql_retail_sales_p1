--SQL Retail Sales Analysis-P1
CREATE DATABASE sql_project_p2;

DROP TABLE IF EXISTS retails_sales;
CREATE TABLE retails_sales(
			transactions_id	INT PRIMARY KEY,
			sale_date DATE,	
			sale_time TIME,
			customer_id	INT,
			gender VARCHAR(14),	
			age	INT,
			category VARCHAR(15),
			quantity	INT,
			price_per_unit FLOAT,	
			cogs FLOAT,
			total_sale FLOAT
          );
		  
SELECT * from retails_sales;

SELECT * from retails_sales
LIMIT 10

SELECT * from retails_sales
WHERE transactions_id IS NULL

SELECT * from retails_sales
WHERE sale_date IS NULL

SELECT * from retails_sales
WHERE sale_time IS NULL


---DATA CLEANING
SELECT * from retails_sales
WHERE
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantity IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;


DELETE FROM retails_sales
WHERE
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantity IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;


--DATA EXPLORATION
--HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS total_sale FROM retails_sales

--HOW MANY COSTUMERS WE HAVE?
SELECT COUNT(DISTINCT customer_id) AS total_sales FROM retails_sales

SELECT DISTINCT category AS total_sales FROM retails_sales


--DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS

--Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT *
FROM retails_sales
WHERE sale_date='2022-11-05';

-- write a sql query to retrieve all transaction where category is "clothing" and the quantity sold is more tah 4 in the month of Nov-2022
SELECT * 
	 FROM retails_sales
	 WHERE 
	 category='Clothing'
	 AND 
	 TO_CHAR(sale_date,'YYYY-MM')='2022-11'
	 AND 
	 quantity >= 4

--Write a SQL query to calculate the total sales (total_sale) for each category
SELECT
     category,
	 SUM(total_sale)
     FROM retails_sales	
	 GROUP BY 1

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT
     category,
	 AVG(age)
	 FROM retails_sales
	 WHERE category = 'Beauty'
	 GROUP BY 1

---Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT * FROM retails_sales
WHERE total_sale>1000

--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT
gender, 
category,
COUNT(*) as sale_no FROM retails_sales
GROUP BY
gender, 
category


---Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
EXTRACT (YEAR FROM sale_date) AS year,
EXTRACT (MONTH FROM sale_date) AS month,
SUM(total_sale)
FROM retails_sales
GROUP BY 1,2

---Write a SQL query to find the top 5 customers based on the highest total sales
SELECT
customer_id,
SUM (total_sale)
FROM retails_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

---Write a SQL query to find the number of unique customers who purchased items from each category
SELECT category,
COUNT (DISTINCT customer_id)
FROM retails_sales
GROUP BY 1

---Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hours_shift
AS
(SELECT *,
       CASE
	   WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'morning'
	   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	   ELSE 'evening'
	   END as shift
	   FROM retails_sales)
	   SELECT 
	   shift,
	   COUNT(*) FROM hours_shift
	   GROUP BY shift

---END OF PROJECT---
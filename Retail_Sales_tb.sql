--- crete table 
CREATE TABLE Retail_Sales_tb (
    transactions_id INT PRIMARY KEY,       
    sale_date DATE,                        
    sale_time TIME,                       
    customer_id INT,                       
    gender VARCHAR(15),                    
    age INT,                              
    category VARCHAR(50),                  
    quantity INT,                         
    price_per_unit FLOAT,         
    cogs FLOAT,                  
    total_sale FLOAT              
);

select * from retail_sales_tb
limit 10;

--- Cleaning Data---

SELECT * FROM retail_sales_tb
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales_tb
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

---Data Analysis & Findings---
1--Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select * from retail_sales_tb
          where sale_date = '2022-11-05';
		  
2--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:		  

SELECT 
  *
FROM retail_sales_tb
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4

3---Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT
    Category,
	sum(total_sale) as net_sale,
	count (*) as total_orders
FROM retail_sales_tb
GROUP BY 1;

	
4---Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT 
    Round(avg(age), 2) as avg_age
FROM retail_sales_tb
WHERE category = 'Beauty';

5---Write a SQL query to find all transactions where the total_sale is greater than 1000.:

Select 
    *
	From Retail_sales_tb
Where total_sale > 1000;

6---Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

Select 
     category,
	 gender,
	 COUNT(*) as total_trans
from retail_sales_tb
     group by 
	 category,
	 gender
Order by 1
7---Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
Select 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
From retail_sales_tb
Group by 1, 2
) as t1
Where rank = 1;
8--Write a SQL query to find the top 5 customers based on the highest total sales:

Select 
    customer_id,
    SUM(total_sale) as total_sales
From retail_sales_tb
Group By 1
Order By 2 DESC
Limit 5;

9--Write a SQL query to find the number of unique customers who purchased items from each category:
Select 
    category,    
    Count(Distinct customer_id) as cnt_unique_cs
From retail_sales_tb
Group By category;

10---Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
With hourly_sale
As
(
Select *,
    Case
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
From retail_sales_tb
)
Select
    shift,
    COUNT(*) as total_orders    
From hourly_sale
Group By shift;

---END---
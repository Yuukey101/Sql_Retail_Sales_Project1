# Retail Sales SQL Project

## Project Overview

**Project Title**: Retail Sales 
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

CREDIT TO:

## Author - Zero Analyst

make sure to follow HIM on social media Links Below

- **YouTube**: [Subscribe to my channel for tutorials and insights](https://www.youtube.com/@zero_analyst)
- **Instagram**: [Follow me for daily tips and updates](https://www.instagram.com/zero_analyst/)
- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/najirr)
- **Discord**: [Join our community to learn and grow together](https://discord.gg/36h5f2Z5PK)

Thank you.

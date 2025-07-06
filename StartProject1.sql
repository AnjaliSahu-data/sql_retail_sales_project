Create table retail_sales(
			transactions_id	INT PRIMARY KEY,
			sale_date DATE,
			sale_time TIME,
			customer_id	INT,
			gender VARCHAR(15),			
			age	INT,
			category VARCHAR(15),
			quantity	INT,
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale FLOAT		
		);

Select * from retail_sales;


select count(*) from retail_sales

--Data Cleaning--
Select * from retail_sales
where transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	gender IS NULL
	OR
	sale_time IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

--Remove the NULL values.--
Delete from retail_sales
	where transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	gender IS NULL
	OR
	sale_time IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

--Data Exploration--

--Howmany sales we have?
Select count(*) As total_sales from retail_sales;

--Howmany unique customers we have?
Select count(Distinct customer_id) As total_customer from retail_sales;

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
Select * from retail_sales
Where sale_date = '2022-11-05';

--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022.
Select * from retail_sales
Where category = 'Clothing'
AND quantity >=4
AND sale_date Between '2022-11-01' AND '2022-11-30';

--Another method
Select * from retail_sales
Where category = 'Clothing'
AND To_char(sale_date, 'YYYY-MM') = '2022-11'
AND quantity>=4;

--Q.3 Write a SQL query to calculate the total sales(total_sale)for each category.
Select category, sum(total_sale) As net_sale,
count(*) As total_orders
from retail_sales
Group By category;

--Q.4 Write a SQL query to find the average age of customers who purchased item from the 'Beaty' category.
Select AVG(age) As average_age
From retail_sales
Where category = 'Beauty';

--Another method:-
Select Round(AVG(age),2) As avg_age
From retail_sales
Where category = 'Beauty';

--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
Select * from retail_sales
Where total_sale>1000;

--Q.6 Write a SQL query to find the total number of transactions (transaction_id)made by each gender in each category.
Select category, gender,
Count(transactions_id) As total_transaction
From retail_sales
Group by category,gender
Order by 1;

--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
Select year, month, avg_sale
From(
Select 
		Extract(Year from sale_date)As year,
		Extract(Month from sale_date)As month,
		AVG(total_sale)As avg_sale,
		RANK()OVER(PARTITION BY EXTRACT(Year from sale_date)ORDER BY AVG(total_sale)DESC)As rank
		From retail_sales
		Group By 1,2)As t1
		Where rank = 1;

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
Select customer_id, Sum(total_sale) As total_sales
from retail_sales
Group by customer_id
Order by Sum(total_sale) DESC
Limit 5;

--Q.9 Write a SQL query to find the number of unique customers who purchased item from each category.
Select category, COUNT(DISTINCT customer_id) As count_unique_customer
from retail_sales
Group by category;

--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 1, Evening>17)
With hourly_sale
As (
Select *,
CASE
WHEN EXTRACT(HOUR from sale_time)<12 THEN 'Morning'
WHEN EXTRACT(HOUR from sale_time)Between 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END As shift
From retail_sales
)
Select shift, Count(*) As total_orders
From hourly_sale
Group By shift;		
--End of Project1--

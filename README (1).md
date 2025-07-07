# 🛒 Retail Sales Analysis Using SQL

This project involves analyzing a retail sales dataset using SQL to extract meaningful business insights. It covers data cleaning, exploratory queries, and performance-based analysis using PostgreSQL or any relational database.

---

## 📌 Disclaimer

> 📝 *This project is based on a YouTube SQL tutorial. I followed it to practice SQL skills, understand real-world data analysis scenarios, and learn how to structure queries for business insights. I modified and added queries to deepen my learning.*

---

## 📁 Dataset & Table

The project uses a single table: `retail_sales`  
### Columns:
- `transactions_id` (INT)
- `sale_date` (DATE)
- `sale_time` (TIME)
- `customer_id` (INT)
- `gender` (VARCHAR)
- `age` (INT)
- `category` (VARCHAR)
- `quantity` (INT)
- `price_per_unit` (FLOAT)
- `cogs` (FLOAT)
- `total_sale` (FLOAT)

---

## 🧼 Data Cleaning Performed
- Checked for `NULL` values in key columns
- Removed rows with missing critical information
```sql
DELETE FROM retail_sales
WHERE transactions_id IS NULL OR sale_date IS NULL ...
```

---

## 🔍 Data Exploration & Analysis

### ✅ General Insights:
- Total number of sales
- Total unique customers
- Top 5 customers by total sales

### 📊 Category & Sales-based Analysis:
- Total sales per category
- Unique customers per category
- Average age of customers in Beauty category

### 📅 Time-based Analysis:
- Sales on a specific day (`'2022-11-05'`)
- Best-selling month of each year
- Number of orders by time shifts: Morning, Afternoon, Evening

```sql
-- Find best selling month
SELECT year, month, avg_sale
FROM (
  SELECT EXTRACT(YEAR FROM sale_date) AS year,
         EXTRACT(MONTH FROM sale_date) AS month,
         AVG(total_sale) AS avg_sale,
         RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
  FROM retail_sales
  GROUP BY 1, 2
) t
WHERE rank = 1;
```

---

## 🛠️ Tools & Skills Used
- **SQL** (PostgreSQL)
- **Data Cleaning**
- **Data Aggregation**
- **Window Functions**
- **Time-based Filtering**

---

## 📎 How to Use This Project
1. Create a `retail_sales` table using the `Create Table` script.
2. Load your data (CSV or any data source).
3. Run the SQL queries from `StartProject1.sql` in your SQL environment.
4. Modify queries as needed to answer your business questions.

---

## 🙋‍♀️ Author
**Anjali Sahu**  
Feel free to connect with me on [LinkedIn- https://www.linkedin.com/in/anjali-sahu-analyst/](#) or view more projects on [GitHub- https://github.com/AnjaliSahu-data/sql_retail_sales_project](#).

---

## 🏁 Status
✅ Project Completed – Practiced via Tutorial  
📌 Ideal for: Data Analyst portfolio, SQL learning, interview preparation

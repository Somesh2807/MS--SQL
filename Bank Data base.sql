-- Create a table to store sales data
CREATE TABLE sales_data_final (
    order_id VARCHAR(15), 
    order_date DATE, 
    ship_date DATE, 
    ship_mode VARCHAR(14), 
    customer_name VARCHAR(22), 
    segment VARCHAR(11), 
    "state" VARCHAR(36), 
    country VARCHAR(32), 
    market VARCHAR(6), 
    region VARCHAR(14), 
    product_id VARCHAR(16), 
    category VARCHAR(15), 
    sub_category VARCHAR(11), 
    product_name VARCHAR(127), 
    sales DECIMAL(38, 0), 
    quantity DECIMAL(38, 0), 
    discount DECIMAL(38, 3), 
    profit DECIMAL(38, 5), 
    shipping_cost DECIMAL(38, 2), 
    order_priority VARCHAR(8), 
    "year" DECIMAL(38, 0)
);

-- Modify the name of the database to 'sales'
ALTER DATABASE bank MODIFY NAME = sales;

-- Select the name from databases where the database_id is greater than 4
SELECT name
FROM sys.databases
WHERE database_id > 4;

-- Switch to the 'sales' database
USE sales;

-- Bulk insert data from CSV file into the 'sales_data_final' table
BULK INSERT sales_data_final FROM 'D:\sales_data_final.csv' WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n');

-- Alter table (Note: the statement is incomplete)
ALTER TABLE ALTER;

-- Select data from 'sales_data_final' table based on certain conditions
SELECT * FROM sales_data_final WHERE order_date > '2011-01-01' AND ship_mode = 'second Class' AND segment = 'Corporate';

-- Switch to the 'sales' database
USE sales;

-- Select data from 'sales_data_final' where 'shipped_date' is greater than 4 (Note: the column name is misspelled, should be 'ship_date')
SELECT * FROM sales_data_final WHERE ship_date > 4;

-- Add a default constraint for the 'sales' column in 'sales_data_final' table
ALTER TABLE sales_data_final ADD CONSTRAINT DF_sales DEFAULT 0 FOR sales;

-- Add a unique constraint for the 'order_id' column in 'sales_data_final' table
ALTER TABLE sales_data_final ADD CONSTRAINT UK_order UNIQUE(order_id);

-- Select data from 'sales_data_final' where 'order_id' is equal to a specific value
SELECT * FROM sales_data_final WHERE order_id = 'AE-2011-9160';

-- Delete data from 'sales_data_final' where 'order_id' is equal to a specific value
DELETE FROM sales_data_final WHERE order_id = 'AE-2011-9160';

-- Add a new column 'Busineess_day' and calculate the difference in days between 'order_date' and 'ship_date'
ALTER TABLE sales_data_final ADD Busineess_day AS DATEDIFF(day, order_date, ship_date) - 2 * DATEDIFF(week, order_date, ship_date);

-- Rename the column 'shipped_Date' to 'shipped_days' in 'sales_data_final' table
SP_RENAME 'sales_data_final.shipped_Date', 'shipped_days';

-- Select the date after adding 10 months to '2023-06-20'
SELECT DATEADD(month, 10, '2023-06-20');

-- Select table names from 'sys.tables' where 'database_id' is greater than 4
SELECT name
FROM sys.tables
WHERE database_id > 4;

-- Modify the name of the 'rise' database to 'Rise_1'
ALTER DATABASE rise MODIFY NAME = 'Rise_1';

-- Rename the 'rise' database to 'rise1'
SP_RENAMEDB 'rise', 'rise1';

-- Switch to the 'sales' database
USE sales;

-- Select all data from 'sales_data_final'
SELECT * FROM sales_data_final;

-- Pivot operation: Calculate the sum of profit for each customer and country combination
SELECT DISTINCT customer_name, country, SUM(profit) AS profit
FROM sales_data_final
GROUP BY customer_name, country
ORDER BY customer_name, country;

-- Add a new column 'city' to 'sales_data_final' table
ALTER TABLE sales_data_final ADD city NVARCHAR(30);

-- Drop the 'city' column from 'sales_data_final' table
ALTER TABLE sales_data_final DROP COLUMN city;

-- Switch to the 'sales' database
USE sales;

-- Calculate the age by finding the difference in days and weeks between '1989-11-25' and the current date
SELECT DATEDIFF(day, '1989-11-25', GETDATE()) - 2 * DATEDIFF(week, '1989-11-25', GETDATE()) AS age;

-- Add a new column 'temp' and calculate the difference in days between 'Order_date' and the current date
ALTER TABLE sales_data_final ADD temp AS DATEDIFF(day, Order_date, GETDATE());

-- Select all data from 'sales_data_final' and order by profit in descending order
SELECT * FROM sales_data_final ORDER BY profit DESC;

-- Select the maximum profit from 'sales_data_final' where profit is less than the maximum profit
SELECT MAX(profit) FROM sales_data_final WHERE profit < (SELECT MAX(profit) FROM sales_data_final);

-- Need to check (Note: the statement is incomplete)
SELECT TOP 1 profit FROM sales_data_final WHERE profit < (SELECT MAX(profit) FROM sales_data_final) ORDER BY profit DESC;

-- Switch to the 'sales' database
USE sales;

-- Select table names from 'sys.tables'
SELECT name
FROM sys.tables;

-- Select all data from 'sales_data_final' and 'sales_Dummy' tables using an inner join
SELECT DISTINCT a.customer_name, b.order_id, a.discount, b.market
FROM sales_data_final a
JOIN sales_Dummy b ON a.order_id = b.order_id
WHERE b.country = 'cuba'
GROUP BY country;

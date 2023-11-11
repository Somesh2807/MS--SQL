-- Create the 'Amazon' database
CREATE DATABASE Amazon
USE Amazon

-- Create the 'Inventaroy' table
CREATE TABLE Inventaroy (
    Product_ID         INT PRIMARY KEY,
    product_name       NVARCHAR(50),
    price              MONEY,
    Stock_Quantity     INT,
    Remaining_stock    INT,
    Sold_Quantity      INT
);

-- Create the 'Sales' table
CREATE TABLE Sales (
    Order_ID           INT IDENTITY(1, 3),
    Order_date         NVARCHAR(50) DEFAULT SYSDATETIME(),
    Product_ID         INT,
    Quantity_Ordered   INT,
    Sales_price        MONEY,
    Total_Cost         MONEY,
    GST_Percentage     INT
);

-- Insert data into the 'Inventaroy' table
INSERT INTO Inventaroy VALUES (1, 'I Phone 15 Pro Max Ultra 256 GB', 250000, 100, NULL, NULL)
INSERT INTO Inventaroy VALUES (2, 'Grocery', 5000, 100, NULL, NULL)
INSERT INTO Inventaroy VALUES (3, 'AC Samsung', 65000, 100, NULL, NULL)
INSERT INTO Inventaroy VALUES (4, 'Xiomi TV 55 Inch LED', 45000, 100, NULL, NULL)

-- Add primary key constraint to the 'Inventaroy' table
ALTER TABLE Inventaroy ADD CONSTRAINT PK_Product_ID PRIMARY KEY (Product_ID)

-- Add foreign key constraint to the 'Sales' table
ALTER TABLE Sales ADD CONSTRAINT FK_PRODUCT_ID FOREIGN KEY (Product_ID)
REFERENCES Inventaroy (Product_ID) ON UPDATE CASCADE ON DELETE CASCADE

-- Create a stored procedure 'sales_proc'
ALTER PROCEDURE sales_proc
(
    @Product_ID        INT,
    @Quantity_Ordered  INT
)
AS
BEGIN
    DECLARE @Sales_Price MONEY
    DECLARE @Total_Cost MONEY
    DECLARE @GST INT
    DECLARE @Stock_Quantity INT

    -- Get product information
    SELECT @Stock_Quantity = Stock_Quantity, @GST = CASE
        WHEN @Product_ID = 1 THEN 28
        WHEN @Product_ID = 2 THEN 18
        WHEN @Product_ID = 3 THEN 5
        WHEN @Product_ID = 4 THEN 18
        ELSE NULL -- Handle the case for an invalid Product_ID
    END,
    @Sales_Price = Price * @Quantity_Ordered
    FROM Inventaroy
    WHERE Product_ID = @Product_ID

    -- Check for invalid Product_ID
    IF @GST IS NULL
    BEGIN
        PRINT 'ERROR! INVALID PID'
    END
    ELSE
    BEGIN
        -- Check if there's enough stock
        IF @Quantity_Ordered <= @Stock_Quantity
        BEGIN
            -- Calculate Total_Cost
            SET @Total_Cost = @Sales_Price + ((@GST / 100.0) * @Sales_Price)

            -- Insert into the sales table
            INSERT INTO Sales (Product_ID, Quantity_Ordered, Sales_Price, Total_Cost, GST_Percentage)
            VALUES (@Product_ID, @Quantity_Ordered, @Sales_Price, @Total_Cost, @GST)

            -- Update Inventaroy
            UPDATE Inventaroy
            SET Stock_Quantity = Stock_Quantity - @Quantity_Ordered, Sold_Quantity = Sold_Quantity + @Quantity_Ordered
            WHERE Product_ID = @Product_ID
        END
        ELSE
        BEGIN
            PRINT 'Insufficient Quantity'
        END
    END
END

-- Select records from 'Sales' and 'Inventaroy' tables
SELECT * FROM Sales ORDER BY Order_ID DESC
SELECT * FROM Inventaroy

-- Update 'Inventaroy' table
UPDATE Inventaroy SET Stock_Quantity = 1000 + Stock_Quantity WHERE Product_ID = 1

-- Execute the 'sales_proc' stored procedure
EXEC sales_proc @Product_ID = 1, @Quantity_Ordered = 1500

-- Get the text of the 'sales_proc' stored procedure
sp_helptext sales_proc

-- Get dependencies of the 'sales_proc' stored procedure with tables
sp_depends sales_proc

-- Add the 'GST_Percentage' column in 'Inventaroy' table and update GST price using case
UPDATE Sales SET GST_Percentage = CASE
    WHEN Product_ID = 1 THEN 28
    WHEN Product_ID = 2 THEN 18
    WHEN Product_ID = 3 THEN 5
    WHEN Product_ID = 4 THEN 18
    ELSE NULL
END

-- Create a function 'GetSalesWithDiscount'
ALTER FUNCTION dbo.GetSalesWithDiscount()
RETURNS TABLE
AS
RETURN
(
    SELECT Order_ID, Order_date, Product_ID, Quantity_Ordered,
           GST_Percentage, Sales_price - (Sales_price * 0.1) AS Discounted_Price,
           Total_Cost = Sales_price + (Sales_price * GST_Percentage)
    FROM Sales
)

-- Example of using the 'dbo.GetSalesWithDiscount' function
SELECT Order_ID, GST_Percentage, Order_date
FROM dbo.GetSalesWithDiscount()
WHERE Order_date > '2023-09-14'

-- Select records from 'dbo.GetSalesWithDiscount' function
SELECT * FROM dbo.GetSalesWithDiscount()

-- Drop the 'getSalesDiscount' function
DROP FUNCTION dbo.getsalesdiscount

-- Create a new 'getSalesDiscount' function
ALTER FUNCTION dbo.getsalesdiscount
(
    @Order_ID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT Order_ID, Product_ID, GST_Percentage,
           Sales_price - (Sales_price * 0.1) AS Discounted_Price,
           Sales_price + (Sales_price * GST_Percentage / 100) AS Total_Cost
    FROM Sales
    WHERE Order_ID = @Order_ID
)

-- Example of using the 'dbo.getsalesdiscount' function
SELECT * FROM Sales WHERE Total_Cost <= (SELECT Total_Cost FROM dbo.getsalesdiscount(1))

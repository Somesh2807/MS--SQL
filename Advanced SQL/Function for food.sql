-- Database for pantry
CREATE DATABASE PANTRY

-- Enter the database
USE PANTRY

-- Create table
CREATE TABLE FOOD (
    ID INT,
    Name NVARCHAR(30),
    START_DATE DATE,
    END_DATE DATE
);

-- Select all records from FOOD
SELECT * FROM FOOD

-- Create a function to display change in price and necessary details
ALTER FUNCTION PriceChange1 (
    @priceChangeDate DATE,
    @old_price MONEY,
    @newPrice MONEY
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        ID,
        Name,
        START_DATE,
        END_DATE,
        @PriceChangeDate AS Price_Change_Date,
        ((DATEDIFF(DAY, START_DATE, END_DATE) + 1) - (DATEDIFF(WEEK, START_DATE, END_DATE) * 2)) * @old_price AS Old_Price,
        (DATEDIFF(DAY, @PriceChangeDate, END_DATE) + 1) - (DATEDIFF(WEEK, @PriceChangeDate, END_DATE) * 2) AS Days_Since_Change,
        @newPrice * ((DATEDIFF(DAY, @PriceChangeDate, END_DATE) + 1) - (DATEDIFF(WEEK, @PriceChangeDate, END_DATE) * 2)) AS New_price_From_Change_Date,
        (@newPrice - @old_price) / @newPrice * 100 AS Change_percentage,
        ((@newPrice * ((DATEDIFF(DAY, @PriceChangeDate, END_DATE) + 1) - (DATEDIFF(WEEK, @PriceChangeDate, END_DATE) * 2))) - (((DATEDIFF(DAY, @priceChangeDate, END_DATE) + 1) - (DATEDIFF(WEEK, @PriceChangeDate, END_DATE) * 2))) * @old_price) AS Diffrence_Amount
    FROM FOOD
    WHERE @priceChangeDate BETWEEN START_DATE AND END_DATE
);

-- To run the function, provide parameters [@priceChangeDate], [@old_price], [@newPrice per day]
SELECT * FROM PriceChange1('2023-10-11', 92, 200)

-- Select all records from FOOD
SELECT * FROM FOOD


create database PANTRY

USE PANTRY


create table FOOD(
ID int,
Name nvarchar(30),
START_DATE date,
Price_Change_Date date,
END_DATE date,
PRICE MONEY
);
-- Create a function to calculate price change percentage
CREATE FUNCTION fn_pricechange(@newPrice MONEY,@Price_Change_Date Date)
RETURNS TABLE
AS
RETURN
    DECLARE @ID int
    DECLARE @NAME NVARCHAR(30)
    DECLARE @NEW_PRICE MONEY
    DECLARE @oldPrice MONEY
    DECLARE @startDate DATE
    DECLARE @endDate DATE
    DECLARE @changePercentage DECIMAL(10, 2)
    Declare @days_change int
    -- Get the old price, start date, and end date for the given food ID
    SELECT @ID=ID, @NAME = Name, @oldPrice = Price,
           @startDate = START_DATE,
           @endDate = END_DATE
           
    FROM FOOD
    select  @days_change = datediff(day,@Price_Change_Date)
    



-- Create a function to calculate price change details
ALTER FUNCTION CalculatePriceChangeDetails(
    @priceChangeDate DATE,
    @newPrice MONEY
)
RETURNS TABLE
AS
RETURN (
    SELECT
        ID,
        Name,
        START_DATE,
        @PriceChangeDate as Price_Change_Date,
        END_DATE,
        PRICE AS OldPrice,
        @newPrice AS NewPrice,
        DATEDIFF(DAY, '2023-09-01', GETDATE()+1)-datediff(ww,'2023-09-01', GETDATE())*2 AS DaysSinceChange,
        ((@newPrice - PRICE) / PRICE) * 100 AS ChangePercentage,
        @newPrice - PRICE AS DifferenceAmount
    FROM
        FOOD
    WHERE
        @priceChangeDate BETWEEN START_DATE AND END_DATE
);

select * from CalculatePriceChangeDetails('2023-09-15',1800)

select DATEDIFF(DAY, '2023-09-01', GETDATE()+1)-datediff(ww,'2023-09-01', GETDATE())*2 AS Date
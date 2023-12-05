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


-- Create a function to calculate price change details

CREATE or alter function PriceChange1(
    @priceChangeDate DATE,
	@old_price money,
    @newPrice MONEY
)
RETURNS TABLE
AS
RETURN 
( SELECT ID, Name, START_DATE,  END_DATE, @PriceChangeDate as Price_Change_Date,--Price change date
((DATEDIFF(day, START_DATE, END_DATE)+1) - (DATEDIFF(week, START_DATE, END_DATE) * 2))*@old_price AS Old_Price,---previsous price
(DATEDIFF(day, @PriceChangeDate, END_DATE)+1) - (DATEDIFF(week, @PriceChangeDate, END_DATE) * 2) AS Days_Since_Change,--No of deficit days
@newPrice * ((DATEDIFF(day, @PriceChangeDate, END_DATE)+1) -
(DATEDIFF(week, @PriceChangeDate, END_DATE) * 2))  AS New_price_From_Change_Date,--New price chaneg date 
(@newPrice-@old_price)/ @newPrice * 100 AS Change_percentage,---Price Chaneg Percentage
((@newPrice * ((DATEDIFF(day, @PriceChangeDate, END_DATE)+1) - (DATEDIFF(week, @PriceChangeDate, END_DATE) * 2))) -
(((DATEDIFF(day, @priceChangeDate, END_DATE)+1) -
(DATEDIFF(week, @priceChangeDate, END_DATE) * 2)))*@old_price) as Diffrence_Amount---Differnce Amount
FROM FOOD
WHERE  @priceChangeDate BETWEEN START_DATE AND END_DATE
);

select cast(datediff(day,'2023-09-01',getdate())-datediff(WEEK,'2023-09-01',getdate()*2) as date) 

SELECT CAST(DATEDIFF(DAY, '2023-09-01', GETDATE()) - DATEDIFF(WEEK, '2023-09-01', GETDATE()) AS DATE)

select datediff(day,'2023-09-01', GETDATE())-datediff(week, '2023-09-01', GETDATE())

select DATEDIFF(DAY, '2023-09-01', GETDATE()+1)-datediff(ww,'2023-09-01', GETDATE())*2 AS Date



select * from PriceChange1('2023-09-01',75,80)

select name
from sys.tables

select * from food

select * from PriceChange1('2023-09-15',1800)

select DATEDIFF(DAY, '2023-09-01', GETDATE()+1)-datediff(ww,'2023-09-01', GETDATE())*2 AS Date

select datediff(day,'2023-08-30','2023-10-10')+1-datediff(ww,'2023-08-30','2023-10-10')*2 as date
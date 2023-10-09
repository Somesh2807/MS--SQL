--database for pantry
create database PANTRY

--- ENter in the databse
USE PANTRY

--create table

create table FOOD(
ID int,
Name nvarchar(30),
START_DATE date,
END_DATE date
);

select * from FOOD



-- create function to display change in price and necessary details
alter function PriceChange1(
    @priceChangeDate DATE,
	@old_price money,
    @newPrice MONEY
)
returns table
AS
return 
( SELECT ID, Name, START_DATE,  END_DATE, @PriceChangeDate as Price_Change_Date,
((DATEDIFF(day, START_DATE, END_DATE)+1) - (DATEDIFF(week, START_DATE, END_DATE) * 2))*@old_price AS Old_Price,
(DATEDIFF(day, @PriceChangeDate, END_DATE)+1) - (DATEDIFF(week, @PriceChangeDate, END_DATE) * 2) AS Days_Since_Change,
@newPrice * ((DATEDIFF(day, @PriceChangeDate, END_DATE)+1) - (DATEDIFF(week, @PriceChangeDate, END_DATE) * 2))  AS New_price_From_Change_Date, 
(@newPrice-@old_price)/ @newPrice * 100 AS Change_percentage, 
((@newPrice * ((DATEDIFF(day, @PriceChangeDate, END_DATE)+1) - (DATEDIFF(week, @PriceChangeDate, END_DATE) * 2))) - (((DATEDIFF(day, @priceChangeDate, END_DATE)+1) - (DATEDIFF(week, @priceChangeDate, END_DATE) * 2)))*@old_price) as Diffrence_Amount
FROM FOOD
WHERE  @priceChangeDate BETWEEN START_DATE AND END_DATE
);



--To run function parameters [@price_change_date], [@old_Price] , [@New_Price per day]

select * from PriceChange1('2023-10-11',92,1)

select * from FOOD


select * from food where id =1
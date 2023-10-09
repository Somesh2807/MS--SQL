create database Test

use Test

create table product_tbl(
P_id int primary key,
Category Nvarchar(20),
Sub_Category NVARCHAR(40),
unit_price_Purcharsed_price money,
selling_price money,
product NVARCHAR(20)
)

create table Sales_Table(
C_id int,
Customer_Name NVARCHAR(30),
P_id int,
Quantity int,
Unit_Price money,
Discount int,
Total_Amount money
)


alter table sales_Table add constraint FK_P_ID  Foreign key (P_id)
references product_tbl(P_id)  on update cascade on delete cascade


alter function distcount()
returns table
as
return
(
select s.C_id,P.Category as Category,S.Quantity,(S.Quantity*P.selling_price) As selling_Price, (S.Quantity*P.selling_price) - ((S.Discount/S.unit_price_Purchased_price*100)*S.Quantity) AS Discounted_Price,
MIN((S.Quantity * P.selling_price) - ((S.Discount / S.unit_price_Purchased_price * 100) * S.Quantity)) OVER (order BY P.Category) AS Min_Value,
MAX((S.Quantity * P.selling_price) - ((S.Discount / S.unit_price_Purchased_price * 100) * S.Quantity)) OVER (order BY P.Category) AS MAX_Value,
SUM((S.Quantity*P.selling_price) - ((S.Discount/S.unit_price_Purchased_price*100)*S.Quantity)) over ( order BY S.C_id) AS Total_amount,
AVG((S.Quantity*P.selling_price) - ((S.Discount/S.unit_price_Purchased_price*100)*S.Quantity)) over (order BY P.Category) AS Average_Amount,
((S.Quantity*P.selling_price)-(S.Quantity*P.unit_price_Purcharsed_price)) as Profit_After_sale
from product_tbl P
inner join Sales_Table S on P.P_id=S.P_id

);


select * from product_tbl
select * from Sales_Table
select * from distcount()


alter function day_Output()
returns table
as
return
(
select sum(Quantity) as Total_Quantity_Sold,sum(profit_after_sale) as Day_End_Profit, AVG(Discounted_price) as Average_Sale_Price
, MIN(Min_Value) AS Minimum_Order_Price, Max(MAX_Value) as Maximum_Sales_Price
from dbo.distcount()
)

-------------- Final Function call

select * from day_Output()
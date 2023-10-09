CREATE TABLE sales_data_final (
	order_id VARCHAR(15) , 
	order_date DATE , 
	ship_date DATE , 
	ship_mode VARCHAR(14) , 
	customer_name VARCHAR(22) , 
	segment VARCHAR(11) , 
	"state" VARCHAR(36) , 
	country VARCHAR(32) , 
	market VARCHAR(6) , 
	region VARCHAR(14) , 
	product_id VARCHAR(16) , 
	category VARCHAR(15) , 
	sub_category VARCHAR(11) , 
	product_name VARCHAR(127) , 
	sales DECIMAL(38, 0) , 
	quantity DECIMAL(38, 0) , 
	discount DECIMAL(38, 3) , 
	profit DECIMAL(38, 5) , 
	shipping_cost DECIMAL(38, 2) , 
	order_priority VARCHAR(8) , 
	"year" DECIMAL(38, 0) 
);



alter database bank modify name = sales
select name
from sys.databases
where database_id>4


select * from sales_data_final
use sales
bulk insert sales_data_final from 'D:\sales_data_final.csv' with ( format ='CSV' , firstrow = 2, fieldterminator = ',' , rowterminator = '\n')

alter table alter 

select * from sales_data_final where order_date >'2011-01-01' and ship_mode = 'second Class' and segment = 'Corporate' 

use sales

select * from sales_data_final where shipped_date > 4

alter table sales_data_final add constraint DF_sales default 0 for sales
alter table sales_data_final add constraint UK_order unique(order_id)
select * from sales_data_final where order_id ='AE-2011-9160'

delete from sales_data_final where order_id ='AE-2011-9160'

alter table sales_data_final add Busineess_day as datediff(day,order_date,ship_date)-2 * datediff(week,order_date,ship_date)
sp_rename 'sales_data_final.shipped_Date','shipped_days'

select dateadd(month,10,'2023-06-20')

select name
from sys.tables
	where database_id>4
alter database rise modify name = 'Rise_1'
sp_renamedb 'rise','rise1'
use sales
select * from sales_data_final

---pivot
select distinct customer_name, country, sum(profit) as profit from sales_data_final
group by customer_name, country 
order by customer_name, country 

alter table sales_data_final add city nvarchar(30)

alter table sales_data_final drop column city
use sales
select datediff(day,'1989-11-25',getdate()) - 2 * datediff(week,'1989-11-25',getdate()) as age

alter table sales_data_final add temp as datediff(day,Order_date,getdate());


select * from sales_data_final order by profit desc

select max(profit) from sales_data_final where profit < (select max(profit) from sales_data_final)

-- Need to cehck
select top 1 profit from sales_data_final where profit
< (select max(profit) from sales_data_final) order by profit desc

use sales

select name
from sys.tables
select * from sales_data_final a
select * from sales_Dummy b

---- Inner Join
select distinct a.customer_name , b.order_id, a.discount,b.market
from sales_data_final a
join sales_Dummy b
on a.order_id = b.order_id
where b.country = 'cuba'
group by country 

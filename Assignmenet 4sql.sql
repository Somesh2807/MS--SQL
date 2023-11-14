use Assesment

create table salesman(
salesman_id int,
name nvarchar(50),
city nvarchar(50),
commission money 
primary key (salesman_id)
)

CREATE TABLE orders (
  order_no INT ,
  purch_amt money ,
  order_date DATE ,
  customer_id INT ,
  salesman_id INT ,
  PRIMARY KEY (order_no),
foreign key (salesman_id) references salesman(salesman_id),
foreign key (customer_id) references customer(customer_id)
);

create table customer(
customer_id int,
customer_name nvarchar(30),
city nvarchar(30),
grade money,
salesman_id int,
primary key (customer_id),
foreign key (salesman_id) references salesman(salesman_id)
)

CREATE TABLE audit_log (
  order_no INT ,
  purch_amt money ,
  order_date DATE ,
  customer_id INT ,
  salesman_id INT ,
  PRIMARY KEY (order_no),
  )

  select name
  from sys.tables


select * from salesman
select * from customer
select * from orders
select * from audit_log


---1.Using join find the name and city of those customers and salesmen who lives in the same city.

select c.customer_name,s.name,c.city,s.city
from customer c
join salesman s
on c.salesman_id=s.salesman_id
where c.city=s.city

---2.Join the salesman, customers, and order tables to get the commission, grade of customer, and purchase amount for all order details.
select o.order_no,c.customer_name,o.purch_amt,c.grade,s.commission
from salesman s
join customer c on c.salesman_id=s.salesman_id
join orders o on o.salesman_id=c.salesman_id


---3.Create a trigger not to update, delete or insert order details in order table before 11AM every day.

CREATE or alter TRIGGER notupdate
on [Orders]
for insert, update, delete
as
begin
if datepart(hour, getdate()) < 11
    begin
        Print('Cannot modify orders before 11 AM')
        rollback
    end
end


---4.Create a trigger to insert a new row into the Audit Log table whenever a row is inserted into the Order table.

CREATE or alter TRIGGER audit_log1
    ON orders
    after insert
    AS
    BEGIN
    SET NOCOUNT ON
    insert into audit_log (order_no,purch_amt,order_date,customer_id,salesman_id)  
    select i.order_no,i.purch_amt,i.order_date,i.customer_id,i.salesman_id from inserted i
    END
    
    
---5.Create a stored procedure to get the top 3 Customer, based on the number of purchase amount.
select top 3 customer_id, sum(purch_amt) as Amount
from orders
group by customer_id
order by Amount desc 
---6.Create a stored procedure to place an order for a customer.
create procedure placeordere
(@order_no int,@purchase money,@order_date date,@customer_id int,@salesman_id int)
as 
begin
insert into orders (order_no,purch_amt,order_date,customer_id,salesman_id) values
(@order_no,@purchase,@order_date,@customer_id,@salesman_id)
end

exec placeorder @order_no = ,@purchase = ,
@order_date = '  ' ,@customer_id = ,@salesman_id =



---7.Create a function to calculate the total purchase amount for a given customer name.


CREATE FUNCTION customer_name
(@name Nvarchar(50))
returns  TABLE 
AS
return
(select c.customer_name,sum(o.purch_amt) as Amount,c.customer_id
from orders o
join customer c on o.customer_id=c.customer_id
where @name=c.customer_name
group by c.customer_name,c.customer_id
)

select * from customer_name('Brad Guzan')
---8.(a) Extract the data from the orders table for the salesman who earned the maximum  
---      commission using subquery.

select query.salesman_id, max(query.commision_Amount) as Commission_Amount
from salesman s
join  (select top 1 s.salesman_id,sum(s.commission*o.purch_amt) as commision_Amount
from salesman s
join orders o on s.salesman_id=o.salesman_id
group by s.salesman_id
order by commision_Amount desc
) query on query.salesman_id=s.salesman_id
group by query.salesman_id
 
  
---(b) Extract the data from the orders table for the count of orders for each salesperson
select salesman_id ,count(order_no) as Order_count
from orders
where salesman_id is not null
group by salesman_id
order by Order_count desc
use AdventureWorks2022

select name
from sys.tables
order by name asc



--Q1)Show the first name and the email address of customer with CompanyName 'Bike World' 
  

--Q2)Show the CompanyName for all customers with an address in City 'Dallas'. 

select CompanyName from Customers where City = 'Dallas'

--3. How many items with List Price more than $1000 have been sold? 

select * from Products where UnitPrice >100
select * from Sales.SalesOrderDetail where ProductID = 29 and where ProductID = 15

select S.ProductID,s.UnitPrice
from Products P
join sales.SalesOrderDetail S on p.ProductID=S.ProductID
where p.UnitPrice > 100


update employee set salary = salary+(salary*0.15)
from employee
where hire_date BETWEEN '2022-1-1' AND getdate()

select * from employee
create database temp007
use temp007

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    hire_date DATE,
    salary DECIMAL(10, 2)
);

INSERT INTO employee (emp_id, emp_name, hire_date, salary)
VALUES
    (1, 'John Smith', '2023-03-15', 50000.00),
    (2, 'Jane Doe', '2021-05-20', 60000.00),
    (3, 'Bob Johnson', '2022-06-10', 55000.00);

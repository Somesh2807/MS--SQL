create database rise2023
use rise2023

create table interns
(
id nvarchar(10),
name nvarchar(20),
departmenet nvarchar(20),
email_id nvarchar(50),
);

insert into emp1 values (1,'somesh_singh','somesh8200@outlook.com','Male','1997-08-28')
insert into emp1 values (2,'Happin','happin28@outlook.com','Male','1997-08-28')
insert into emp1 values (1,'somesh','somesh28071997@outlook.com','Male','1997-08-28')
insert into emp1 values (3,'Aman','aman@outlook.com','Male','1997-08-28')

select * from emp1
 
select * from emp1; 
sp_rename 'emptbl','emp1';
alter empt1 rename to emp2;
ALTER TABLE rise2023.table.emp1 | rise2023.table.emp2|emp1 
sp_help 'emp1'
truncate table emp1

ALTER SCHEMA rise2023 TRANSFER emp1.emp2
create database temp
use temp

create table employee
(
emp_id int not null,
emp_name nvarchar(20) 
contact_number int unique 
dep_id nvarchar(20) 
);

select * from employee
alter table employee add DOB date;
insert into employee values (25,'somesh',8258,'timesheet')
insert into employee values (27,'somesh singh',8200,'timesheet')

sp_help employee
alter table employee drop column DOB;

delete from employee where emp_id=25;
update employee set emp_id=28 where contact_number = 8200
update employee set contact_number=9897 where emp_id = 28;
update employee set emp_name = 'vineeta singh', contact_number= 28287 where emp_id = 28;
select * from employee

use rise2023

select * from emp1

update emp1 set empid = 0 where empid=1
delete from emp1 where empid=0;

select name	
from sys.databases
where database_id>4;

use name
select name
from sys.tables;

select *  from emp1;

select empid,email_id from emp1 where empid=2;

delete from emp1 where empid = 2;

select name
from sys.tables

drop table emp1 , empid;
select name
from sys.databases
where database_id>4;

select name	
from sys.databases
where database_id>4;

use rise2023
drop database temp;
drop database rise2023;
create database bank;
use bank
create database ssbank
use ssbank
drop database bank

create database sales
use sales
drop database ssbank

create table sales_data_final
(
	order_id VARCHAR(15),
	order_date DATE  ,
	ship_date DATE  ,
	ship_mode VARCHAR(14),  
	customer_name VARCHAR(22) , 
	segment VARCHAR(11)  ,
	state VARCHAR(36)  ,
	country VARCHAR(32) , 
	market VARCHAR(6)  ,
	region VARCHAR(14)  ,
	product_id VARCHAR(16) , 
	category VARCHAR(15)  ,
	sub_category VARCHAR(11),  
	product_name VARCHAR(127) , 
	sales bigint  ,
	quantity bigint , 
	discount DECIMAL(38, 3) , 
	profit money ,
	shipping_cost money  ,
	order_priority nVARCHAR(8) , 
	Year Int
);

CREATE TABLE sales_data_final (
	order_id VARCHAR(15) NOT NULL, 
	order_date DATE NOT NULL, 
	ship_date DATE NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales DECIMAL(38, 0) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 5) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	year DECIMAL(38, 0) NOT NULL
);




select name
from sys.tables
select * from sales_data_final
sp_help sales_data_final

BULK INSERT sales_data_final FROM 'D:\sales_data_final.csv' WITH  ( FIELDTERMINATOR = ',', ROWTERMINATOR = '\n',  FIRSTROW = 2); 
BULK INSERT sales_data_final
   FROM 'D:\sales_data_final.csv'
   drop table sales_data_final
   set session sql_mode=''
alter table sales_data_final alter column sales DECIMAL;

BULK INSERT sales_data_final
FROM 'D:/sales_data_final.csv' WITH  ( FIELDTERMINATOR = ',', ROWTERMINATOR = '\n',  FIRSTROW = 2);
select * from sales_data_final
BULK INSERT sales_data_final
FROM 'D:\sales_data_final.csv' 
WITH (
    FIELDTERMINATOR = ','
);
sp_help sales_data_final;

BULK INSERT sales_data_final
FROM 'D:\sales_data_final.csv'
WITH (
   FORMAT = 'CSV',
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n'
);
sp_help sales_data_final
select * from sales_data_finals
select name
from sys.databases
where database_id>4;
use sales
select name
from sys.tables
select *  from sales_data_final

select country,order_date,product_name from sales_data_final  where market = 'APAC, EU';

create database rise_inter
use rise_inter

sp_renameDB 'rise_inter','rise1'

alter database rise1
modify name =rise_inter;
create table interns
(
id nvarchar(10),
name nvarchar(20),
departmenet nvarchar(20),
email_id nvarchar(50),
);

insert into interns values (1,'somesh jatav','Data alaystics','somesh11@outlook.com')

alter table interns alter column id int;
alter table interns add gender nvarchar(20);
alter table interns add stipend money;
alter table interns add DOB Date;
alter table interns add Age smallint;
sp_help interns

use sales
select* from interns
sp_help intern
use rise_inter
--drop
alter table interns drop column age;
---Rename 
sp_rename 'interns','intern'

select * from intern
-- update
                              
update intern set name = ' somesh' where id=1;
----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create database rise_interns
use rise_interns

create table intern
(
Id int not null,
First_name nvarchar(20),
Last_name nvarchar(20),
email_id nvarchar(50),
DOB date not null,
Gender Nvarchar(6),
Stppened money,
);

select* from intern

sp_help intern

--- total number of database avaialble
select name
from sys.databases
where database_id>4;
--total Table in database
select name
from sys.tables

--- Help for table
sp_help intern

select*from Rise_intern

--Column rename
sp_rename 'Rise_intern.Stppened', 'Stipened','COLUMN';

--Table Rename
sp_rename 'Rise-intern','Rise_intern'
sp_help Rise-intern
insert into Rise_intern values(1,'Somesh','Jatav','somesh8200@gmaail.com','1997-07-28','Male',1000)
insert into Rise_intern values(2,'Vineeta','Singh','vinni@gmail','1998-12-23','Female',1000)
insert into Rise_intern values(3,'Mansi','Soni','mansi.soni@gmail','1995-07-27','Female',1000)
insert into Rise_intern values(4,'Snehal','Rajput','snehal@gmail.com','1997-07-24','Female',1000)
insert into Rise_intern values(5,'Suraj','Thakur','suraj@gmail.com','1997-07-24','Male',1000)
insert into Rise_intern values(6,'Rameez','Mansuri','rameez200@gmail.com','1997-07-24','Male',1000)
insert into Rise_intern values(7,'Sejal','Singh','sejalsingh@gmail.com','1997-07-28','Female',1000)

Alter rise_interns alter Rise_intern

select name
from sys.databases
where database_id>4

use rise_interns
select name from sys.tables
sp_rename 'Rise_intern','intern';
select * from intern
sp_help intern

sp_rename 'intern.identity','identity_no','column';

select name
from sys.databases
where database_id>4


alter database rise_interns modify name = rise;

create table somesh
(
Name nvarchar(50),
DOB date,
);
select name
from sys.tables
drop table somesh

-- ALter Table Data Type
alter table intern alter column First_name varchar(50);
---Update Value in a table
update intern set First_name = 'Thakur' where identity_no = 5;
--select command
select first_name , DOB from intern where DOB = '1997-07-24'
select * from intern
-- ADD / Remove Column
alter table intern drop column DOB
ALter table intern add DOB date;
update intern set DOB ='1997-01-27' where gender = 'Female';

select name
from sys.databases
where database_id>4

select name
from sys.databases
where database_id>4
use rise
create table staff_1
(
Emp_ID int identity(1,1) not null,
First_Name nvarchar(30),
Last_Name nvarchar(30),
Email_ID nvarchar(50),
Contact_No int not null,
DOB date not null,
);
select * from staff_1
sp_help staff

alter table staff_1 alter column Contact_No nvarchar(10);



insert into staff_1 values ('Somesh','Jatav','somesh8200@outlook.com',8200857566,'1997-07-28','DA')
insert into staff_1 (First_name,Last_Name,Email_ID,DOB,Contact_NO) values ('Temp','temp','vishal@gmail.com','1997-09-28',8200457698)

	update staff_1 set First_Name = 'Vishal' where Emp_ID =3

	select name
	from sys.databases
	where database_ID>4

	use rise
	select * from intern
	sp_help intern
	alter table intern alter column identity_no bigint not null;
	alter table intern alter column Stipened money not null;
	alter table intern alter column DOB Date not null;
-- Truncate table

	truncate table intern

	-- Primary Key 
	alter table intern add constraint pk_ID primary key (identity_no)

alter table dept add  depid bigint;


create table dept
(
deptid bigint identity (1,2) primary key,
dept_name nvarchar(20),
HOD_name nvarchar(20)
);

select * from intern
select * from dept
sp_help dept
sp_help intern

alter table intern alter column depid bigint

--- HW need to create gender table for same

ALTER TABLE intern ADD CONSTRAINT FK_intern FOREIGN KEY (depid) REFERENCES intern(depid)
create database demo
use demo

create table Employee
(
Emp_ID nvarchar(10) not null,
Dep_ID bigint
);

alter table staff add constraint FK_Gender foreign key (Gender) references intern(Gender)
sp_help staff
create table dep
(
Dep_ID nvarchar(10) primary key,
HOD_Name nvarchar(20)
);

ALTER TABLE depDD CONSTRAINT FK_intern FOREIGN KEY (depid) REFERENCES intern(depid)
alter table employee constraint Fk_employee foreign key (Dep_ID) references employee(Dep_ID);
ALTER TABLE employee
ADD CONSTRAINT Fk_employee FOREIGN KEY (Dep_ID) REFERENCES employee(eID);

alter table employee add constraint fk_key foreign key (Dep_ID) references


alter table Employee alter Emp_ID add constraint pk_ID primary key D

select name from sys.tables where database_ID>4
use rise
update staff set Emp_ID = 3, Dep_ID='DA' where First_Name ='Vishal'
select * from staff
select * from intern
sp_help staff
sp_help intern
sp_rename 'intern.depid','Dep_ID'
-- No Primary key assigned to Staff table
alter table staff add constraint pk1_key primary key (Dep_ID)

alter table intern alter column Dep_ID nvarchar(5) not null

ALTER TABLE intern ADD CONSTRAINT Fk_employee FOREIGN KEY (Dep_ID) REFERENCES staff(Dep_ID)

select Emp_ID, HOD_Name from staff where Emp_ID = 1
union 
select identity_no , Gender, Dep_ID from intern


sp_rename 'staff.First_Name','HOD_Name'
update staff set Dep_ID = 'DS' where Emp_Id = 1
update intern set Dep_ID = 'DS' where 
identity_no = 1
use rise
insert into staff values (1,'Vishal',820085,'DA')
insert into intern values (2,'Akash','Male',1000,'1997-07-28','DS')
sp_help staff
use rise


update staff set Emp_ID =2 where Dep_ID = 'DA'

alter table staff alter column Emp_ID int not null

alter table staff alter column Emp_ID int ey identity(

select * from staff order by Emp_ID ASC

alter table staff add temp int after Emp_ID

select name
from sys.tables
where database_id>4
use rise
alter table intern alter column email nvarchar(50) 
alter table intern alter column  gender nvarchar(6) not null
---- DROP CONSTRAINT

alter table intern drop constraint pk_ID

select * from intern
select * from staff
update staff set gender = 'male' where Emp_ID = 1
sp_help intern

select * from intern
select * from staff
drop table dept
alter table staff_1 alter column DOB date not null

--- OR
select * from staff where ( Dep_ID = 'DA' or Dep_ID ='DS') 

sp_help intern

---- UNIQUE KEY
alter table intern add constraint uk_intern unique(email)
select *  from intern

update intern set email ='somesh8200@outlook.com' where identity_no = 1
---- DEFAULT

alter table intern add constraint DF_stipened default 0 for stipened
use rise

select name
from sys.tables

select * from intern
alter table intern add Age date;
alter table intern alter column Age int;
sp_help intern
select identity_no, First_name, DOB, datediff(YY,DOB,getdate()) as Age from intern

select name
from sys.databases
where database_id>4

---- rise , sales two database are available


use rise

select name
from sys.tables

--- intern , staff tables are available in rise data base

select * from intern
sp_help intern
update intern set Age = (datediff(YY,DOB,getdate()) where  identity_no = 1
alter table intern drop column Age
---- Automated Age calculation
alter table intern add age_new as (datediff(YY,DOB,getdate()))
alter table intern drop constraint pk_1ID
sp_help staff
alter table staff drop constraint FK_Gender
use rise

select* from intern order by identity_no asc
select * from staff order by Emp_ID asc

--- Left Join
select * from  intern left join staff on intern.Dep_ID = staff.HOD_Name order by identity_no asc

--- LEFT Outer Join
select * from  intern left join staff on intern.Dep_ID = staff.HOD_Name where Emp_ID is null order by identity_no ASC
--- Right JOin
select * from  intern right join staff on intern.Dep_ID = staff.HOD_Name order by identity_no asc

-- Right Outer Join
select * from  intern right join staff on intern.Dep_ID = staff.HOD_Name where Emp_ID is null  order by identity_no asc

insert into intern values(3,'Vikas Singh','male',5000,'1996-12-23','DS','vikassinghpvdei@gmail.com')

select * from intern where identity_no = 1 and identity_no =3

alter table intern add Age1 as datediff(year,DOB,getdate());

--- full outer JOin

select * from intern full outer join staff on identity_no = Emp_ID where Emp_ID is null

create table table1(
enrolmenet_id bigint identity(1,1),
studen_name nvarchar(20),
student_dob date,
);
alter table table2 add student_age as datediff(YY,student_dob,getdate())

create table table2(
enrolmenet_id bigint identity(1,1),
studen_name nvarchar(20),
student_dob date,
student_marks int,
contact_no bigint,
email_id nvarchar(30)
);

select * from table1
select * from table2

insert into table2 values ('Kajal','1997-08-28',550,8200566,'Kajal@gmail.com')
insert into table2 values ('Hardika','1991-08-28',510,82857566,'Hardika@gmail.com')
insert into table2 values ('Vaishali','1992-08-28',570,857566,'Vaishali@gmail.com')
insert into table2 values ('Madhu','1993-08-28',558,82857566,'MAdhu@gmail.com')
insert into table2 values ('vishal','1994-08-28',510,80857566,'Vishal@gmail.com')

--- EQUIE JOin

select table1.studen_name, table1.enrolmenet_id,table2.student_dob,table2.contact_no
from table1 join table2 on table1.enrolmenet_id=table2.enrolmenet_id

---NON EQUIE JOIN
select * from table1 join table2 on table1.enrolmenet_id<table2.enrolmenet_id

----Self Join
select a.enrolmenet_id,b.studen_name
from table1 a, table1 b
where a.enrolmenet_id< b.enrolmenet_id

--- Inner Join error in query need to check same


SELECT intern.identity_no,staff.HOD_Name
FROM intern
INNER JOIN staff ON intern.identity_no = staff.HOD_Name 

select name
from sys.databases
where database_id>4

use sales

select name
from sys.tables
where database_id>4


select distinct order_id from sales_data_final

sp_help sales_data_final

use sales

select * from sales_data_final

select count(order_id) as Total_count from sales_data_final where country = 'Algeria'

create table banking(
bank_id int identity(1476,2),
"name" nvarchar(30),
"location" nvarchar(20)
);

begin transaction insert into banking values('IMCS', ' Delhi'),('Koktak', ' Agra'),('SBI', ' Vadodara'),('PNB','Anand')
select * from banking
select* from bank
begin transaction rollback
begin transaction delete bank where bank_id = 1464
begin transaction update bank set location = 'Atladra' where bank_id =1464 commit

select name
from sys.tables

-- partial rollback

Begin transaction
delete from bank where bank_id = 1478
save transaction s2
delete from bank where bank_id = 1476
commit
begin transaction rollback transaction s2
select * from bank
--- NON ANSI Joints

select * from banking
select* from bank
--"self join"
select  * from bank,banking where bank.bank_id <banking.bank_id

select * from bank, banking

--- EQUIE JOin

select table1.studen_name, table1.enrolmenet_id,table2.student_dob,table2.contact_no
from table1 join table2 on table1.enrolmenet_id=table2.enrolmenet_id

---NON EQUIE JOIN
select * from table1 join table2 on table1.enrolmenet_id<table2.enrolmenet_id

select * from intern
use rise1

select name
from sys.tables
where database_id>4

select * from sales_data_final
-- Group by 
select country, sum(sales) as sales
from sales_data_final where state = 'australia' group by country

--- Arithmetic operator

select  50+80 as sum, 90-80 as substract, 90/10 as Divide, 100%10 as modules, 10*20 as Multiplication

use rise1
select * from intern where Gender = 'male' and Dep_ID = 'DS' order by identity_no asc 
---End with entered pattern
select * from intern where Gender like '%e'
--- start with pattern
select * from intern where Gender like 'm%'

--- NOt equal to
select * from intern where Gender!='m'
-- Having exact character in coloumn data set
select * from intern where 'name' like 's%'
use rise1
sp_help staff

alter table intern drop constraint FK_Dep_id
select * from intern
alter table intern add constraint FK_Dep_id 
foreign key (Dep_ID) references staff(Dep_ID) on update cascade on delete cascade
alter table intern drop constraint FK_Dep_id
sp_help intern

delete intern where identity_no = 1

update intern set Dep_ID = 'DS' where identity_no =1
sp_help intern

use sales
select name
from sys.tables
select * from sales_data_final


BULK INSERT sales_dummy
FROM 'D:\sales_data_final - Copy.csv'
WITH (
   FORMAT = 'CSV',
   firstrow = 2,
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n'
);

select * from sales_dummy
drop table sales_dummy
CREATE TABLE sales_Dummy (
	order_id VARCHAR(15) , 
	order_date DATE , 
	ship_date DATE , 
	ship_mode VARCHAR(14) , 
	customer_name VARCHAR(22) , 
	segment VARCHAR(11) , 
	state VARCHAR(36) , 
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
	year DECIMAL(38, 0) 
);


select name
from sys.tables


select * from table1
select * from table2

select * from emptbl where deptID in (select  deptid from emptbl where empname= 'Somesh ' or 'Empname')

-----------------JOINS Practice

create database joins
use joins
create table order_status(
order_ID bigint,
customer_id bigint,
order_date date
)

create table customer_detail(
order_ID bigint,
Customer_Name nvarchar(40),
order_date date
)

bulk insert  customer_detail from 'D:\DATABASE\Customer Detaisl.csv' with 
(format ='CSV', fieldterminator = ',', firstrow = 2, rowterminator ='\n')

bulk insert  order_status from 'D:\DATABASE\order detail.csv' with 
(format ='CSV', fieldterminator = ',' , firstrow = 2, rowterminator ='\n')

select * from order_status
select * from customer_detail

alter table customer_detail alter  column Order_ID bigint not null
alter table customer_detail add constraint PK_Order_ID primary key (order_ID)
alter table order_status add constraint FK_Order_ID foreign key ( Order_ID )
references  customer_detail(order_ID) on update cascade on delete cascade
sp_help order_status
sp_rename 'customer_detail.order_ID','Customer_ID'

--- JOINS
select order_status.order_ID, customer_detail.Customer_Name,order_status.order_date, customer_detail.order_date 
from order_status inner join customer_detail 
on order_status.order_ID = customer_detail.Customer_ID 
where  customer_detail.Customer_ID >1
order by order_ID desc offset 0 rows
fetch next 1 rows only

----- SELF JOIN



CREATE TABLE CUSTOMERS (
   ID INT NOT NULL,
   NAME VARCHAR (20) NOT NULL,
   AGE INT NOT NULL,
   ADDRESS CHAR (25),
   SALARY DECIMAL (18, 2),       
   PRIMARY KEY (ID)
);
use sales
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (1, 'Ramesh', 32, 'Ahmedabad', 2000.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (2, 'Khilan', 25, 'Delhi', 1500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (3, 'kaushik', 23, 'Kota', 2000.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (4, 'Chaitali', 25, 'Mumbai', 6500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (5, 'Hardik', 27, 'Bhopal', 8500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (6, 'Komal', 22, 'MP', 4500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (7, 'Muffy', 24, 'Indore', 10000.00 );

select * from CUSTOMERS

select name
from sys.tables

select * from table1
select * from table2

--- Left Join
select a.enrolmenet_id, a.studen_name,b.student_age,a.email_id
from table2 a
right join table1 b
on a.enrolmenet_id=b.enrolmenet_id

select a.enrolmenet_id, b.studen_name, b.student_marks, b.contact_no 
from table1 a
left join table2 b
on a.enrolmenet_id=b.enrolmenet_id
where b.student_marks > 550



select a.enrolmenet_id, b.email_id,b.student_marks
from table1 a
full join table2 b
on a.enrolmenet_id=b.enrolmenet_id

select a.enrolmenet_id, a.studen_name,b.student_age,a.email_id
from table1 a
Full outer join table2 b
on a.enrolmenet_id=b.enrolmenet_id
Where a.enrolmenet_id is null


----Self Join--------------------------------c

select a.enrolmenet_id as ID , b.studen_name as Name 
from  table2 A, table2 B
where a.enrolmenet_id=b.enrolmenet_id
AND a.enrolmenet_id=b.enrolmenet_id
order by a.enrolmenet_id desc offset 0 rows
fetch next 2 rows only

-----------------------------------------------


create database practice
use practice

create table sales(
Emp_Name nvarchar(50),
City_ID int primary key,
Sales money)


select * from sales,country

---list of emp and countries they belong to
---list of employe details who belongs to only in INdia or US

select s.Emp_Name,e.Country_Name
from sales S
 join City C on s.City_ID = c.City_ID
join Country E on c.Country_ID=e.Country_ID
where e.Country_Name = 'India' or Country_Name = 'US'



---
---Most popular classs chooose by the vsitor
---count of seat number in flight

select * from city
create table City(
City_ID int,
City nvarchar(50),
Country_ID int);

create table Country (
Country_ID int primary key,
Country_Name nvarchar(50)
)

alter table City add constraint FK_Country_ID foreign key (Country_ID) references Country(Country_ID)
on delete cascade on update cascade

Create database Films
use Films
create table H_Films(
Film_Name nvarchar(50),
Actor nvarchar(50),
Length Time
)

create table B_Films(
Film_Name nvarchar(50),
Actor nvarchar(50),
Length Time
)
select * from B_Films, H_Films

select b.Film_Name as Bollywood_Name,h.Film_Name as Hollywod_Name,b.Length as Movie_Length
from B_Films B
join H_Films H on b.Length = h.Length

select Film_Name as Bollywood_Name from B_Films where length = (select Film_Name as H.Film_Name from 
H_Films  )


-- Written a query for a particular customer who booked ticket on particular date.


use rise



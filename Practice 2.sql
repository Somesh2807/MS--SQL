select name 
from sys.tables
where database_ID >4

use joins

create table Emp
(
Emp_ID Nvarchar(10),
Emp_Name Nvarchar(50),
Salary money,
Dep_ID nvarchar(10),
Manager_ID Nvarchar(10)
);

alter table Emp add  DOJ date
alter table Emp drop column Manager_ID

insert into Emp values ('E1','suresh',20000,'D1','M1') ,('E2','Mahesh',30000,'D2','M2')
insert into Emp values ('E3','Ramesh',30000,'D3','M3') ,('E4','Kamlesh',35000,'D4','M4')

create table Manager(
Manager_ID Nvarchar(10),
M_Name Nvarchar(30),
Dep_ID nvarchar(10)
);
insert into Manager values ('M1','John','D2'),('M2','May','D3'),('M3','Harry','D1')

create table Project (
P_ID Nvarchar(10),
P_Name Nvarchar(20),
Emp_ID Nvarchar(10)
);

insert into Project values ('P1','Data  Migration','E1'),('P2','Data Migration','E2'),('P3','ETL','E3')

create table Department(
Dep_ID nvarchar(10),
D_Name nvarchar(30)
);

insert into Department values ('D1','IT'), ('D2','HR'),('D3','BD')

select D.Dep_ID, M.Manager_ID,D.D_Name,M.M_Name
from Department D
left Join Manager M
On M.Dep_ID = D.Dep_ID


--fecth employee name and their department they belong to.
----fetch details of all employees, thier department , manager , projects
--fetch list of employees working under manager john 
--fetch list of employees who doesn't belong to any departmenet.

select E.Emp_Name,D.D_Name
from Emp E
inner Join Department D
On e.Dep_ID=D.Dep_ID

select E.Emp_Name,D.D_Name
from Emp E
left Join Department D
On e.Dep_ID=D.Dep_ID


select * from Emp
select * from Department
select * from Project
select * from Manager

select e.Emp_ID, D.Dep_ID,p.P_Name, E.Emp_Name
from Emp E
left Join Department D On e.Dep_ID=D.Dep_ID
left Join Project P on e.Emp_ID =p.Emp_ID
where P_Name is not null

select E.Emp_Name,D.D_Name,m.M_Name,p.P_Name
from Emp E
left Join Department D On e.Dep_ID=D.Dep_ID
left join Manager M on e.Manager_ID=m.Manager_ID
left Join Project P on e.Emp_ID =p.Emp_ID
where P_Name is not null and M_Name = 'John'

select E.Emp_Name,D.D_Name,m.M_Name,p.P_Name
from Emp E
left Join Department D On e.Dep_ID=D.Dep_ID
left join Manager M on e.Manager_ID=m.Manager_ID
left Join Project P on e.Emp_ID =p.Emp_ID
where P_Name is null 


create table Emp_table(
Emp_ID nvarchar(30)

select * from Emp
select * from Department


--- 2nd higest Salary 
select top 1 Emp_Name, salary
from emp
where salary < (select max(salary) from emp)
order by salary desc


select top 1 Emp_Name , salary
from emp
where salary != (select max(salary) from emp)
order by salary desc

---- Find employee details having max salary in his dept

select * from Emp
select * from Department

SELECT  E.Emp_ID, E.Emp_Name, E.Salary, E.Dep_ID,d.D_Name
FROM Emp E
JOIN Department D
on e.Dep_ID=D.Dep_ID


SELECT E.Emp_ID, E.Emp_Name, D.D_Name as Dep_ID, E.Salary
FROM Emp E
JOIN ( SELECT Dep_ID, MAX(salary) AS max_salary FROM Emp GROUP BY Dep_ID)
emax ON e.Dep_ID= emax.Dep_ID and e.salary = emax.max_salary
JOIN Department D ON e.Dep_ID = D.Dep_ID
order by e.Salary desc


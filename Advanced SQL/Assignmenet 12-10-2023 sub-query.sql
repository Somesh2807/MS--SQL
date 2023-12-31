Create Database Assesment

use Assesment


CREATE TABLE departments
    ( 
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(30),
    location_id INTEGER
    ) 

CREATE TABLE employees
   (
   employee_id INTEGER,
    first_name VARCHAR(20),
    last_name VARCHAR(25) ,
    email VARCHAR(25),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary INTEGER,
    commission_pct INTEGER,
    manager_id INTEGER,
    department_id INTEGER,
    constraint pk_emp primary key (employee_id) ,
    constraint fk_deptno foreign key (department_id) references departments(department_id)  
   ) 




INSERT INTO departments VALUES ( 20,'Marketing',  180);
 INSERT INTO departments VALUES ( 30,'Purchasing',  1700);
 INSERT INTO departments VALUES ( 40, 'Human Resources',  2400);
 INSERT INTO departments VALUES ( 50, 'Shipping',  1500);
 INSERT INTO departments VALUES ( 60 , 'IT',  1400);
 INSERT INTO departments VALUES ( 70, 'Public Relations',  2700);
 INSERT INTO departments VALUES ( 80 , 'Sales',  2500 );
 INSERT INTO departments VALUES ( 90 , 'Executive',  1700);
 INSERT INTO departments VALUES ( 100 , 'Finance',  1700);
 INSERT INTO departments VALUES ( 110 , 'Accounting',  1700);
 INSERT INTO departments VALUES ( 120 , 'Treasury' ,  1700);
 INSERT INTO departments VALUES ( 130 , 'Corporate Tax' ,  1700 );
 INSERT INTO departments VALUES ( 140, 'Control And Credit' ,  1700);
 INSERT INTO departments VALUES ( 150 , 'Shareholder Services', 1700);
 INSERT INTO departments VALUES ( 160 , 'Benefits', 1700);
 INSERT INTO departments VALUES ( 170 , 'Payroll' , 1700);


INSERT INTO employees VALUES (100, 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17' , 'AD_PRES', 24000 , NULL, NULL, 20);
INSERT INTO employees VALUES (101, 'Neena' , 'Kochhar' , 'NKOCHHAR' , '515.123.4568' , '1989-11-21' , 'AD_VP' , 17000 , NULL , 100 , 20);
INSERT INTO employees VALUES (102 , 'Lex' , 'De Haan' , 'LDEHAAN' , '515.123.4569' , '1993-09-12' , 'AD_VP' , 17000 , NULL , 100 , 30);
INSERT INTO employees VALUES (103 , 'Alexander' , 'Hunold' , 'AHUNOLD' , '590.423.4567' , '1990-09-30', 'IT_PROG' , 9000 , NULL , 102 , 60);
INSERT INTO employees VALUES (104 , 'Bruce' , 'Ernst' , 'BERNST' , '590.423.4568' , '1991-05-21',  'IT_PROG' , 6000 , NULL , 103 , 60);
INSERT INTO employees VALUES (105 , 'David' , 'Austin' , 'DAUSTIN' , '590.423.4569' , '1997-06-25',  'IT_PROG' , 4800 , NULL , 103 , 60);
INSERT INTO employees VALUES (106 , 'Valli' , 'Pataballa' , 'VPATABAL' , '590.423.4560' , '1998-02-05',  'IT_PROG' , 4800 , NULL , 103 , 40);
INSERT INTO employees VALUES (107 , 'Diana' , 'Lorentz' , 'DLORENTZ' , '590.423.5567' , '1999-02-09',  'IT_PROG' , 4200 , NULL , 103 , 40);
INSERT INTO employees VALUES (108 , 'Nancy' , 'Greenberg' , 'NGREENBE' , '515.124.4569' , '1994-08-17',  'FI_MGR' , 12000 , NULL , 101 , 100);
INSERT INTO employees VALUES (109 , 'Daniel' , 'Faviet' , 'DFAVIET' , '515.124.4169' , '1994-08-12',  'FI_ACCOUNT' , 9000 , NULL , 108 , 170);
INSERT INTO employees VALUES (110 , 'John' , 'Chen' , 'JCHEN' , '515.124.4269' , '1997-04-09',  'FI_ACCOUNT' , 8200 , NULL , 108 , 170);
INSERT INTO employees VALUES (111 , 'Ismael' , 'Sciarra' , 'ISCIARRA' , '515.124.4369' , '1997-02-01',  'FI_ACCOUNT' , 7700 , NULL , 108 , 160);
INSERT INTO employees VALUES (112 , 'Jose Manuel' , 'Urman' , 'JMURMAN' , '515.124.4469' , '1998-06-03', 'FI_ACCOUNT' , 7800 , NULL , 108 , 150);
INSERT INTO employees VALUES (113 , 'Luis' , 'Popp' , 'LPOPP' , '515.124.4567' , '1999-12-07',  'FI_ACCOUNT' , 6900 , NULL , 108 , 140);
INSERT INTO employees VALUES (114 , 'Den' , 'Raphaely' , 'DRAPHEAL' , '515.127.4561' , '1994-11-08',  'PU_MAN' , 11000 , NULL , 100 , 30);
INSERT INTO employees VALUES (115 , 'Alexander' , 'Khoo' , 'AKHOO' , '515.127.4562' , '1995-05-12',  'PU_CLERK' , 3100 , NULL , 114 , 80);
INSERT INTO employees VALUES (116 , 'Shelli' , 'Baida' , 'SBAIDA' , '515.127.4563' ,'1997-12-13', 'PU_CLERK' , 2900 , NULL , 114 , 70);
INSERT INTO employees VALUES (117 , 'Sigal' , 'Tobias' , 'STOBIAS' , '515.127.4564' , '1997-09-10', 'PU_CLERK' , 2800 , NULL , 114 , 30);
INSERT INTO employees VALUES (118 , 'Guy' , 'Himuro' , 'GHIMURO' , '515.127.4565' , '1998-01-02',  'PU_CLERK' , 2600 , NULL , 114 , 60);
INSERT INTO employees VALUES (119 , 'Karen' , 'Colmenares' , 'KCOLMENA' , '515.127.4566' , '1999-04-08',  'PU_CLERK' , 2500 , NULL , 114 , 130);
INSERT INTO employees VALUES (120 , 'Matthew' , 'Weiss' , 'MWEISS' , '650.123.1234' ,'1996-07-18',  'ST_MAN' , 8000 , NULL , 100 , 50);
INSERT INTO employees VALUES (121 , 'Adam' , 'Fripp' , 'AFRIPP' , '650.123.2234' , '1997-08-09',  'ST_MAN' , 8200 , NULL , 100 , 50);
INSERT INTO employees VALUES (122 , 'Payam' , 'Kaufling' , 'PKAUFLIN' , '650.123.3234' ,'1995-05-01',  'ST_MAN' , 7900 , NULL , 100 , 40);
INSERT INTO employees VALUES (123 , 'Shanta' , 'Vollman' , 'SVOLLMAN' , '650.123.4234' , '1997-10-12',  'ST_MAN' , 6500 , NULL , 100 , 50);
INSERT INTO employees VALUES (124, 'Kevin' , 'Mourgos' , 'KMOURGOS' , '650.123.5234' , '1999-11-12',  'ST_MAN' , 5800 , NULL , 100 , 80);
INSERT INTO employees VALUES (125, 'Julia' , 'Nayer' , 'JNAYER' , '650.124.1214' , '1997-07-02',  'ST_CLERK' , 3200 , NULL , 120 , 50);
INSERT INTO employees VALUES (126, 'Irene' , 'Mikkilineni' , 'IMIKKILI' , '650.124.1224' , '1998-11-12', 'ST_CLERK' , 2700 , NULL , 120 , 50);
INSERT INTO employees VALUES (127, 'James' , 'Landry' , 'JLANDRY' , '650.124.1334' , '1999-01-02' , 'ST_CLERK' , 2400 , NULL , 120 , 90);
INSERT INTO employees VALUES (128, 'Steven' , 'Markle' , 'SMARKLE' , '650.124.1434' , '2000-03-04' , 'ST_CLERK' , 2200 , NULL , 120 , 50);
INSERT INTO employees VALUES (129, 'Laura' , 'Bissot' , 'LBISSOT' , '650.124.5234' ,'1997-09-10' , 'ST_CLERK' , 3300 , NULL , 121 , 50);
INSERT INTO employees VALUES (130, 'Mozhe' , 'Atkinson' , 'MATKINSO' , '650.124.6234' , '1997-10-12' , 'ST_CLERK' , 2800 , NULL , 121 , 110);

--Q1. Find the employees who joined the company after 15th of the month.

select * from employees where day(hire_date)>15

--Q2. Write an SQL query to display employees who earn more than the average salary in that company. 
     
     select *  from employees where salary >=
     (select avg(salary) from employees)

--Q3. Write a query to select employees and their corresponding managers and their salaries. 
     
     select e.employee_id,e.first_name,e.manager_id,e.salary
     from employees E  join employees F 
     on E.employee_id=F.employee_id
     where E.manager_id is not null


--Q4. Display the managers and the reporting employees who work in different departments. 
     select E.manager_id,E.employee_id,E.first_name,D.department_name
     from employees E  inner Join  departments D 
     on E.department_id=D.department_id
     
          

--Q5. Write a query to select employee with the second highest salary using self-join.
     
     with result as(select employee_id,first_name,salary,DENSE_RANK() over (order by salary desc) as n from employees)
     select * from result where n=2
     

     select e.employee_id,e.first_name,e.salary
     from employees E  join employees F 
     on E.employee_id=F.employee_id
     order by E.salary DESC
     OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY; 
     


--Q6. Write a query to show count of employees under each manager in descending order.
     select E.manager_id, count(e.employee_id) AS reporting_employees
     from employees E  Join  departments D 
     on E.department_id=D.department_id
     where E.Manager_id is not null
     group by E.manager_id
     order by reporting_employees desc
     
      

--Q7. Write a stored procedure to get the names (first name, last name), salary, 
--PF of all the employees (PF is calculated as 15% of the salary)
   
 CREATE OR ALTER PROCEDURE PF
AS 
BEGIN
select employee_id,first_name,salary,(salary*0.15) as PF,
(salary+(salary*0.15)) as Total_Salary from employees 
END
exec PF


----------------

---Q8. Write a query to fetch details of all employees
-------excluding the employees hired between the year 1998 to 2000.
  select * from employees
  where hire_date  not between '1998-01-01' and '2000-12-31'


---Q9. Using subquery find the name (first_name, last_name) 
--of all employees who works in the IT department.
    
    select first_name , last_name, department_id from employees where department_id=
    (select department_id from departments where department_name='IT')

--Q10. Write a query to retrieve the last 3 records from the Employee table.

select top 3 * from employees order by employee_id desc


-----------------------------------------------------------



--Q1) find all departments located at the location whose id is 1700

select * from employees where department_id in
(select  department_id from departments where location_id = 1700)

--Q2)find all employees that belong to the location 1700 by using the department id list of the first query

select * from employees where department_id  in ( select department_id from departments where location_id = 1700)

--Q3) count find employees who locate in a different location.  
select query.department_id,query.location_id,count(E.employee_id) Employee_Count
from employees E
inner join (select location_id,department_id from departments) query
on e.department_id=query.department_id
group by query.department_id,query.location_id
order by location_id asc



--Q4)find all employees who do not locate at the location 1700 using not in operator.
select * from employees where department_id not  in ( select department_id from departments where location_id = 1700)

--Q5)finds the employees who have the (n-1)th highest salary

 
with result as(select *, DENSE_RANK() over (order by salary desc)as n from employees) select * from result where n=2
   


--Q6)finds all employees who salaries are greater than the average salary of all employees.
 
 select *  from employees where salary >=
     (select avg(salary) from employees)

--Q7) finds all departments which have at least one employee with the salary is greater than 10,000

   
select d.department_id, d.department_name, employee_count
from departments d
inner join (
    select department_id, count(employee_id) as employee_count
    from employees
    where salary > 10000
    group by department_id
) query on d.department_id = query.department_id

--Q8) finds all departments that do not have any employee with the salary greater than 10,000


select d.department_id, d.department_name, employee_count
from departments d
inner join (
    select department_id, count(employee_id) as employee_count
    from employees
    where salary < 10000
    group by department_id
) query on d.department_id = query.department_id

--Q9) find the lowest salary by department

select distinct(E.department_id),Min_Salary,Department_wise_employee_count
from employees E
inner join 
(select department_id,min(salary)  as Min_Salary, count(employee_id) as Department_wise_employee_count
from employees G group by department_id) query
on E.department_id=query.department_id


--Q11)  calculate the average of average salary of departments
   select e.department_id,avg_salary
   from employees e
  inner join (select department_id,avg(Salary) as avg_salary from employees group by department_id) query
  on e.department_id=query.department_id

--Q12) finds the salaries of all employees, their average salary, 
---and the difference between the salary of each employee and the average salary
select e.employee_id,e.salary,Difference_Salary,AVG_Salary 
from employees e
inner join (select employee_id,salary,(lead(salary) over (order by salary)- salary) as Difference_Salary, avg(salary) over (order by salary) as AVG_Salary
from employees) query
on e.employee_id=query.employee_id


--Q10) finds all employees whose salaries are greater than the lowest salary of every department

SELECT E.first_name,e.last_name, E.Salary,E.department_id FROM employees E WHERE E.Salary > ALL ( SELECT MIN(Salary)
    FROM employees
    WHERE department_id = E.department_id
)
order by E.department_id desc


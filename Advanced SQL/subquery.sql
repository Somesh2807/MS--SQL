select name
from sys.tables

use Rise

select * from employee
select * from EMPLOYEE_DETAILS

alter table EMPLOYEE_DETAILS add Experience int

create table dept_name(
dep_id int,
dep_name nvarchar(50),
HOD nvarchar(50),
[location] nvarchar(50)
)

CREATE TABLE [dbo].[EMPLOYEE_DETAILS] (
    [EMP_ID]     INT           NULL,
    [FIRST_NAME] NVARCHAR (30) NULL,
    [LAST_NAME]  NVARCHAR (30) NULL,
    [SALARY]     MONEY         NULL,
    [DOJ]        DATE          NULL,
    [DEPT]       NVARCHAR (30) NULL,
    [GENDER]     NVARCHAR (7)  NULL,
    [Dep_ID]     INT           NULL,
    [Experience] INT           NULL
);



select * from EMPLOYEE_DETAILS
select * from dept_name 

 select * from EMPLOYEE_DETAILS where  in (select [location] from dept_name where [location]='Vadodara')




SELECT * FROM EMPLOYEE_DETAILS
WHERE Experience > 4 AND salary > 4000 AND DEPT = 'DA' AND Dep_ID IN 
( SELECT dep_id FROM dept_name WHERE location = 'Vadodara');


----List all employees who have a salary greater than the average salary in the company.
select * from EMPLOYEE_DETAILS where DEPT = 'DA' and SALARY >(select AVG(SALARY) from EMPLOYEE_DETAILS ) 

-- Find the department(s) with the highest number of employees.
SELECT dep_name
FROM dept_name
WHERE dep_id = (
    SELECT TOP 1 dep_id
    FROM EMPLOYEE_DETAILS
    GROUP BY dep_id
    ORDER BY COUNT(*) DESC
)
----Retrieve the names of employees who have the same department as 'John Doe'
---(assuming you have a 'John Doe' employee in your data).

select FIRST_NAME,LAST_NAME,DEPT
from EMPLOYEE_DETAILS where DEPT = 
(select DEPT from EMPLOYEE_DETAILS where FIRST_NAME = 'John' and LAST_NAME = 'Doe')

---Find employees who have more experience than the average experience in their department.

select *
from EMPLOYEE_DETAILS E where Experience >(select AVG(Experience) from EMPLOYEE_DETAILS where DEPT =E.DEPT)


--Retrieve the department(s) with the highest total salary expense.


select DEPT ,sum(salary)as Salary  from EMPLOYEE_DETAILS group by DEPT order by Salary desc

---
select * from EMPLOYEE_DETAILS
select * from dept_name 

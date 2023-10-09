create database windows_function

use windows_function

--- Windows Function

select * from rise.dbo.employee


UPDATE rise.dbo.employee 
SET Gender = 'FeMale' 
WHERE id BETWEEN 6 AND 7;

select first_name,last_name,Gender,
count(Gender) over (partition  by Gender)  as Gender_total
,min(salary) over (partition by gender) as Min_salary
,max(salary) over (partition by gender) as max_Salary
from rise.dbo.employee
order by first_name asc





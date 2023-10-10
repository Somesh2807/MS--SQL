create database windows_function

use windows_function

--- Windows Function

select * from rise.dbo.employee


UPDATE rise.dbo.employee 
SET Gender = 'FeMale' 
WHERE id BETWEEN 6 AND 7;

select first_name,last_name,Gender,
count(Gender) over (partition  by Gender order by Gender asc)  as Gender_total
,min(salary) over (partition by gender order by Gender asc) as Min_salary
,max(salary) over (partition by gender order by Gender asc) as max_Salary
from rise.dbo.employee





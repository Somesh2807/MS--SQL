--- Database created
create database worker
--Entered in Database
use worker
--- Create Table Name Emp_Details
create table Emp_Details(
Emp_Id int identity(100,1) primary key,
First_Name Nvarchar(20),
Last_Name Nvarchar(20),
Email_ID nvarchar(50),
Contact_No bigint,
Department Nvarchar(20), 
D_O_B Date,
Salary money
);

-- Please refer Attached CSV file, By using bulk insert we can insert lakhss of Line-item in Just singles shot.

bulk insert Emp_Details from 'D:\database.csv' with (FORMAT ='CSV', firstrow = 2 , FIELDTERMINATOR = ',',rowterminator ='\n');

--To check Schema of Table
sp_help Emp_Details

-- To check Inserted data into Table
select * from Emp_Details

1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>

--There is a duplicate data. So here we have used Distinct to remove duplicate.
select Distinct First_Name as Worker_name from Emp_Details order by Worker_name asc

2.Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.

select Distinct Upper(First_Name) as Worker_name from Emp_Details order by Worker_name asc

3.Write an SQL query to fetch unique values of DEPARTMENT from Worker table.

select distinct Department from Emp_Details;

4. Write an SQL query to print the first three characters of FIRST_NAME from Worker table.

 select Distinct left(First_Name,3) as Name from Emp_Details 

5. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length

select distinct department, len(Department) as Length from Emp_Details 

6.Write an SQL query to show the current date and time.

select getdate() as Date_Time

7.Write an SQL query to show the top n (say 10) records of a table.

select top 10 * from Emp_Details

8.Write an SQL query to print the name of employees having 
the highest salary in each department.

SELECT W.Department, W.First_Name, W.Last_Name, W.Salary
FROM Emp_Details W
JOIN (
    SELECT Department, max(Salary) AS max_salary
    FROM Emp_Details
    GROUP BY Department
) maxsalaries ON W.Department = maxsalaries.Department AND W.Salary = maxsalaries.max_salary
order by salary desc








SELECT First_Name department, MAX(salary) AS max_salary
    FROM Emp_Details
    GROUP BY department

	select First_Name, Department ,max(salary) as Salary
	from Emp_Details 
	group by Department



	select * from Emp_Details
SELECT Department, First_Name, Salary
FROM Emp_Details
WHERE Department = (
    SELECT MAX(Salary)
    FROM Emp_Details
    WHERE Department = Department);


	select * from Emp_Details
	--- Creating Index 
	create index Emp_Dep on Emp_Details (Emp_id,Department)
	--To view structire of index
	
	sp_helpindex Emp_Details

	sp_help Emp_Details

	create unique index Emp_mail on Emp_details(Email_id)

	-- Cluster Table. If table already had a primary key. Then cluster is not possible

	create clustered index First12 on Emp_Details(First_Name)


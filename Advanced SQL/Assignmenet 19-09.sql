USE Rise

--CREATE TABLE EMPLOYEE DETAIL AND PROJECT DETAIL

CREATE TABLE EMPLOYEE_DETAILS(
EMP_ID INT,
FIRST_NAME NVARCHAR(30),
LAST_NAME NVARCHAR(30),
SALARY MONEY,
DOJ DATE,
DEPT NVARCHAR(30),
GENDER NVARCHAR(7)
)

CREATE TABLE PROJECT_DETAIL(
PROJECT_ID INT,
EMP_ID INT,
PROJECT_NAME NVARCHAR(30)
)

---INSERT DATA INTO EMPLOYEE DETAILS

INSERT INTO EMPLOYEE_DETAILS (EMP_ID, FIRST_NAME , LAST_NAME , SALARY , DOJ , DEPT ,GENDER ) VALUES 
(1, 'Pradeep', 'Rana', 50000, '2023-09-19', '.Net', 'Male'),
(2, 'Kinjal', 'Parmar', 60000, '2023-09-20', 'NodeJs', 'Female'),
(3, 'Somesh', 'Jatav', 55000, '2023-09-21', 'DA', 'Male'),
(4, 'Dhruvesh', 'Godavalse', 52000, '2023-09-22', 'JAVA', 'Male'),
(5, 'Komal', 'Rana', 55000, '2023-09-25', 'IT', 'Female'),
(6, 'Ajay', 'Rana', NULL, '2023-09-26', 'Finance', 'Male'),
(7, 'Meshva', 'Parmar', 51000, NULL, 'Marketing', 'Female'),
(8, 'Vishal', 'Parmar', 48000, '2023-09-27', NULL, 'Male');


INSERT INTO PROJECT_DETAIL ( PROJECT_ID, EMP_ID , PROJECT_NAME ) VALUES
(1, 1, 'HR Management'),
(2, 2, 'Financial Analysis'),
(3, 3, 'Database Migration'),
(4, 4, 'Marketing Campaign'),
(5, 1, 'Employee Training'),
(6, 7, 'Database Maintenance'),
(7, 8, NULL),
(8, 9, 'Sales Analysis'),
(9, 10, 'Customer Relations'),
(10, 11, 'Product Development'),
(11, NULL, 'Internal Training');


---1.Retrieve employee name, project name order by first name from 
--"Employee Details" and "Project Detail" for those employees which have assigned project already.

SELECT E.EMP_ID,E.FIRST_NAME,E.LAST_NAME, E.SALARY,P.PROJECT_NAME 
FROM EMPLOYEE_DETAILS E
INNER JOIN PROJECT_DETAIL P ON E.EMP_ID=P.EMP_ID
WHERE P.PROJECT_NAME IS NOT NULL
ORDER BY E.FIRST_NAME ASC

--2.	Retrieve employee name, project name order by first name from " Employee Details " and "Project Detail" 
---for all employee even they have not assigned project.

SELECT E.EMP_ID,E.FIRST_NAME,E.LAST_NAME,P.PROJECT_NAME
FROM EMPLOYEE_DETAILS E
LEFT JOIN PROJECT_DETAIL P ON E.EMP_ID=P.EMP_ID
ORDER BY E.FIRST_NAME ASC

--3.Retrieve employee name, project name order by first name from " Employee Details " and "Project Detail"
-----for all employee if project is not assigned then display "-No Project Assigned.”

SELECT E.FIRST_NAME, E.LAST_NAME, COALESCE(P.PROJECT_NAME, '-No Project Assigned') AS PROJECT_NAME
FROM EMPLOYEE_DETAILS E
LEFT JOIN PROJECT_DETAIL P ON E.EMP_ID=P.EMP_ID
ORDER BY E.FIRST_NAME

--4.Retrieve all project name even they have not matched any empID, 
---in left table, order by first name from " Employee Details " and "Project Detail".

SELECT E.FIRST_NAME AS EMPLOYEE_NAME, 
COALESCE(P.PROJECT_NAME, 'No Project Assigned') AS PROJECT_NAME
FROM EMPLOYEE_DETAILS E
LEFT JOIN PROJECT_DETAIL P ON E.EMP_ID=P.EMP_ID
UNION ALL
SELECT NULL AS EMPLOYEE_NAME,
PROJECT_NAME FROM PROJECT_DETAIL
WHERE EMP_ID IS NULL	ORDER BY
EMPLOYEE_NAME, PROJECT_NAME;

--5)Retrieve complete record (employee name, project name) from both tables 
---([Employee Detail], [Project Detail]), if no match found in any table, then show NULL.

SELECT 
COALESCE(E.FIRST_NAME  , 'NULL') AS EMPLOYEE_NAME,
COALESCE(P.PROJECT_NAME, 'NULL') AS PROJECT_NAME
FROM EMPLOYEE_DETAILS E
FULL OUTER JOIN PROJECT_DETAIL P ON E.EMP_ID=P.EMP_ID

--6)Write a query to find out the employee’s name who has not assigned any project, 
---and display "-No Project Assigned” (tables: - [Employee Detail], [Project Detail])

SELECT E.FIRST_NAME, COALESCE(P.PROJECT_NAME, '-No Project Assigned') AS PROJECT_NAME
FROM EMPLOYEE_DETAILS E
LEFT JOIN PROJECT_DETAIL P ON E.EMP_ID=P.EMP_ID
Where P.EMP_ID is null
ORDER BY E.FIRST_NAME

--7)Write a query to find out the project name which is not assigned to any employee 
---(tables: - [Employee Detail], [Project Detail]

SELECT P.PROJECT_NAME
FROM PROJECT_DETAIL P
LEFT JOIN EMPLOYEE_DETAILS E ON E.EMP_ID=P.EMP_ID
WHERE E.EMP_ID IS NULL;

--8)Write down the query to fetch EmployeeName & Project who has assign more than one project	

SELECT E.FIRST_NAME AS EMPLOYEE_NAME, P.PROJECT_NAME AS PROJECT_NAME,
COUNT(P.PROJECT_NAME) AS PROJECT_COUNT
FROM EMPLOYEE_DETAILS E
JOIN
(
    SELECT EMP_ID FROM PROJECT_DETAIL GROUP BY EMP_ID
    HAVING COUNT(*) > 1
)	
AS EMP_WITH_MULTIPLE_PROJECT
ON E.EMP_ID = EMP_WITH_MULTIPLE_PROJECT.EMP_ID
JOIN PROJECT_DETAIL P
ON E.EMP_ID = P.EMP_ID
GROUP BY E.FIRST_NAME, P.PROJECT_NAME
ORDER BY EMPLOYEE_NAME, PROJECT_NAME



--9)Write down the query to fetch Project Name on which more than one employee are working along with Employee Name

SELECT E.FIRST_NAME AS EMPLOYEE_NAME, P.PROJECT_NAME AS PROJECT
FROM EMPLOYEE_DETAILS E
JOIN PROJECT_DETAIL P ON E.EMP_ID=P.PROJECT_ID
GROUP BY P.PROJECT_NAME, E.FIRST_NAME
HAVING COUNT(E.FIRST_NAME) > 1;


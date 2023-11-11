-- Select the names of tables in the current database with database_ID greater than 4
SELECT name
FROM sys.tables
WHERE database_ID > 4;

-- Create table "Emp"
CREATE TABLE Emp (
    Emp_ID NVARCHAR(10),
    Emp_Name NVARCHAR(50),
    Salary MONEY,
    Dep_ID NVARCHAR(10),
    Manager_ID NVARCHAR(10)
);

-- Add a column "DOJ" to the "Emp" table
ALTER TABLE Emp ADD DOJ DATE;

-- Drop the column "Manager_ID" from the "Emp" table
ALTER TABLE Emp DROP COLUMN Manager_ID;

-- Insert data into the "Emp" table
INSERT INTO Emp VALUES ('E1', 'Suresh', 20000, 'D1', NULL), ('E2', 'Mahesh', 30000, 'D2', NULL),
                      ('E3', 'Ramesh', 30000, 'D3', NULL), ('E4', 'Kamlesh', 35000, 'D4', NULL);

-- Create table "Manager"
CREATE TABLE Manager (
    Manager_ID NVARCHAR(10),
    M_Name NVARCHAR(30),
    Dep_ID NVARCHAR(10)
);

-- Insert data into the "Manager" table
INSERT INTO Manager VALUES ('M1', 'John', 'D2'), ('M2', 'May', 'D3'), ('M3', 'Harry', 'D1');

-- Create table "Project"
CREATE TABLE Project (
    P_ID NVARCHAR(10),
    P_Name NVARCHAR(20),
    Emp_ID NVARCHAR(10)
);

-- Insert data into the "Project" table
INSERT INTO Project VALUES ('P1', 'Data Migration', 'E1'), ('P2', 'Data Migration', 'E2'), ('P3', 'ETL', 'E3');

-- Create table "Department"
CREATE TABLE Department (
    Dep_ID NVARCHAR(10),
    D_Name NVARCHAR(30)
);

-- Insert data into the "Department" table
INSERT INTO Department VALUES ('D1', 'IT'), ('D2', 'HR'), ('D3', 'BD');

-- Fetch department details and their managers
SELECT D.Dep_ID, M.Manager_ID, D.D_Name, M.M_Name
FROM Department D
LEFT JOIN Manager M ON M.Dep_ID = D.Dep_ID;

-- Fetch employee names and their respective departments
SELECT E.Emp_Name, D.D_Name
FROM Emp E
INNER JOIN Department D ON E.Dep_ID = D.Dep_ID;

-- Fetch details of all employees, their departments, managers, and projects
SELECT E.Emp_ID, D.Dep_ID, P.P_Name, E.Emp_Name
FROM Emp E
LEFT JOIN Department D ON E.Dep_ID = D.Dep_ID
LEFT JOIN Project P ON E.Emp_ID = P.Emp_ID
WHERE P.P_Name IS NOT NULL;

-- Fetch list of employees working under Manager 'John'
SELECT E.Emp_ID, E.Emp_Name, D.D_Name, P.P_Name
FROM Emp E
LEFT JOIN Department D ON E.Dep_ID = D.Dep_ID
LEFT JOIN Project P ON E.Emp_ID = P.Emp_ID
LEFT JOIN Manager M ON E.Manager_ID = M.Manager_ID
WHERE M.M_Name = 'John';

-- Fetch list of employees who don't belong to any department
SELECT E.Emp_ID, E.Emp_Name, D.D_Name, P.P_Name
FROM Emp E
LEFT JOIN Department D ON E.Dep_ID = D.Dep_ID
LEFT JOIN Project P ON E.Emp_ID = P.Emp_ID
WHERE D.D_Name IS NULL;

-- Create table "Emp_table"
CREATE TABLE Emp_table (
    Emp_ID NVARCHAR(30)
);

-- Fetch all records from tables "Emp" and "Department"
SELECT * FROM Emp;
SELECT * FROM Department;

-- Find the second highest salary
SELECT TOP 1 Emp_Name, Salary
FROM Emp
WHERE Salary < (SELECT MAX(Salary) FROM Emp)
ORDER BY Salary DESC;

-- Find employee details having the max salary in his/her department
SELECT E.Emp_ID, E.Emp_Name, E.Salary, E.Dep_ID, D.D_Name
FROM Emp E
JOIN Department D ON E.Dep_ID = D.Dep_ID;

SELECT E.Emp_ID, E.Emp_Name, D.D_Name AS Dep_ID, E.Salary
FROM Emp E
JOIN (
    SELECT Dep_ID, MAX(Salary) AS max_salary
    FROM Emp
    GROUP BY Dep_ID
) emax ON E.Dep_ID = emax.Dep_ID AND E.Salary = emax.max_salary
JOIN Department D ON E.Dep_ID = D.Dep_ID
ORDER BY E.Salary DESC;

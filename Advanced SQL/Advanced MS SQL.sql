-- Create Store procedure in MS SQL

-- Display the table names in the 'rise' database
USE rise
SELECT name AS Table_Name
FROM sys.tables

-- Display information about the 'BoardingPass' table
SELECT *
FROM BoardingPass
EXEC sp_help BoardingPass

-- Create a simple stored procedure named 'sp_name'
CREATE PROCEDURE sp_name
AS
BEGIN
    SELECT *
    FROM BoardingPass
END

-- Drop the stored procedure 'sp_name'
DROP PROCEDURE sp_name

-- Execute the stored procedure 'sp_name' with parameters
EXEC sp_name '@tid= b1', '@class= Business Class'

-- Create a table named 'employee'
CREATE TABLE employee
(
    id         INTEGER NOT NULL PRIMARY KEY,
    first_name VARCHAR(10),
    last_name  VARCHAR(10),
    salary     DECIMAL(10, 2),
    city       VARCHAR(20)
)

-- Insert data into the 'employee' table
INSERT INTO employee
VALUES (2, 'Monu', 'Rathor', 4789, 'Agra')

INSERT INTO employee
VALUES (4, 'Rahul', 'Saxena', 5567, 'London')

INSERT INTO employee
VALUES (5, 'prabhat', 'kumar', 4467, 'Bombay')

INSERT INTO employee
VALUES (6, 'ramu', 'kksingh', 3456, 'jk')

-- Select all records from the 'employee' table
SELECT *
FROM employee

-- Create a stored procedure with a subquery
CREATE PROCEDURE SP_Name_Salary
AS
BEGIN
    SELECT first_name, last_name
    FROM employee
    WHERE salary > (SELECT AVG(salary) FROM employee)
END

-- Select all records from the 'employee' table
SELECT *
FROM employee

-- Execute the stored procedure 'SP_Name_Salary'
EXEC SP_Name_Salary

-- Create a stored procedure 'SP_COunt' to count the number of employees
CREATE PROCEDURE SP_COunt
    @empcount INT OUT
AS
BEGIN
    SELECT @empcount = COUNT(*)
    FROM employee
END

-- Declare a variable and execute the 'SP_COunt' stored procedure
DECLARE @totalcount INT
EXEC SP_COunt @empcount = @totalcount OUT
PRINT @totalcount

-- Create tables 'account' and 'Transaction'
CREATE TABLE account
(
    AC_No      INT PRIMARY KEY,
    AC_Name    NVARCHAR(50),
    AC_Type    NVARCHAR(10),
    Branch     NVARCHAR(50),
    AC_Balance MONEY
)

CREATE TABLE Transcation
(
    AC_No          INT,
    AC_Name        NVARCHAR(50),
    Transaction_ID INT IDENTITY(78975, 59),
    Debit          MONEY,
    Credit         MONEY,
    Date           NVARCHAR(50) DEFAULT SYSDATETIME()
)

-- Drop the 'Transcation' table
DROP TABLE Transcation

-- Select records from 'Transcation' and 'account' tables
SELECT *
FROM Transcation

SELECT *
FROM account

-- Add a foreign key constraint to the 'Transcation' table
ALTER TABLE Transcation ADD CONSTRAINT FK_TR_NO FOREIGN KEY (AC_No)
REFERENCES account (AC_No) ON UPDATE CASCADE

-- Display information about the 'account' and 'Transcation' tables
EXEC sp_help account
EXEC sp_help Transcation

-- Create a stored procedure 'credit' for crediting an account
CREATE PROCEDURE credit
    @AC_No  INT,
    @AC_Name NVARCHAR(50),
    @credit  MONEY
AS
BEGIN
    INSERT INTO Transcation (AC_No, AC_Name, Credit)
    VALUES (@AC_No, @AC_Name, @credit)

    UPDATE account
    SET AC_Balance = @credit + AC_Balance
    WHERE AC_No = @AC_No
END

-- Query to run the 'credit' command
EXEC credit @AC_No = 200200126, @credit = 550000, @AC_Name = 'Kinjal'

-- Create a stored procedure 'debit' for debiting an account
CREATE PROCEDURE debit
    @AC_No  INT,
    @AC_Name NVARCHAR(50),
    @debit   MONEY
AS
BEGIN
    DECLARE @AC_Balance MONEY

    SELECT @AC_Balance = AC_Balance
    FROM Account
    WHERE AC_No = @AC_No

    IF @AC_Balance >= @debit
    BEGIN
        INSERT INTO Transcation (AC_No, AC_Name, Debit)
        VALUES (@AC_No, @AC_Name, @debit)

        UPDATE account
        SET AC_Balance = AC_Balance - @debit
        WHERE AC_No = @AC_No

        PRINT 'Debit transaction successfully done'
    END
    ELSE
    BEGIN
        PRINT 'Transaction failed due to insufficient balance in your account'
    END
END

-- Query to run the 'debit' command
EXEC debit @AC_No = 200200125, @AC_Name = 'Hiral', @debit = 78052.00

-- Select records from 'account' and 'Transcation' tables
SELECT * FROM account

SELECT * FROM Transcation

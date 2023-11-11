-- Create a database named 'ppt'
CREATE DATABASE ppt;

-- Switch to the 'ppt' database
USE ppt;

-- Select table names from 'sys.tables'
SELECT name
FROM sys.tables;

-- Bulk insert data from 'table1.csv' into Table1
BULK INSERT Table1 FROM 'D:\New folder\table1.csv' WITH (FORMAT = 'CSV', ROWTERMINATOR = '\n', FIRSTROW = 2, FIELDTERMINATOR = ',');

-- Bulk insert data from 'table2.csv' into Table2
BULK INSERT Table2 FROM 'D:\New folder\table2.csv' WITH (FORMAT = 'CSV', ROWTERMINATOR = '\n', FIRSTROW = 2, FIELDTERMINATOR = ',');

-- Select all data from Table1
SELECT * FROM Table1;

-- Select all data from Table2
SELECT * FROM Table2;

-- Left Join: Retrieve data from Table1 and Table2 based on Enrolment_ID
SELECT A.Enrolment_ID, B.Name, B.Obtained_Marks
FROM Table1 A
LEFT JOIN Table2 B ON A.Enrolment_ID = B.Enrolment_ID;

-- Left Outer Join: Retrieve data from Table1 and Table2 where Enrolment_ID is null in Table2
SELECT A.Enrolment_ID, B.Name, B.Obtained_Marks
FROM Table1 A
LEFT JOIN Table2 B ON A.Enrolment_ID = B.Enrolment_ID
WHERE B.Enrolment_ID IS NULL;

-- Right Join: Retrieve data from Table1 and Table2 based on Enrolment_ID
SELECT A.Enrolment_ID, B.Name, B.Obtained_Marks
FROM Table1 A
RIGHT JOIN Table2 B ON A.Enrolment_ID = B.Enrolment_ID;

-- Right Outer Join: Retrieve data from Table1 and Table2 where Enrolment_ID is null in Table1
SELECT A.Enrolment_ID, B.Name, B.Obtained_Marks
FROM Table1 A
RIGHT JOIN Table2 B ON A.Enrolment_ID = B.Enrolment_ID
WHERE A.Enrolment_ID IS NULL;

-- Full Outer Join: Retrieve data from Table1 and Table2 based on Enrolment_ID
SELECT A.Enrolment_ID, B.Name, B.Obtained_Marks
FROM Table1 A
FULL OUTER JOIN Table2 B ON A.Enrolment_ID = B.Enrolment_ID;

-- Full Join: Retrieve data from Table1 and Table2 based on Enrolment_ID
SELECT A.Enrolment_ID, B.Name, B.Obtained_Marks
FROM Table1 A
FULL JOIN Table2 B ON A.Enrolment_ID = B.Enrolment_ID;

-- Inner Join: Retrieve data from Table1 and Table2 based on Enrolment_ID
SELECT A.Enrolment_ID, B.Name, B.Obtained_Marks
FROM Table1 A
INNER JOIN Table2 B ON A.Enrolment_ID = B.Enrolment_ID;

-- Create a table 'Boarding_Pass' to store boarding pass information
CREATE TABLE Boarding_Pass (
    Ticket_ID INT,
    Name NVARCHAR(50),
    Seat_No INT,
    Class NVARCHAR(50)
);

-- Bulk insert data from 'Seats.csv' into the 'Seats' table
BULK INSERT Seats FROM 'D:\New folder\Seats.csv' WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FORMAT = 'CSV', FIRSTROW = 2);

-- Create a table 'Ticket_No' to store ticket numbers
CREATE TABLE Ticket_No (
    Ticket_ID INT,
    Seat_No INT
);

-- Create a table 'Seats' to store seat information
CREATE TABLE Seats (
    Ticket_ID INT,
    Seat_No INT,
    Class NVARCHAR(50)
);

-- Select all data from 'Seats'
SELECT * FROM Seats;

-- Select all data from 'Ticket_No'
SELECT * FROM Ticket_No;

-- Select all data from 'Boarding_Pass'
SELECT * FROM Boarding_Pass;

-- Retrieve a list of ticket classes and their count where no boarding pass exists
SELECT B.Class, COUNT(*) AS Ticket_Count
FROM Boarding_Pass B
JOIN Seats S ON S.Ticket_ID = B.Ticket_ID
GROUP BY S.Class, B.Class;

-- Retrieve ticket IDs from 'Ticket_No' where no corresponding boarding pass exists
SELECT B.Ticket_ID, T.Ticket_ID
FROM Ticket_No T
RIGHT JOIN Boarding_Pass B ON T.Ticket_ID = B.Ticket_ID
WHERE B.Ticket_ID IS NULL;

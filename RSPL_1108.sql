-- Create the "rise2023" database and switch to it
CREATE DATABASE rise2023;
USE rise2023;

-- Create the "interns" table
CREATE TABLE interns (
    id NVARCHAR(10),
    name NVARCHAR(20),
    department NVARCHAR(20),
    email_id NVARCHAR(50)
);

-- Insert data into the "interns" table
INSERT INTO interns VALUES (1, 'somesh_singh', 'Data Analytics', 'somesh8200@outlook.com');
INSERT INTO interns VALUES (2, 'Happin', 'Data Analytics', 'happin28@outlook.com');
INSERT INTO interns VALUES (1, 'somesh', 'Data Analytics', 'somesh28071997@outlook.com');
INSERT INTO interns VALUES (3, 'Aman', 'Data Analytics', 'aman@outlook.com');

-- Select all records from the "interns" table
SELECT * FROM interns;

-- Rename the table from "emptbl" to "emp1"
EXEC sp_rename 'emptbl', 'emp1';

-- Rename the column from "empt1" to "emp2"
EXEC sp_rename 'emp1.empt1', 'emp2';

-- Alter the table name from "rise2023.table.emp1" to "rise2023.table.emp2"
ALTER TABLE rise2023.table.emp1 RENAME TO emp2;

-- Display information about the "emp1" table
EXEC sp_help 'emp1';

-- Truncate the "emp1" table
TRUNCATE TABLE emp1;

-- Transfer the "emp1" table to the "rise2023" schema
ALTER SCHEMA rise2023 TRANSFER emp1.emp2;

-- Create the "temp" database and switch to it
CREATE DATABASE temp;
USE temp;

-- Create the "employee" table
CREATE TABLE employee (
    emp_id INT NOT NULL,
    emp_name NVARCHAR(20),
    contact_number INT UNIQUE,
    dep_id NVARCHAR(20)
);

-- Select all records from the "employee" table
SELECT * FROM employee;

-- Add the "DOB" column to the "employee" table
ALTER TABLE employee ADD DOB DATE;

-- Insert data into the "employee" table
INSERT INTO employee VALUES (25, 'somesh', 8258, 'timesheet');
INSERT INTO employee VALUES (27, 'somesh singh', 8200, 'timesheet');

-- Display information about the "employee" table
EXEC sp_help employee;

-- Drop the "DOB" column from the "employee" table
ALTER TABLE employee DROP COLUMN DOB;

-- Delete a record from the "employee" table
DELETE FROM employee WHERE emp_id = 25;

-- Update the "emp_id" in the "employee" table
UPDATE employee SET emp_id = 28 WHERE contact_number = 8200;

-- Update the "contact_number" in the "employee" table
UPDATE employee SET contact_number = 9897 WHERE emp_id = 28;

-- Update the "emp_name" and "contact_number" in the "employee" table
UPDATE employee SET emp_name = 'vineeta singh', contact_number = 28287 WHERE emp_id = 28;

-- Select all records from the "employee" table
SELECT * FROM employee;

-- Switch back to the "rise2023" database
USE rise2023;

-- Select all records from the "emp1" table
SELECT * FROM emp1;

-- Update the "empid" in the "emp1" table
UPDATE emp1 SET empid = 0 WHERE empid = 1;

-- Delete a record from the "emp1" table
DELETE FROM emp1 WHERE empid = 0;

-- Select the "name" from the "sys.databases" where "database_id" > 4
SELECT name FROM sys.databases WHERE database_id > 4;

-- Switch to the "name" database and select its name
USE name;
SELECT name FROM sys.tables;

-- Select all records from the "emp1" table
SELECT * FROM emp1;

-- Select the "empid" and "email_id" from the "emp1" table
SELECT empid, email_id FROM emp1 WHERE empid = 2;

-- Delete a record from the "emp1" table where "empid" is 2
DELETE FROM emp1 WHERE empid = 2;

-- Select the "name" from the "sys.tables"
SELECT name FROM sys.tables;

-- Drop the "emp1" and "empid" tables
DROP TABLE emp1, empid;

-- Select the "name" from the "sys.databases" where "database_id" > 4
SELECT name FROM sys.databases WHERE database_id > 4;

-- Switch to the "rise2023" database and drop the "temp" database
USE rise2023;
DROP DATABASE temp;

-- Drop the "rise2023" and "practice" databases
DROP DATABASE rise2023, practice;

-- Create the "bank" database and switch to it
CREATE DATABASE bank;
USE bank;

-- Create the "ssbank" database and switch to it
CREATE DATABASE ssbank;
USE ssbank;

-- Drop the "bank" database
DROP DATABASE bank;

-- Create the "sales" database and switch to it
CREATE DATABASE sales;
USE sales;

-- Drop the "ssbank" database
DROP DATABASE ssbank;

-- Create the "infosys" database and switch to it
CREATE DATABASE infosys;
USE infosys;

-- Drop the "sales" database
DROP DATABASE sales;

-- Drop the "infosys" database
DROP DATABASE infosys;

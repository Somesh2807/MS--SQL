-- Create the "practice" database and switch to it
CREATE DATABASE practice;
USE practice;

-- Create the "sales" table
CREATE TABLE sales (
    Emp_Name NVARCHAR(50),
    City_ID INT PRIMARY KEY,
    Sales MONEY
);

-- Display all records from the "sales" table, along with the "country" table (cross join)
SELECT * FROM sales, country;

-- Display all records from the "city" table
SELECT * FROM city;

-- Create the "City" table
CREATE TABLE City (
    City_ID INT,
    City NVARCHAR(50),
    Country_ID INT
);

-- Create the "Country" table
CREATE TABLE Country (
    Country_ID INT PRIMARY KEY,
    Country_Name NVARCHAR(50)
);

-- Add a foreign key constraint to the "City" table referencing the "Country" table
ALTER TABLE City
ADD CONSTRAINT FK_Country_ID FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
ON DELETE CASCADE ON UPDATE CASCADE;

-- List of employees and the countries they belong to
SELECT s.Emp_Name, e.Country_Name
FROM sales s
FULL JOIN City c ON s.City_ID = c.City_ID
FULL JOIN Country e ON c.Country_ID = e.Country_ID;

-- List of employee details who belong only to India or US
SELECT s.Emp_Name, e.Country_Name
FROM sales s
JOIN City c ON s.City_ID = c.City_ID
JOIN Country e ON c.Country_ID = e.Country_ID
WHERE e.Country_Name = 'India' OR e.Country_Name = 'US';

-- Create a new database named "Rise"
CREATE DATABASE Rise;
-- Use the "Rise" database
USE RISE;
-- Go to the next batch of statements

-- Create table "BoardingPass"
CREATE TABLE BoardingPass (
    Tid NVARCHAR(5),
    Name NVARCHAR(20),
    Seat NVARCHAR(10),
    Class NVARCHAR(20)
);

-- Create table "TicketNo"
CREATE TABLE TicketNo (
    Tid NVARCHAR(5),
    Seat NVARCHAR(10)
);

-- Create table "Seats"
CREATE TABLE Seats (
    Tid NVARCHAR(5),
    Seat NVARCHAR(10),
    Class NVARCHAR(20)
);

-- Insert data into "BoardingPass"
INSERT INTO BoardingPass VALUES ('B1', 'Aman', 'S1', 'Business Class');
INSERT INTO BoardingPass VALUES ('B2', 'Dhruvesh', 'S3', 'General Class');
INSERT INTO BoardingPass (Tid, Name) VALUES ('B3', 'Meshva');
INSERT INTO BoardingPass VALUES ('B4', 'Jignesh', 'S6', 'Semi-Eco Class');
INSERT INTO BoardingPass (Tid, Name) VALUES ('B5', 'Vishal');

-- Select all records from "BoardingPass"
SELECT * FROM BoardingPass;

-- Select all records from "TicketNo"
SELECT * FROM TicketNo;

-- Select all records from "Seats"
SELECT * FROM Seats;

-- Insert data into "TicketNo"
INSERT INTO TicketNo VALUES ('B1', 'S1');
INSERT INTO TicketNo VALUES ('B2', 'S2');
INSERT INTO TicketNo VALUES ('B3', 'S5');
INSERT INTO TicketNo VALUES ('B6', 'S7');
INSERT INTO TicketNo VALUES ('B7', 'S9');

-- Insert data into "Seats"
INSERT INTO Seats VALUES ('B1', 'S1', 'Business Class');
INSERT INTO Seats VALUES ('B4', 'S5', 'Economy Class');
INSERT INTO Seats VALUES ('B7', 'S7', 'General Class');
INSERT INTO Seats VALUES ('B11', 'S12', 'Business Class');

-- An Airline company wants to know which category sells the most tickets
SELECT
    C.Class,
    COUNT(*) AS TotalTicketsSold
FROM
    TicketNo AS T
JOIN
    BoardingPass AS C ON T.Tid = C.Tid
GROUP BY
    C.Class
ORDER BY
    TotalTicketsSold DESC;

-- List of tickets with no boarding pass
SELECT T.Tid
FROM TicketNo T
LEFT JOIN BoardingPass B ON T.Tid = B.Tid
WHERE B.Tid IS NULL;

-- Find the most popular class by counting seat numbers
SELECT TOP 1 COUNT(S.Class) AS Count, A.Class
FROM Seats S
JOIN Seats A ON S.Tid = A.Tid
GROUP BY A.Class;

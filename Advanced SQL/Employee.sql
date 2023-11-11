-- Created A Database for Employee Table
CREATE DATABASE Employee_SP

-- Enter in the Employee Database
USE Employee_SP

-- Creating A Table 
CREATE TABLE Emp_Detail(
    Emp_ID int primary key,
    Name Nvarchar(50),
    Department_ID int,
    Department_Name Nvarchar(20),
    HOD_Name nvarchar(50),
)

CREATE TABLE Dep_Table(
    Department_ID INT Primary Key,
    Department_Name NVARCHAR(50),
    HOD_Name NVARCHAR(50),
    Location NVARCHAR(30)
)

CREATE TABLE Emp_History(
    Emp_ID int primary key,
    Name NVARCHAR(50),
    Department_ID INT,
    Date_OF_Joining Date,
    Date_Of_Resignation Date,
    Date_Of_Exit Date,
    Status NVARCHAR(10)
)

CREATE TABLE Emp_Exit_Table(
    Emp_ID int primary key,
    Name NVARCHAR(50),
    Department_ID INT,
    Department_Name NVARCHAR(50),
    Date_OF_Joining Date,
    Date_Of_Resignation Date,
    Date_Of_Exit Date
)

-- ADDED CONSTRAINTS WITH ON DELETE AND UPDATE CASCADE

ALTER TABLE Emp_Detail ADD CONSTRAINT FK_Department_ID FOREIGN KEY
(Department_ID) REFERENCES Dep_Table(Department_ID) ON UPDATE CASCADE ON DELETE CASCADE 

ALTER TABLE Emp_Exit_Table ADD CONSTRAINT FK_EXIT_Department_ID FOREIGN KEY
(Department_ID) REFERENCES Dep_Table(Department_ID) ON UPDATE CASCADE ON DELETE CASCADE 

ALTER TABLE Emp_History ADD CONSTRAINT FK_Emp_ID FOREIGN KEY
(Emp_ID) REFERENCES Emp_Detail(Emp_ID) ON UPDATE CASCADE ON DELETE CASCADE 

ALTER TABLE Emp_Exit_Table ADD CONSTRAINT FK_Emp_EXIT_ID_ID FOREIGN KEY
(Emp_ID) REFERENCES Emp_Detail(Emp_ID) ON UPDATE CASCADE ON DELETE CASCADE 

-- DATE Function ADD in Date OF EXIT
UPDATE  Emp_History
SET Date_Of_Exit = DATEADD(day,90,Date_Of_Resignation)

-- INSERT DATA IN DEPARTMENT TABLE 
INSERT INTO Dep_Table VALUES 
    (1,'DATA ANALYSIS','PRASHANT NAIR','VADODARA'),
    (2,'DATA ENGINEERING','PRASHANT NAIR','VADODARA'),
    (3,'DATA SCIENCE','PRASHANT NAIR','VADODARA'),
    (4,'DOT NET','GAGAN DUBEY','VADODARA'),
    (5,'JAVA','PRAVIN DUBEY','VADODARA'),
    (6,'MS-POWER APPS','PRAVIN DUBEY','VADODARA'),
    (7,'NODE-JS','PRAVIN DUBEY','VADODARA')

-- INSERT DATA USING STORED PROCEDURE IN EMP_TABLE AND DEP_TABLE

-- STORE PROCEDURE FOR NEW ONBOARD RESOURCES
CREATE OR ALTER PROCEDURE Insert_Details
(
    @Emp_ID INT,
    @Name NVARCHAR(50),
    @Department_ID INT,
    @Date_OF_Joining DATE,
    @Status NVARCHAR(10)
)
AS
BEGIN
    -- Declare variables to store retrieved values
    DECLARE @Department_Name NVARCHAR(30)
    DECLARE @HOD_Name NVARCHAR(30)

    -- Retrieve data from Dep_Table based on Department_ID
    SELECT @Department_Name = Department_Name, @HOD_Name = HOD_Name 
    FROM Dep_Table
    WHERE Department_ID = @Department_ID

    -- Insert data into Emp_Detail table
    INSERT INTO Emp_Detail (Emp_ID, Name, Department_ID, Department_Name, HOD_Name) 
    VALUES (@Emp_ID, @Name, @Department_ID, @Department_Name, @HOD_Name)

    -- Insert data into Emp_History table
    INSERT INTO Emp_History (Emp_ID, Name, Department_ID, Date_OF_Joining, Status)
    VALUES (@Emp_ID, @Name, @Department_ID, @Date_OF_Joining, @Status)
END

-- STORE PROCEDURE FOR EXIT FORMALITIES
ALTER PROCEDURE EXIT_Detail
(
    @Date_Of_Resignation DATE,
    @Emp_ID INT,
    @Status NVARCHAR(10)
)
AS
BEGIN
    DECLARE @Name NVARCHAR(50)
    DECLARE @Department_ID INT
    DECLARE @Department_Name NVARCHAR(30)
    DECLARE @Date_Of_Joining DATE
    DECLARE @Date_Of_Exit DATE

    -- Retrieve data from Emp_History table
    SELECT @Name = Name, @Department_ID = Department_ID, @Date_Of_Joining = Date_Of_Joining, @Date_Of_Exit = Date_Of_Exit
    FROM Emp_History
    WHERE Emp_ID = @Emp_ID

    SELECT @Department_Name = Department_Name FROM Dep_Table WHERE @Department_ID = Department_ID

    -- Update Date Of Resignation and Status in Emp_History
    UPDATE Emp_History
    SET Date_Of_Resignation = @Date_Of_Resignation,
        Status = @Status
    WHERE Emp_ID = @Emp_ID

    -- Calculate Date_Of_Exit as 90 days from Date_Of_Resignation
    UPDATE Emp_History
    SET Date_Of_Exit = DATEADD(day, 90, @Date_Of_Resignation)
    WHERE Emp_ID = @Emp_ID

    UPDATE Emp_Exit_Table
    SET Date_Of_Exit = DATEADD(day, 90, @Date_Of_Resignation)
    WHERE Emp_ID = @Emp_ID

    -- Insert data into Emp_Exit_Table
    INSERT INTO Emp_Exit_Table (Emp_ID, Name, Department_ID, Department_Name, Date_Of_Joining, Date_Of_Resignation, Date_Of_Exit)
    VALUES (@Emp_ID, @Name, @Department_ID, @Department_Name, @Date_Of_Joining, @Date_Of_Resignation, @Date_Of_Exit)

    -- Calculate Date_Of_Exit as 90 days from Date_Of_Resignation
    UPDATE Emp_Exit_Table
    SET Date_Of_Exit = DATEADD(day, 90, @Date_Of_Resignation)
    WHERE Emp_ID = @Emp_ID

    EXEC update_Status
END

-- Store Procedure to UPDATE Active And Inactive Status IN Employee Exit Table
ALTER PROC update_Status
AS
BEGIN
    -- Update the Status to (Inactive) 
    UPDATE Emp_History
    SET Status = 'I'
    WHERE GETDATE() >= Date_Of_Exit
END

-- Trigger to update Status
CREATE TRIGGER statusofemployee
ON Emp_History
AFTER UPDATE
AS
BEGIN
    -- Check if the 'Status' column has been updated
    IF UPDATE(Status)
    BEGIN
        DECLARE @Date_Of_Exit DATE
        DECLARE @CurrentDate DATE

        -- Get the 'Date_Of_Exit' for the updated record
        SELECT @Date_Of_Exit = Date_Of_Exit FROM inserted WHERE Status = 'A'
        SET @CurrentDate = GETDATE()

        -- Check if 'Date_Of_Exit' matches the current date
        IF @Date_Of_Exit >= @CurrentDate
        BEGIN
            -- Update the 'Status' to 'I' (Inactive)
            UPDATE Emp_History
            SET Status = 'I'
            FROM Emp_History E
            INNER JOIN inserted I ON E.Emp_ID = I.Emp_ID
            WHERE I.Status = 'A' AND E.Date_Of_Exit = @CurrentDate

            PRINT 'Status Updated to Inactive'
        END
    END
END

-- Select statements for verification
SELECT name FROM sys.tables
SELECT * FROM Emp_Detail
SELECT * FROM Emp_History
SELECT * FROM Emp_Exit_Table

-- To Onboard New Employee
EXEC Insert_Details @Emp_ID = 6, @Name = 'Pravin Dubey', @Department_ID = 2, @Status = 'A', @Date_OF_Joining = '2023-01-01'

-- To Mark Exit And Update Resignation Date
EXEC EXIT_Detail @Emp_ID = 6, @Status = 'A', @Date_Of_Resignation = '2023-07-22'

SELECT * FROM Emp_Detail
SELECT * FROM Dep_Table
SELECT * FROM Emp_History
SELECT * FROM Emp_Exit_Table

-- Additional Section for Another Scenario

CREATE DATABASE InsteadOfTriggers
 
USE InsteadOfTriggers
 
CREATE TABLE Tbl_Customer 
(
    Id int primary key, 
    Name varchar(50), 
    Gender varchar(20), 
    City varchar(30), 
    ContactNo varchar(50)
);
 
SELECT * FROM dbo.Tbl_Customer

INSERT INTO Tbl_Customer VALUES
    (1, 'Pradeep', 'Male', 'Vadodara', '03335465678'),
    (2, 'Kinjal', 'Female', 'Vadodara', '03225465678'),
    (3, 'Somesh', 'Male', 'Vadodara', '03135468778'),
    (4, 'Dhruvesh', 'Male', 'Gotri', '03005465678'),
    (5, 'Vishal', 'Male', 'Waghodia', '03135465678'),
    (6, 'Aman', 'Male', 'Anand', '03135468774'),
    (7, 'Dipak', 'Male', 'Anand', '03335468774');

-- Creating Audit Table for Customer
CREATE TABLE Customer_Audit_table 
(
    Audit_Id int primary key identity,
    Audit_Information varchar(max)
);
 
SELECT * FROM Customer_Audit_table

-- Instead Of Insert Trigger Preventing the Insertion
CREATE OR ALTER TRIGGER tr_Customer_InsteadOf_Insert
ON Tbl_Customer
INSTEAD OF INSERT
AS
BEGIN
    PRINT 'You are not allowed to insert data in this table !!'
END

-- Instead Of Insert Trigger Inserting Data in Audit Table
CREATE TRIGGER tr_Customer_InsteadOf_Insert_Audit
ON Tbl_Customer
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO Customer_Audit_table VALUES('Someone tries to insert data in customer table at: ' + CAST(GETDATE() AS VARCHAR(50)))
END

-- Instead Of Update Trigger Preventing the Updation
CREATE OR ALTER TRIGGER tr_Customer_InsteadOf_Update
ON Tbl_Customer
INSTEAD OF UPDATE
AS
BEGIN
    PRINT 'You are not allowed to update data in this table !!'
END

-- Instead Of Update Trigger Inserting a Row in Audit Table
CREATE TRIGGER tr_Customer_InsteadOf_Update_Audit
ON Tbl_Customer
INSTEAD OF UPDATE
AS
BEGIN
    INSERT INTO Customer_Audit_table VALUES('Someone tries to update data in customer table at: ' + CAST(GETDATE() AS VARCHAR(50)))
END

-- Instead Of Delete Trigger Preventing the Deletion
CREATE OR ALTER TRIGGER tr_Customer_InsteadOf_Delete
ON Tbl_Customer
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'You are not allowed to delete anything in this table !!'
END

-- Instead Of Delete Trigger Inserting a Row in Audit Table
CREATE TRIGGER tr_Customer_InsteadOf_Delete_Audit
ON Tbl_Customer
INSTEAD OF DELETE
AS
BEGIN
    INSERT INTO Customer_Audit_table VALUES('Someone tries to delete data from customer table at: ' + CAST(GETDATE() AS VARCHAR(50)))
END

-- Updating Data to Trigger Triggers
UPDATE Tbl_Customer SET Name = 'Pravin' WHERE Id = 6;
DELETE FROM Tbl_Customer WHERE Id = 6;

-- Viewing Trigger
EXEC sp_helptext 'tr_Customer_InsteadOf_Delete_Audit';

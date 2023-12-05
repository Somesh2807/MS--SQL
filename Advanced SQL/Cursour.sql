-- Create Database cursordb
CREATE DATABASE Cursors

-- Switch to the cursordb database
USE Cursors

-- Create the student table
CREATE  TABLE student (
    Student_ID INT IDENTITY(1, 1),
    Student_Name NVARCHAR(30),
    SQL_Marks INT,
    Python_Marks INT,
    Azure_Marks INT,
    Excel_Marks INT,
	Total_Marks INT
);

-- Alter the Cursor1 stored procedure
CREATE OR ALTER PROC Cursor1
AS
BEGIN
    -- Declare variables for cursor
    DECLARE @StudentID INT
    DECLARE @StudentName NVARCHAR(30)
    DECLARE @TotalMarks INT
    DECLARE @Grade NVARCHAR(2)

    -- Declare the cursor
    DECLARE StudentCursor CURSOR FOR
    SELECT Student_ID, Student_Name, SQL_Marks + Python_Marks + Azure_Marks + Excel_Marks AS TotalMarks
    FROM student

    -- Open the cursor
    OPEN StudentCursor

    -- Fetch the first record
    FETCH NEXT FROM StudentCursor INTO @StudentID, @StudentName, @TotalMarks

    -- Loop to calculate Grades
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Calculate the percentage
        DECLARE @Percentage DECIMAL(5, 2)
        SET @Percentage = (CAST(@TotalMarks AS DECIMAL(5, 2)) / 400) * 100

        -- Determine the Grade based on the percentage
        IF @Percentage > 90
            SET @Grade = 'A+'
        ELSE IF @Percentage BETWEEN 80 AND 90
            SET @Grade = 'A'
        ELSE IF @Percentage BETWEEN 70 AND 79
            SET @Grade = 'B'
        ELSE IF @Percentage BETWEEN 60 AND 69
            SET @Grade = 'C'
        ELSE
            SET @Grade = 'F' -- Failed

        -- Print the result
        PRINT 'Student_ID:' + CAST(@StudentID AS NVARCHAR(10)) + ', Student Name: ' + @StudentName +
              ', Total Marks: ' + CAST(@TotalMarks AS NVARCHAR(3)) + ', Out of 400' +
              ', Percentage:' + CAST(@Percentage AS NVARCHAR(10)) + '%' + ', Grade: ' + @Grade

        -- Fetch the next record
        FETCH NEXT FROM StudentCursor INTO @StudentID, @StudentName, @TotalMarks
    END

    -- Close and deallocate the cursor
    CLOSE StudentCursor
    DEALLOCATE StudentCursor

    -- Update the Total_Marks column in the student table
    UPDATE student SET Total_Marks = (SQL_Marks + Python_Marks + Azure_Marks + Excel_Marks)
END

-- Execute the Cursor1 stored procedure
EXEC Cursor1

-- Insert data into the student table
INSERT INTO student (Student_Name, SQL_Marks, Python_Marks, Azure_Marks, Excel_Marks)
VALUES ('KInjal Parmar', 100, 100, 100, 100);

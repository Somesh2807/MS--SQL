CREATE DATABASE cursordb

USE cursordb

create table student(
Student_ID int identity(1,1),
Student_Name NVARCHAR(30),
"SQL_Marks" INT,
Python_Marks INT,
Azure_Marks INT,
Excel_Marks INT
)

ALTER PROC Cursor1
AS
BEGIN

-- Declare the cursor and fetch data
DECLARE @StudentID INT
DECLARE @StudentName NVARCHAR(30)
DECLARE @TotalMarks INT
DECLARE @Grade NVARCHAR(2)

DECLARE StudentCursor CURSOR FOR
SELECT Student_ID, Student_Name, SQL_Marks + Python_Marks + Azure_Marks + Excel_Marks AS TotalMarks
FROM student

OPEN StudentCursor

FETCH NEXT FROM StudentCursor INTO @StudentID, @StudentName, @TotalMarks

-- Loop to calculate Grades
WHILE @@FETCH_STATUS = 0
BEGIN
-- Calculate the percentage
DECLARE @Percentage DECIMAL(5, 2)
SET @Percentage = (CAST(@TotalMarks AS DECIMAL(5, 2)) / 400) * 100

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
    
PRINT 'Student_ID:'+cast(@StudentID AS NVARCHAR(10)) + ', Student Name: ' + @StudentName + ', Total Marks: ' + CAST(@TotalMarks AS NVARCHAR(3)) + ',Out of 400'+',Percentage:'+ cast(@Percentage AS NVARCHAR(10)) + '%'+', Grade: ' + @Grade

FETCH NEXT FROM StudentCursor INTO @StudentID, @StudentName, @TotalMarks
END

CLOSE StudentCursor
DEALLOCATE StudentCursor


UPDATE student SET Total_Marks = (SQL_Marks+Python_Marks+Azure_Marks+Excel_Marks)
END


---- To Execute Cursor

EXEC Cursor1

-- To insert DATA

insert into student (Student_Name	,SQL_Marks	,Python_Marks	,Azure_Marks	,Excel_Marks)  
values ('KInjal Parmar',100,100,100,100)


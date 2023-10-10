-- Creating Database
CREATE DATABASE SIP_Demo

---- USe of Data BAse
USE SIP_DEMO

--- Creating Table OF CUstomer Details
CREATE TABLE UserData
(
ID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(10),
PhoneNumber VARCHAR(10), 
)
----- Store Procedure For storing Customer data

CREATE PROCEDURE sp_InsertUserData
(
    @Name VARCHAR(10),
    @PhoneNumber NVARCHAR(10)
)
AS
BEGIN
    INSERT INTO UserData (Name, PhoneNumber)
    VALUES (@Name, @PhoneNumber);
END;
---- Executing SP od Customer detaiils
EXEC sp_InsertUserData
    @Name = 'Somesh Jatav',
    @PhoneNumber = '8200857566';

------------------ Create of SP of SIP Calculator
create or alter PROCEDURE CalculateSIP
(
    @Name VARCHAR(10),
    @PhoneNumber VARCHAR(10),
    @MonthlyInvestment DECIMAL(18, 2),
    @AnnualInterestRate DECIMAL(5, 2),
    @NumberOfMonths INT
)
AS
BEGIN

    EXEC sp_InsertUserData @Name, @PhoneNumber;------ Run OF SP of Customer details to store it.

    DECLARE   @PrincipalAmount DECIMAL(18, 2)
    SET @PrincipalAmount=@MonthlyInvestment * @NumberOfMonths

    DECLARE @FutureValue DECIMAL(18, 2)
    SET @FutureValue = @PrincipalAmount

    DECLARE @MonthlyRate DECIMAL(8, 6)
    SET @MonthlyRate = @AnnualInterestRate / 12 / 100

    DECLARE @Month INT
    SET @Month = 1

    WHILE @Month <= @NumberOfMonths
    BEGIN

        DECLARE @Interest DECIMAL(18, 2)
        SET @Interest = (@PrincipalAmount + @FutureValue) * @MonthlyRate


        SET @FutureValue = @FutureValue + @MonthlyInvestment + @Interest

        SET @Month = @Month + 1
			    END
			PRINT CONCAT('Name:', @Name)
			PRINT CONCAT('Phone Number:', @PhoneNumber)
			PRINT CONCAT('Principal Amount:', @PrincipalAmount)
			PRINT CONCAT('Monthly Investment:', @MonthlyInvestment)
			PRINT CONCAT('Annual Interest Rate:', @AnnualInterestRate)			
			PRINT CONCAT('Tenure:', @NumberOfMonths)
			PRINT CONCAT('Future Value:', @FutureValue )

END
------------ Execute OF SP of SIP CALCULATOR AND NESTED SP OF CUSTOMER DETAILS
EXEC CalculateSIP
    @Name = 'Somesh Jatav',
    @PhoneNumber = '8200857566',
    @MonthlyInvestment = 1000,
    @AnnualInterestRate = 10,
    @NumberOfMonths = 14

---- VIEW DATA OF CUSTOMER FROM CUSTOMER  TABLE
SELECT * FROM UserData
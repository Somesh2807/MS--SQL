---Use Rise Database
USE rise2023

CREATE OR ALTER PROC simple_calculator
    @principalAmount MONEY,
    @ROI DECIMAL(4,2),
    @Tenure INT
AS 
BEGIN
    DECLARE @simpleInterest MONEY
    SET @simpleInterest = @principalAmount * @ROI * @Tenure / 100

    DECLARE @totalAmount MONEY
    SET @totalAmount = @simpleInterest + @principalAmount

    DECLARE @EMI_PER_Month INT
    SET @EMI_PER_Month = @totalAmount / (12 * @Tenure)

    PRINT 'Loan Details:'
    PRINT CONCAT('Principal amount of loan: ', @principalAmount)
    PRINT CONCAT('Rate of interest of loan: ', @ROI)
    PRINT CONCAT('Loan Tenure: ', @Tenure)
    PRINT CONCAT('Interest amount of Loan: ', @simpleInterest)
    PRINT CONCAT('Total Amount of loan: ', @totalAmount)
    PRINT CONCAT('Monthly EMI: ', @EMI_PER_Month)
END

-- Example: Execute the stored procedure with sample values
EXEC simple_calculator @principalAmount = 1500000, @ROI = 8.85, @Tenure = 22

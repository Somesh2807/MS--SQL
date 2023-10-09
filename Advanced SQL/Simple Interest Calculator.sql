alter proc simple_calculator
@principal_amount money, @ROI decimal(4,2), @Tenure int
as 
begin
declare @simpleinterest money
set @simpleinterest = @principal_amount * @roi * @tenure /100
declare @total_amount money
set @total_amount = @simpleinterest + @principal_amount

declare @EMI_PER_Month int
set @EMI_PER_Month = @total_amount/(12 * @tenure)

print concat('Principal amount of loan ', @principal_amount)
print concat('Rate of interest of loan ', @ROI)
print concat('Loan Tenure ', @Tenure)
print concat('Interest amount of Loan ', @simpleinterest)
print concat('Total Amount of loan ', @total_amount)
print concat('Monthly EMI ', @EMI_PER_Month)
end

simple_calculator @principal_amount = 1500000, @ROI = 8.85, @Tenure = 22
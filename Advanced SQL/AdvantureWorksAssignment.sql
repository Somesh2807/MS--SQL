SELECT FirstName, EmailAddress
FROM sales.Customer
WHERE sales. = 'Bike World'

SELECT Customer.CompanyName, SUM(SalesOrderHeader.SubTotal + SalesOrderHeader.TaxAmt + SalesOrderHeader.Freight) AS Total FROM SalesOrderHeader JOIN Customer ON SalesOrderHeader.CustomerID = Customer.CustomerID GROUP BY Customer.CompanyName HAVING SUM(SalesOrderHeader.SubTotal + SalesOrderHeader.TaxAmt + SalesOrderHeader.Freight) > 100000
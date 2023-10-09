use AdventureWorks2017

select name
from sys.tables

SELECT schema_name(schema_id) AS SchemaName, name AS TableName
FROM sys.tables where SchemaName like 's%'

SELECT schema_name(schema_id) AS SchemaName, name AS TableName
FROM sys.tables
WHERE schema_name(schema_id) LIKE 's%';

select * from Sales.CreditCard



--- Update Price UpdateProductPrice 
--This procedure allows you to update the price of a product in the Production.Product table.
	CREATE PROCEDURE UpdateProductPrice
    @ProductID INT,
    @NewPrice DECIMAL(18, 2)
AS
BEGIN
    UPDATE Production.Product
    SET ListPrice = @NewPrice
    WHERE ProductID = @ProductID
END

EXEC UpdateProductPrice @ProductID = 1001, @NewPrice = 49.99;

----------------- Execute -------------------


CREATE PROCEDURE InsertSalesOrder
    @CustomerID INT,
    @OrderDate DATE,
    @DueDate DATE
    
AS
BEGIN
    INSERT INTO Sales.SalesOrderHeader (CustomerID, OrderDate, DueDate)
    VALUES (@CustomerID, @OrderDate, @DueDate)
END

select * from sales.SalesOrderHeader
-----------SUB QUERY TO find minimum of product price.
SELECT ProductID,Name, ListPrice,*
FROM Production.Product WHERE ListPrice = (SELECT MIN(ListPrice)FROM Production.Product);

---SUB QUERY To find maximum from product price 

SELECT (SELECT MAX(ListPrice) FROM Production.Product) AS MaxListPrice,* FROM Production.Product;

-------




-------------
-- Example for executing the InsertCustomer procedure
EXEC InsertCustomer @FirstName = 'John', @LastName = 'Doe';

-- Example for executing the UpdateProductPrice procedure
EXEC UpdateProductPrice @ProductID = 1001, @NewPrice = 49.99;

-- Example for executing the InsertSalesOrder procedure
EXEC InsertSalesOrder @CustomerID = 1, @OrderDate = '2023-10-09', @DueDate = '2023-10-16'



-- Example for executing the UpdateSalesTerritory procedure
EXEC UpdateSalesTerritory @TerritoryID = 1, @NewTerritoryName = 'Eastern Region';

-- Example for executing the InsertEmployee procedure
EXEC InsertEmployee @FirstName = 'Jane', @LastName = 'Smith';

-- Example for executing the UpdateProductInventory procedure
EXEC UpdateProductInventory @ProductID = 2001, @NewQuantity = 50;

-- Example for executing the InsertAddress procedure
EXEC InsertAddress @AddressLine1 = '123 Main St', @City = 'New York', @StateProvinceID = 1, @PostalCode = '10001';

-- Example for executing the UpdateCreditCardLimit procedure
EXEC UpdateCreditCardLimit @CreditCardID = 101, @NewLimit = 5000.00;


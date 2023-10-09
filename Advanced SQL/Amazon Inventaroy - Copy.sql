create database Amazon
use Amazon

create Table Inventaroy (
Product_ID int primary key,
product_name nvarchar(50),
price money,
Stock_Quantity int ,
Remaining_stock int,
Sold_Quantity int
)


create Table Sales(
Order_ID int identity (1,3),
Order_date nvarchar(50) default sysdatetime(),
Product_ID int ,
Quantity_Ordered int,
Sales_price money,
Total_Cost money
)

insert into Inventaroy values (1,'I Phone 15 Pro Max Ultra 256 GB' ,250000,100, null, null)
insert into Inventaroy values (2,'Grocery' ,5000,100, null, null)
insert into Inventaroy values (3,'AC Samsung' ,65000,100, null, null)
insert into Inventaroy values (4,'Xiomi TV 55 Inch LED' ,45000,100, null, null)
--ADD PRIMARY KEY IN Inventaroy TABLE

ALTER TABLE SALES ADD CONSTRAINT FK_PRODUCT_ID FOREIGN KEY (PRODUCT_ID)


--ADD  FOREIGN KEY IN SALES TABLE

ALTER TABLE SALES ADD CONSTRAINT FK_PRODUCT_ID FOREIGN KEY (PRODUCT_ID)
REFERENCES INVENTAROY(PRODUCT_ID) ON UPDATE CASCADE ON DELETE CASCADE

--- Create STore Procedure

ALTER PROCEDURE sales_proc
(
    @Product_ID INT,
    @Quantity_Ordered INT
)
AS
BEGIN
    DECLARE @Sales_Price MONEY
    DECLARE @Total_Cost MONEY
    DECLARE @GST INT
    DECLARE @Stock_Quantity INT

    -- Get product information
    SELECT @Stock_Quantity = Stock_Quantity, @GST = CASE
        WHEN @Product_ID = 1 THEN 28
        WHEN @Product_ID = 2 THEN 18
        WHEN @Product_ID = 3 THEN 5
        WHEN @Product_ID = 4 THEN 18
        ELSE NULL -- Handle the case for an invalid Product_ID
    END,
    @Sales_Price = Price * @Quantity_Ordered
    FROM Inventaroy
    WHERE Product_ID = @Product_ID

    -- Check for invalid Product_ID
    IF @GST IS NULL
    BEGIN
        PRINT 'ERROR! INVALID PID'
    END
    ELSE
    BEGIN
        -- Check if there's enough stock
        IF @Quantity_Ordered <= @Stock_Quantity
        BEGIN
            -- Calculate Total_Cost
            SET @Total_Cost = @Sales_Price + ((@GST / 100.0) * @Sales_Price)

            -- Insert into the sales table
            INSERT INTO Sales (Product_ID, Quantity_Ordered, Sales_Price, Total_Cost)
            VALUES (@Product_ID, @Quantity_Ordered, @Sales_Price, @Total_Cost)
			
			

            -- Update Inventaroy
            UPDATE Inventaroy
            SET Stock_Quantity = Stock_Quantity - @Quantity_Ordered, Sold_Quantity = Sold_Quantity + @Quantity_Ordered
            WHERE Product_ID = @Product_ID
			
        END
        ELSE
        BEGIN
            PRINT 'Insufficient Quantity'
        END
    END
END



select * from Sales order by Order_ID desc
select * from Inventaroy

update Inventaroy set Stock_Quantity = 1000 + Stock_Quantity where Product_ID = 1

exec  sales_proc  @Product_ID=1, @Quantity_Ordered=1500

---- TO Get Text of store procedure
sp_helptext sales_proc
--- To Get Dependence of store procedure with Tables

sp_depends  sales_proc


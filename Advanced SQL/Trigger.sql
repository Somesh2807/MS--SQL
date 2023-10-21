USE TRIGER


CREATE TABLE [dbo].[Account](
    [AccountID] [int] NOT NULL,
    [AccountHolderName] [nvarchar](255) NULL,
    [Balance] [decimal](18, 2) NULL,
    [Status] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED
(
    [AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
--Transaction table
CREATE TABLE [dbo].[Transaction](
    [TransactionID] [int] IDENTITY(1,1) NOT NULL,
    [AccountID] [int] NULL,
    [TransactionType] [nvarchar](10) NULL,
    [Amount] [decimal](18, 2) NULL,
    [TransactionDate] [datetime] NULL,
    [Remarks] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED
(
    [TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO

-- Insert sample data into the Account table
INSERT INTO [dbo].[Account] (AccountID, AccountHolderName, Balance, Status)
VALUES
    (1, 'Pradeep', 50000.00, 'Active'),
    (2, 'Somesh', 7500.00, 'Active'),
    (3, 'Dhruvesh', 1000.00, 'Inactive');

	
CREATE OR ALTER TRIGGER TransactionInsertTrigger
ON [Transaction]
AFTER INSERT
AS
BEGIN
    -- Declare variables to capture inserted data
    DECLARE @AccountID INT, @TransactionType NVARCHAR(10), @Amount DECIMAL(18, 2), @Remarks NVARCHAR(255), @TransactionDate DATETIME
    
    -- Capture the inserted values from the inserted table
    SELECT
        @AccountID = i.AccountID,
        @TransactionType = i.TransactionType,
        @Amount = i.Amount,
        @Remarks = i.Remarks,
        @TransactionDate = i.TransactionDate
    FROM inserted i;
     
    -- Insert the captured values into the Transaction table (if not already inserted by the procedure)
    INSERT INTO [Transaction] (AccountID, TransactionType, Amount, TransactionDate, Remarks)
    SELECT @AccountID, @TransactionType, @Amount, @TransactionDate, @Remarks
    WHERE NOT EXISTS (
        SELECT 1
        FROM [Transaction]
        WHERE AccountID = @AccountID
        AND TransactionType = @TransactionType
        AND Amount = @Amount
        AND TransactionDate = @TransactionDate
        AND Remarks = @Remarks
    );
END;

 ALTER PROCEDURE RecordTransaction
    @AccountID INT,
    @TransactionType NVARCHAR(10), -- 'Credit' or 'Debit'
    @Amount DECIMAL(18, 2),
    @Remarks NVARCHAR(255) = NULL
AS
BEGIN
    -- Check if the account is active
    DECLARE @AccountStatus NVARCHAR(10)
    
    SELECT @AccountStatus = Status
    FROM Account
    WHERE AccountID = @AccountID
    
    IF (@AccountStatus = 'Inactive')
    BEGIN
        PRINT 'Transaction failed: Account is Inactive. Cannot perform transactions.';
        RETURN; -- Exit the procedure
    END

   -- Check for total transactions exceeding 40,000 for debit transactions
    IF (@TransactionType = 'Debit')
    BEGIN
        -- Restrict debit transactions to a maximum of 3 times per day
        DECLARE @DailyDebitCount INT
        DECLARE @Today DATE
        
        SET @Today = CAST(GETDATE() AS DATE)
        
        SELECT @DailyDebitCount = COUNT(TransactionID)
        FROM [Transaction]
        WHERE AccountID = @AccountID
            AND TransactionType = 'Debit'
            AND TransactionDate >= @Today
        
        IF (@DailyDebitCount >= 3)
        BEGIN
            SET @Remarks = 'Daily debit transaction limit exceeded (3 transactions per day).';
            PRINT 'Transaction failed: Daily debit transaction limit exceeded (3 transactions per day).';
            RETURN; -- Exit the procedure
        END

       DECLARE @TotalTransactions DECIMAL(18, 2)
        
        SELECT @TotalTransactions = SUM(Amount)
        FROM [Transaction]
        WHERE AccountID = @AccountID
            AND TransactionType = 'Debit'
    
        IF (@TotalTransactions + @Amount > 40000)
        BEGIN

           PRINT 'Transaction failed: Total debit transactions limit exceeded (40,000).';
            RETURN; -- Exit the procedure
        END
    END

   -- Validate input
    IF (@TransactionType NOT IN ('Credit', 'Debit'))
    BEGIN
        PRINT 'Transaction failed: Invalid transaction type.';
        RETURN; -- Exit the procedure
    END

   -- Check for sufficient balance if debit
    IF (@TransactionType = 'Debit')
    BEGIN
        DECLARE @CurrentBalance DECIMAL(18, 2)
        
        SELECT @CurrentBalance = Balance
        FROM Account
        WHERE AccountID = @AccountID
        
        IF (@CurrentBalance - @Amount < 0)
        BEGIN
            SET @Remarks = 'Insufficient balance for debit.';
            PRINT 'Transaction failed: Insufficient balance for debit.';
            RETURN; -- Exit the procedure
        END
    END

   -- Insert data into the Transaction table
    INSERT INTO [Transaction] (AccountID, TransactionType, Amount, TransactionDate, Remarks)
    VALUES (@AccountID, @TransactionType, @Amount, GETDATE(), @Remarks);

   -- Update the account balance
    IF (@TransactionType = 'Credit')
    BEGIN
        UPDATE Account
        SET Balance = Balance + @Amount
        WHERE AccountID = @AccountID;
    END
    ELSE IF (@TransactionType = 'Debit')
    BEGIN
        UPDATE Account
        SET Balance = Balance - @Amount
        WHERE AccountID = @AccountID;
    END

   PRINT 'Transaction succeeded.';
END;



EXEC RecordTransaction
    @AccountID = 2,            -- Actual AccountID
    @TransactionType = 'DEBIT', -- Specify 'Credit' for DEBIT transactions
    @Amount = 1000.00,
    @Remarks='NULL';

	select * from Account

-----------------------------------------------------------------------------------------------------------


CREATE TABLE [dbo].[size] (
    [s_id]      INT          IDENTITY (101, 1) NOT NULL,
    [s_name]    VARCHAR (15) NULL,
    [S_Price++] MONEY        NULL,
    PRIMARY KEY CLUSTERED ([s_id] ASC)
);


CREATE TABLE [dbo].[product] (
    [p_id]           INT          IDENTITY (1, 1) NOT NULL,
    [p_name]         VARCHAR (15) NULL,
    [category]       VARCHAR (20) NULL,
    [Price_per_unit] MONEY        NULL,
    PRIMARY KEY CLUSTERED ([p_id] ASC)
);


CREATE TABLE [dbo].[customer] (
    [c_id]       INT          IDENTITY (5001, 1) NOT NULL,
    [c_name]     VARCHAR (20) NULL,
    [contact_no] BIGINT       NULL,
    [address]    VARCHAR (50) NULL,
    [email]      VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([c_id] ASC),
    CONSTRAINT [ck_len] CHECK (len([contact_no])=(10))
);

CREATE TABLE [dbo].[order_tbl] (
    [o_id]          INT          IDENTITY (501, 1) NOT NULL,
    [customer_id]   INT          NULL,
    [product_id]    INT          NULL,
    [Size_ID]       INT          NULL,
    [day_date]      VARCHAR (50) NULL,
    [mode_of_order] VARCHAR (10) NULL,
    [quantity]      INT          NULL,
    [total_price]   DECIMAL (18) NULL,
    PRIMARY KEY CLUSTERED ([o_id] ASC),
    FOREIGN KEY ([customer_id]) REFERENCES [dbo].[customer] ([c_id]),
    FOREIGN KEY ([product_id]) REFERENCES [dbo].[product] ([p_id]),
    CONSTRAINT [ck_mdoe] CHECK ([mode_of_order]='Online' OR [mode_of_order]='offline')
);


insert into size values('Regular',0),
('Medium',70),
('Large',150),
('Extra Large',220),
('Giant',300)

insert into product values('Veg','Pizza',200),
('New_Farm','Pizza'400),
('Tan','Pizza'350),
('Paneer','Pizza',400

select * from size
select * from product
select * from customer
select * from order_tbl


create proc sp_addcustomer
(@c_name Nvarchar(50),@Contact_no BIGINT,@Address NVARCHAR(150),@Email_ID NVarchar(100))
as 
begin
insert into customer (c_name,contact_no,address,email) values (@c_name,@Contact_no,@Address,@Email_ID)
end


 -- Create a trigger for the 'order_tbl' table
CREATE TRIGGER ApplyPizzaDiscountAndCalculateGST
ON [dbo].[order_tbl]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Calculate the total price and apply the discount and GST for eligible pizza orders
    UPDATE o
    SET o.total_price = CASE
            WHEN p.[category] = 'Pizza' 
                AND (DATEPART(WEEKDAY, CAST(o.day_date AS DATE)) IN (3, 6)) -- Tuesday (3) and Friday (6)
                AND (o.quantity > 2 OR (o.quantity * p.[Price_per_unit] > 500))
                THEN (o.quantity * p.[Price_per_unit]) * 0.5 * 1.18 -- 50% discount and 18% GST
            ELSE o.quantity * p.[Price_per_unit] * 1.18 -- No discount, just 18% GST
        END
    FROM [dbo].[order_tbl] AS o
    JOIN [dbo].[product] AS p ON o.product_id = p.p_id
    WHERE o.o_id IN (SELECT DISTINCT i.o_id FROM INSERTED i);

END;



------TO INSERT DATA IN Customer detail

exec sp_addcustomer  @c_name ='Somesh Jatav  ' ,@Contact_no = 8200857566,
@Address = 'The rise',@Email_ID = 'somesh8200@outlook.com'

---------------------------------------------


CREATE TRIGGER ApplyPizzaDiscountAndCalculateGST
ON [dbo].[order_tbl]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;







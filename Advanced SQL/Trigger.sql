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

------ Pizza order with Trigger & SP
create database pizza
use pizza
create table size (
    s_id int identity (101, 1) not null,
    s_name varchar(15) null,
    s_price money null,
    primary key clustered (s_id asc)
)

-- Table: product
create table product (
    p_id int identity (1, 1) not null,
    p_name varchar(15) null,
    category varchar(20) null,
    price_per_unit money null,
    primary key clustered (p_id asc)
)

-- Table: customer
create table customer (
    c_id int identity (5001, 1) not null,
    c_name varchar(20) null,
    contact_no bigint null,
    address varchar(50) null,
    email varchar(50) null,
    primary key clustered (c_id asc),
    constraint ck_len check (len(contact_no) = 10)
)

-- Table: order_tbl
create table order_tbl (
    o_id int identity (501, 1) not null,
    customer_id int null,
    product_id int null,
    size_id int null,
    day_date date null,
    mode_of_order varchar(10) null,
    quantity int null,
    total_price decimal(18) null,
    primary key clustered (o_id asc),
    foreign key (customer_id) references dbo.customer (c_id),
    foreign key (product_id) references dbo.product (p_id),
    constraint ck_mode check (mode_of_order = 'online' or mode_of_order = 'offline')
)

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
select * from order_tbl
select * from customer



create or alter proc sp_addcustomer
(@c_name Nvarchar(50),@Contact_no BIGINT,@Address NVARCHAR(150),@Email_ID NVarchar(100))
as 
begin
insert into customer (c_name,contact_no,address,email) values (@c_name,@Contact_no,@Address,@Email_ID)
select top 1 * from customer order by  c_id desc
end

----Trigger offer applicable on Tuesday and Friday, minmum 2 order and it should be online only


create or alter trigger pizzadiscount
on order_tbl
after insert
as
begin
set nocount on

declare @category nvarchar(20)--Declatred Variable to store Cateogory of order

select @category = p.category---Variable source code
from product p where p.p_id in (select o.product_id from inserted i 
join order_tbl o on i.product_id = o.product_id
where p.category = 'pizza'
)

if @category = 'pizza'---conditions begin to check whether order is pizza or not ?
begin   ----IF yes then order as per below conditions
update o  set day_date = getdate(),
total_price = case
when @category = 'pizza' 
and datepart(weekday, cast(o.day_date as date)) in (3, 6) -- tuesday (3) and friday (6)
and (o.quantity > 2 or (o.quantity * p.price_per_unit > 500))
and o.mode_of_order = 'online'
then (o.quantity * p.price_per_unit + s.[s_price++] * o.quantity) * 0.5 * 1.18 -- 50% discount and 18% gst
else (o.quantity * p.price_per_unit + s.[s_price++] * o.quantity) * 1.18 -- no discount, just 18% gst
end
from order_tbl o
join product p on o.product_id = p.p_id
join size s on o.size_id = s.s_id
where o.o_id in (select i.o_id from inserted i)
end

else---else condotion if order is not pizza then no discount on any day (simple calulation price * quantity)
begin
update o
set
day_date = getdate(),
size_id = 0,
total_price = (o.quantity * p.price_per_unit) * 1.18 -- 18% gst
from order_tbl o
join product p on o.product_id = p.p_id
where o.o_id in (select i.o_id from inserted i)
end
end


------TO INSERT DATA IN Customer detail

exec sp_addcustomer  @c_name ='Vineeta Singh' ,@Contact_no = 7983749554,
@Address = 'vadodara',@Email_ID = 'vineeta.singh@outlook.com'

-----To find customer detail
select * from customer where contact_no = 8200857566 or email= 'somesh820@outlook.com'

----To Insert Data Into Order Table

insert into order_tbl (customer_id,product_id,Size_ID,mode_of_order,quantity) values (5003,6,104,'online',2)

---------------------------------------------

select * from size
select * from product
select * from order_tbl
select * from customer




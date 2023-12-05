create database Banking -- Create Database

	USE banking  --- USe Database

create table account
(
"AC_No" int primary key,
"AC_Name" nvarchar(50),
"AC_Type" nvarchar(10),
Branch nvarchar(50),
"AC_Balance" money
)

create table Transcation(
"AC_No" int,
"AC_Name" nvarchar(50),
Transaction_ID int identity(78975,59),
Transaction_Type nvarchar(10),
Debit money,
credit money,
Amount money,
"Date" nvarchar(50) default sysdatetime()
)


--create Table History_Transaction(
--AC_No int,
--Transaction_ID int,
--"date" datetime  default sysdatetime(),
--Transaction_Type Nvarchar(20),
--Amount money,
--Remarks NVARCHAR(3000)
--)
--

--- Aff FK Key wiyj cascade
alter table Transcation add constraint FK_TR_NO foreign key ("AC_No")
references account("AC_No") on update cascade 

-- Insert Value into Account table
insert into account values
(200200123,	'Somesh Singh','Savings','Alkapuri',1000000), 
(200200124,	'Vishal Parmar','Current','SayajiGunj',4500000),
(200200125,	'Pradeep Rana','Savings','Sardar Estate',7800000),
(200200126,	'Kinjal Parmar','Current','Akota',9800000),
(200200127,	'Hiral Prajapati','Savings','Waghodiya',55000000)



--Query for Credit procedure 
create or alter procedure credit
@AC_No int , @AC_Name nvarchar(50), @credit money
as
begin 
insert into Transcation (AC_No ,AC_Name ,credit) values ( @AC_No , @AC_Name , @credit)
update account set AC_Balance = @credit + AC_Balance where AC_No = @AC_No
update Transcation set credit = 0 where credit is null
update Transcation set Debit = 0 where Debit is null
UPDATE Transcation SET Transaction_Type = case
when Debit = 0 then 'Credit' 
ELSE 'Debit' 
end
UPDATE Transcation SET Amount = (Debit + credit)
end

--- Query for debit procedure

create or alter procedure debit
@AC_No int , @AC_Name nvarchar(50), @debit money
as
begin
declare @AC_Balance money
select    @AC_Balance = AC_Balance  from Account where AC_No = @AC_NO
if @AC_Balance >= @debit
begin
insert into Transcation (AC_No ,AC_Name ,debit) values ( @AC_No , @AC_Name , @debit)
update account set AC_Balance = AC_Balance - @debit  where AC_No = @AC_No
print 'Debit transaction successfully Done'
end
else
begin	
print 'Transcation Failed Due To insufficient balance in  your account'
end

update Transcation set Debit = 0 where Debit is null
update Transcation set credit = 0 where credit is null
UPDATE Transcation SET Transaction_Type = case
when Debit = 0 then 'Credit' 
ELSE 'Debit' 
end
UPDATE Transcation SET Amount = (Debit + credit)
end

----- Deposit Trigger
--CREATE OR ALTER TRIGGER DEPOSIT
--ON Transcation
--AFTER INSERT, UPDATE
--AS
--BEGIN
--    SET NOCOUNT ON;
--
--	-- History_Transaction Update
--    INSERT INTO History_Transaction (AC_No, Transaction_ID, Transaction_Type, Amount,Remarks)
--    SELECT AC_No, Transaction_ID, Transaction_Type, Amount,Transaction_Type+' Done Susscesfully'
--    FROM inserted;
--	with result as (
--	SELECT ROW_NUMBER () OVER (PARTITION BY Transaction_ID ORDER BY [date]) AS Row_Num, * 
--FROM History_Transaction)
--delete from result where Row_Num>=2
--
--    END;

---Query to run Debit procedure

debit @AC_No = 200200126 , @AC_Name = 'Vishal Parmar', @debit =4500.00


-- Query to run credit command

credit @AC_No = 200200126 , @credit = 1, @AC_Name = "Kinjal"

select * from Transcation
select * from account



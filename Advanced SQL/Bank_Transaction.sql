create database Rise
	USE Rise
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
Debit money,
credit money,
"Date" nvarchar(50) default sysdatetime()
)


select * from Transcation
select * from account

alter table Transcation add constraint FK_TR_NO foreign key ("AC_No")
references account("AC_No") on update cascade 

sp_help account
SP_help Transcation


insert into account1 values
(200200123,	'Somesh Singh','Savings','Alkapuri',1000000), 
(200200124,	'Vishal Parmar','Current','SayajiGunj',4500000),
(200200125,	'Pradeep Rana','Savings','Sardar Estate',7800000),
(200200126,	'Kinjal Parmar','Current','Akota',9800000),
(200200127,	'Hiral Prajapati','Savings','Waghodiya',55000000)

select * from account
select * from Transcation


--Query for Credit procedure 
alter procedure credit
@AC_No int , @AC_Name nvarchar(50), @credit money
as
begin 
insert into Transcation (AC_No ,AC_Name ,credit) values ( @AC_No , @AC_Name , @credit)
update account set AC_Balance = @credit + AC_Balance where AC_No = @AC_No
update Transcation set credit = 0 where credit is null
update Transcation set Debit = 0 where Debit is null
UPDATE Transcation SET Amount = (Debit + credit)

end

--- Query for debit procedure

alter procedure debit
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
UPDATE Transcation SET Amount = (Debit + credit)

end

---Query to run Debit procedure

debit @AC_No = 200200126 , @AC_Name = 'Vishal Parmar', @debit =4500.00


-- Query to run credit command

credit @AC_No = 200200126 , @credit = 10000, @AC_Name = "Kinjal"


select * from account
select * from Transcation
select * from History_Transaction
 


 drop table History_Transaction

 drop trigger DEPOSIT


create Table History_Transaction(
AC_No int,
Transaction_ID int,
"date" datetime  default sysdatetime(),
Transaction_Type Nvarchar(20),
Amount money,
Remarks NVARCHAR(3000)
)

select * from account
select * from Transcation
select * from History_Transaction 







CREATE or ALTER Trigger DEPOSIT
on Transcation
AFTER INSERT,UPDATE
AS BEGIN

Declare @AC_No int
DECLARE @Trans_id int
DECLARE @Trans_Type Nvarchar(20)
Declare @Amount money
Declare @Debit money

select @Debit= Debit from Transcation 
Select @AC_No =AC_No from inserted
Select @Trans_id = Transaction_ID from inserted
Select @Trans_Type = Transaction_Type from inserted
Select @Amount = Amount from inserted


----- Update for Transcation table

if @Debit = 0
begin
update Transcation set Transaction_Type = 'Credit' where  @AC_No = AC_No 
END
else 
begin
update Transcation set Transaction_Type = 'Debit' where  @AC_No=AC_No 
end

------------------ History_Transaction Update---

insert into History_Transaction (AC_No,Transaction_ID,Transaction_Type,Amount)
Values(@AC_No,@Trans_id,@Trans_Type,@Amount)

END






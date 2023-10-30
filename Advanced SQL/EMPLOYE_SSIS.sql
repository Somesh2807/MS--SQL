create database  sales

use sales


select name
from sys.tables


-- Create the Department table
CREATE TABLE Department (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName NVARCHAR(255),
    DepartmentCode NVARCHAR(255),
    DepartmentManagerID INT
);

-- Create the HOD table
CREATE TABLE HOD (
    HODID INT IDENTITY(1,1) PRIMARY KEY,
    HODName NVARCHAR(255),
    DepartmentID INT,
    HOD_Contact_Information NVARCHAR(255)
);

-- Create the Product table
CREATE TABLE Product (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(255),
    ProductCategory NVARCHAR(255),
    ProductDescription NVARCHAR(255),
    ProductPrice Money,
    ProductQuantityInStock INT
);

-- Create the Customer table
CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(255),
    CustomerAddress NVARCHAR(255),
    CustomerContactInformation NVARCHAR(255)
);

-- Create the SalesOrder table
CREATE TABLE SalesOrder (
    SalesOrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    OrderQuantity INT,
    OrderStatus NVARCHAR(255),
    EmployeeID INT
);

-- Create the SalesInvoice table
CREATE TABLE SalesInvoice (
    SalesInvoiceID INT IDENTITY(1,1) PRIMARY KEY,
    SalesOrderID INT,
    CustomerID INT,
    ProductID INT,
    InvoiceDate DATE,
    InvoiceAmount Money,
    EmployeeID INT
);




-- Add foreign key to the Department table
ALTER TABLE Department
ADD CONSTRAINT FK_Department_Employee
FOREIGN KEY (DepartmentManagerID)
REFERENCES Employee(EmployeeID);

-- Add foreign key to the HOD table
ALTER TABLE HOD
ADD CONSTRAINT FK_HOD_Department
FOREIGN KEY (DepartmentID)
REFERENCES Department(DepartmentID);

-- Add foreign key to the SalesOrder table
ALTER TABLE SalesOrder
ADD CONSTRAINT FK_SalesOrder_Customer
FOREIGN KEY (CustomerID)
REFERENCES Customer(CustomerID);

ALTER TABLE SalesOrder
ADD CONSTRAINT FK_SalesOrder_Product
FOREIGN KEY (ProductID)
REFERENCES Product(ProductID);

ALTER TABLE SalesOrder
ADD CONSTRAINT FK_SalesOrder_Employee
FOREIGN KEY (EmployeeID)
REFERENCES Employee(EmployeeID);

-- Add foreign key to the SalesInvoice table
ALTER TABLE SalesInvoice
ADD CONSTRAINT FK_SalesInvoice_SalesOrder
FOREIGN KEY (SalesOrderID)
REFERENCES SalesOrder(SalesOrderID);

ALTER TABLE SalesInvoice
ADD CONSTRAINT FK_SalesInvoice_Customer
FOREIGN KEY (CustomerID)
REFERENCES Customer(CustomerID);

ALTER TABLE SalesInvoice
ADD CONSTRAINT FK_SalesInvoice_Product
FOREIGN KEY (ProductID)
REFERENCES Product(ProductID);

ALTER TABLE SalesInvoice
ADD CONSTRAINT FK_SalesInvoice_Employee
FOREIGN KEY (EmployeeID)
REFERENCES Employee(EmployeeID);

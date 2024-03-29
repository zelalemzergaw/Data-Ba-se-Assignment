USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[AddNewCustomer] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROCEDURE [dbo].[AddNewCustomer](
@fName varchar(50),
@lName varchar(50),
@telephoneNo int,
@city varchar(50),
@street varchar(50),
@state varchar(50),
@zipCode int,
@country varchar(50),
@salesRepID int,
@serviceNo int,
@serviceName varchar(50),
@commissionRate int)

AS
BEGIN
SET NOCOUNT ON;
DECLARE @telCheck int = 0;
DECLARE @valid bit = 1;
SET @serviceNo = 0;
SET @telCheck = (SELECT COUNT(*) from Customer where telephoneNo = @telephoneNo);
SELECT @serviceNo = serviceNo from Service where country = @country and 
name = @serviceName;
IF(SELECT COUNT(*) from Sales_Representative where @salesRepID = @salesRepID) = 0
BEGIN
SET @valid = 0;
PRINT 'Invalid Sales Representative ID';
END
IF @commissionRate < 5 or @commissionRate > 10 
BEGIN
SET @valid = 0;
PRINT 'Allowed commission value is between 5 and 10 percent';
END
IF @serviceNo = 0
BEGIN
SET @valid = 0;
PRINT 'Invalid service name';
ENDIF @valid = 0
BEGIN

PRINT 'Can not add new customer.';
RETURN;
END
ELSE
BEGIN
INSERT INTO [dbo].[Customer]
       ([fName],[lName],[telephoneNo],[serviceNo],[street],[city],[state],[zipCode],[country],[salesRepID],[commissionRate])
	SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
 'Excel 12.0;Database=D:\DBMS_Project\Docs\Services.xls', [Sheet1$])
VALUES
        (@fName,@lName,@telephoneNo,@serviceNo, @street,@city,@state,@zipCode,@country,@salesRepID, @commissionRate)
PRINT 'Success: new customer is added.';
END
END

EXEC AddNewCustomer 'Meron', 'tesfay', '01111111', 01, 'nkjhdg hgad', 'New York','NY', 1002, 'USA',22, 8 ;


select * from Rate
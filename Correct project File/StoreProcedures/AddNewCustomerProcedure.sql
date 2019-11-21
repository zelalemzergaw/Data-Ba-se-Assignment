
USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[AddNewCustomer] Script Date: 11/20/2019 3:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter PROCEDURE [dbo].[AddNewCustomer](
@fName varchar(50),
@lName varchar(50),
@telephoneNo bigint,
@city varchar(50),
@street varchar(50),
@state varchar(50),
@zipCode int,
@country varchar(50),
@salesRepID int,
@serviceName varchar(50),
@commissionRate int)

AS

BEGIN
SET NOCOUNT ON;
DECLARE @serviceNo int=0;
DECLARE @telCheck int = 0;
DECLARE @valid bit = 1;
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
END IF @valid = 0
BEGIN

PRINT 'Can not add new customer.';
RETURN;
END
ELSE
BEGIN
INSERT INTO [dbo].[Customer]
        ([fName],[lName],[telephoneNo],[serviceNo],[street],[city],[state],[zipCode],[country],[salesRepID],[commissionRate])
VALUES
        (@fName,@lName,@telephoneNo,@serviceNo,@street,@city,@state,@zipCode,@country,@salesRepID, @commissionRate)
PRINT 'Success: new customer is added.';
END
END

EXEC AddNewCustomer 'Meron', 'Janson', 3194006869,'Fairfield', '4th st North','IA', 52557, 'Germany',1, 'Spectra', 8 ;

select * from Customer
select * from Service

USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[InsertCustomerList]    Script Date: 11/19/2019 9:58:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCustomer]
    @filePath varchar(max)
AS
BEGIN
    
  create table #tempCustomer(
  [fName] [varchar](50),
  [lName] [varchar](50),
  [telephoneNO] [bigint],
   [ServiceName] [varchar](50),
  [Street] [varchar] (50),
  [City] [varchar](50),
  [State] [varchar](50),
  [Zipcode] [int],
  [Country] [varchar](50),
  
  [salesRepID] [int],
   [commissionRate] [int] 

)
    DECLARE @sql VARCHAR(MAX);
SET @sql = 'INSERT INTO #tempCustomer(fName,lName,telephoneNO,ServiceName,Street,City,State,ZipCode,Country,salesRepID,commissionRate )
    SELECT fName as fName,lName as lName,telephoneNO as telephoneNO, ServiceName as Servicename,Street as street,City as city,State as state,
    ZipCode as zipcode,Country as country,salesRepID as salesRepId,commissionRate as commissionRate
    FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'', ''Excel 8.0;Database='+ @filePath + ';'' ,''SELECT * FROM [Sheet1$]'')' ;


  print @sql
Exec(@sql)

DECLARE 
@fName varchar(50),
@lName varchar(50),
@telephoneNO bigint,
@serviceNo int,
@city varchar(50),
@street varchar(50),
@state varchar(50),
@zipCode int,
@country varchar(50),
@commissionRate int,
@salesRepId int,
@serviceName varchar(50)


select * from #tempCustomer;

    SELECT @telephoneNO = min(telephoneNO) FROM #tempCustomer;

  
    while @telephoneNO is not null
   
    BEGIN
	
	SELECT @serviceName= t.ServiceName, @serviceNo=S.serviceNo , @fName = t.fname, @lName = t.lName,  @telephoneNO=T.telephoneNO, @street = t.street, @city = t.city,@state =  t.state, @zipCode = t.zipcode, @country = t.country, 
      @salesRepId =salesRepId,  @commissionRate = commissionRate FROM #tempCustomer t, Service S  WHERE S.country=t.Country AND S.name=t.ServiceName AND telephoneNO = @telephoneNO;
    
   
   
   
  print 'SERVICE'
            INSERT INTO customer(fName,lName,telephoneNO,serviceNo, street,city,state,zipcode,country,commissionRate,salesRepId)
            VALUES (@fName, @lName, @telephoneNO, @serviceNo, @street,@city,@state,@zipCode,@country,@commissionRate,@salesRepId  );

    SELECT @telephoneNO = min(telephoneNO) FROM #tempCustomer WHERE telephoneNO > @telephoneNO;
 
    END
END
GO

EXEC InsertCustomer 'E:\Data Base Assignments\Data-Ba-se-Assignment\Correct project File\Docs\Customer.xls'

select * from Customer
delete from Customer

USE [Telephone Companey]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateMonthlyBill](
@telNo Varchar(50),
@year int ,
@month int)
  
AS
BEGIN
 
 SET NOCOUNT ON;
 DECLARE @date date;
 DECLARE @SName varchar(50);
 set @SName = (select s.country from service s, Customer cu where s.ServiceNo = cu.serviceNo )
 BEGIN TRY
  IF(@telNo IS NULL OR @year IS NULL OR @month IS NULL)
   BEGIN
    RAISERROR('Telephone Number, Month and Year are required !',16,1)
    RETURN
   END

CREATE TABLE ##TempTab (
calldate date ,callTime int, destCountry varchar(50),toTel varchar(50) ,duration int,fee Decimal(18,2) );
DECLARE @concat varchar(50);

INSERT INTO ##TempTab
 SELECT c.callDate ,c.callTime ,cc.country AS DestinationCountry, c.toTelephoneNo ,c.duration
 ,dbo.calculateFee(c.fromCode,c.toCode, @SName ,c.callDate ,dbo.IntToTime(c.callDate),c.duration) AS Fee  
  FROM call c
  INNER JOIN Customer ca
  ON ca.telephoneNo = c.fromCode
  INNER JOIN  CallingCode cc
  ON cc.code = c.fromCode
  
  WHERE c.fromTelephoneNo = @telNo 
  AND YEAR(c.callDate) = @year 
  AND MONTH(c.callDate) =@month ;
Select @concat=cu.fName From Customer cu Where cu.telephoneNo =@telNo 
  Select @concat= @concat +' '+cu.lName From Customer cu Where cu.telephoneNo =@telNo
   SET @concat = @concat+' ,'+CAST(@month AS VARCHAR) + '/' +
     CAST(@year AS VARCHAR);
 INSERT INTO OPENROWSET ('Microsoft.ACE.OLEDB.12.0', 
'Excel 12.0;Database=C:\Users\eshe30\Desktop\ReportFiles\MonthlyCustomerBalance.xls;', 
'SELECT Name_Date FROM [Sheet1$]') 
 VALUES(@concat);
 INSERT INTO OPENROWSET ('Microsoft.ACE.OLEDB.12.0', 
'Excel 12.0;Database=C:\Users\eshe30\Desktop\ReportFiles\MonthlyCustomerBalance.xls;', 
'SELECT TotalAmount($) FROM [Sheet1$]')  
  SELECT  SUM(fee) AS TOTAL  FROM ##TempTab 

INSERT INTO OPENROWSET ('Microsoft.ACE.OLEDB.12.0', 
'Excel 12.0;Database=C:\Users\eshe30\Desktop\ReportFiles\MonthlyCustomerBalance.xls;', 
'SELECT callDate,callTime,toCountry,toTelephone,Duration,Fee FROM [Sheet1$]') 
SELECT calldate ,callTime, destCountry,toTel ,duration ,fee   FROM ##TempTab
       ORDER BY calldate , callTime ;

DROP TABLE ##TempTab;
  END TRY
 BEGIN CATCH
 END CATCH
END 
GO



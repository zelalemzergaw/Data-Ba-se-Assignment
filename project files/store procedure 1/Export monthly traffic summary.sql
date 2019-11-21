USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[MonthlyTrafficSummary]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[MonthlyTrafficSummary] 
@fromDate DATE,
@toDate DATE
    AS
BEGIN
    
    SET NOCOUNT ON;             

INSERT INTO OPENROWSET ('Microsoft.ACE.OLEDB.12.0', 
'Excel 12.0;Database=E:\Data Base Assignments\Data-Ba-se-Assignment\project files\project files\MonthlY traffic summary.xlsx;',
'SELECT * FROM [Sheet1$]') 

    SELECT s.name AS ServiceName,s.country AS fromCountry, cc.countryName AS toCountry, sum(c.duration)/60 AS TotalMin
    FROM Service S, Calls C, Customer cus, CallingCode CC
    WHERE cc.code = c.to_code 
    AND cus.telephoneNO  = c.from_tel
    AND s.ServiceNo = cus.serviceNo
    AND  c.call_date BETWEEN @fromDate  AND  @toDate
    GROUP BY s.name,s.country, cc.countryName
     print ERROR_MESSAGE()
END
GO

execute MonthlyTrafficSummary  '11-01-2007','11-30-2007'
 print ERROR_MESSAGE()
 SELECT * FROM SERVICE
 SELECT * FROM Calls
 select * from Customer
 select * from Calls
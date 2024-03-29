USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[MonthlyTrafficSummary] Script Date: 11/20/2019 3:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[MonthlyTrafficSummary] @fromDate DATE, @toDate DATE
	AS
BEGIN
	
	SET NOCOUNT ON; 			

INSERT INTO OPENROWSET ('Microsoft.ACE.OLEDB.12.0', 
'Excel 8.0;Database=E:\Data Base Assignments\Data-Ba-se-Assignment\Correct project File\Docs\Reports\MonthlyTraffic.xls;', 'SELECT * FROM [Sheet1$]') 

	SELECT s.name AS ServiceName,s.country AS fromCountry, cc.countryName AS toCountry, sum(c.duration)/60 AS TotalMin
	FROM Service S, Calls C, Customer cus, CallingCode CC
	WHERE cc.code = c.toCode 
	AND cus.telephoneNo  = c.fromTel
	AND s.ServiceNo = cus.serviceNo
	AND  c.callDate BETWEEN @fromDate  AND  @toDate
	GROUP BY s.name,s.country, cc.countryName
	 
END
GO

exec MonthlyTrafficSummary '11-01-2007','11-30-2007' 

USE [Telephone Companey]
GO

/****** Object:  StoredProcedure [dbo].[monthlySalesRepCommission]  ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[monthlySalesRepCommission]
(@startDate DATE,
@endDate DATE)

AS

BEGIN
INSERT INTO OPENROWSET ('Microsoft.ACE.OLEDB.12.0', 
'Excel 12.0;Database=E:\Data Base Assignments\Data-Ba-se-Assignment\project files\project files\Monthly commision report.xlsx;', 
'SELECT * FROM [Sheet1$]')
SELECT Sr.salesRepID, Sr.fName, Sr.lNmae, SUM(C.commissionRate *CEILING(((case when ca.call_time between  
   s.peakStart and s.peakEnd then r.peak ELSE r.offPeak END)*ca.duration/60) * 100)/100) AS totalCommission
   FROM Sales_Representative SR, Customer C, Calls Ca, dbo.CallingCode cc, dbo.Service s, dbo.Rate r
    WHERE C.salesRepID = SR.salesRepID AND
      Ca.from_tel = C.telephoneNO AND
      Ca.call_date between @startDate AND @endDate and
		s.ServiceNo = C.serviceNo and
		ca.from_tel = C.telephoneNo and
		cc.code = ca.to_code and
		r.code = cc.code 
		
GROUP BY  Sr.salesRepID, Sr.fName, Sr.lNmae
END
GO

select * from service
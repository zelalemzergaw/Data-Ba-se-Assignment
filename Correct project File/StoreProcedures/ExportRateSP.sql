USE [TelephoneCompany]
GO
/****** Object:  StoredProcedure [dbo].[ExportRate] Script Date: 11/20/2019 3:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[ExportRate](
@serviceName varchar(50),
@country varchar(50))

AS

BEGIN


INSERT INTO OPENROWSET ('Microsoft.ACE.OLEDB.12.0', 
'Excel 8.0;Database=D:\DBMS_Project\Docs\Reports\RateReport.xls;', 'SELECT * FROM [Sheet1$]') 


select c.countryName as destinationCountry, R.peak as peakRate, R.offPeak as offPeakRate
   from dbo.Service S, dbo.Rate R, dbo.CallingCode C
   WHERE S.ServiceNo = R.serviceNo and R.code = c.code and S.country = @country and 
   R.effectiveDate = (select MAX(effectiveDate) from dbo.Rate ) and S.name = @serviceName
    ORDER BY C.countryName;
     PRINT ERROR_MESSAGE()

END
GO

execute ExportRate 'spectra', 'USA'

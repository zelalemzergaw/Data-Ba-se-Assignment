USE [Telephone Companey]
GO

/****** Object:  StoredProcedure [dbo].[ExportRate]   ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[ExportRate](
@serviceName varchar(50),
@country varchar(50))

AS

BEGIN

INSERT INTO OPENROWSET ('Microsoft.ACE.OLEDB.12.0', 
'Excel 12.0;Database=E:\Data Base Assignments\Data-Ba-se-Assignment\project files\project files\Rate out put.xlsx;', 
'SELECT * FROM [Sheet1$]') 


select c.countryName as destinationCountry, R.peak AS peakrate, R.offPeak as offpeakrate
   from dbo.Service S, dbo.Rate R, dbo.CallingCode C
   WHERE S.ServiceNo = R.serviceNo and R.code = c.code and S.country = @country and 
   R.effectiveDate = (select Max(effectiveDate) from dbo.Rate ) and S.name = @serviceName
	  ORDER BY C.countryName;
	   PRINT ERROR_MESSAGE()

END
GO

execute ExportRate 'spectra', 'USA'


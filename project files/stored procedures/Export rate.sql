USE [Telephone Companey]
GO
/****** Object: StoredProcedure [dbo].[ExportCurrentRate] Scri*****/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ExportCurrentRate](
@serviceName varchar(50),
@country varchar(50))
AS
BEGIN
INSERT INTO OPENROWSET ('Microsoft.ACE.OLEDB.12.0',
  'Excel 12.0;Database=C:\Users\eshe30\Desktop\ReportFiles\CurrentRate_Budget_USA.xlsx;',
  'SELECT * FROM [Sheet1$]')
  select c.countryName as destinationCountry, R.peakRate, R.offPeakRate
  from dbo.Service S, dbo.Rate R, dbo.CallingCode C
WHERE S.ServiceNo = R.serviceNo and R.code = c.code and S.country = @country and
   R.effectiveDate = (select MAX(effectiveDate) from dbo.Rate ) and S.name =@serviceName
ORDER BY C.code;
END
USE [TelephoneCompany]
GO
/****** Object:  StoredProcedure [dbo].[InsertSalesRepresentative]....*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertSalesRepresentative]

AS
BEGIN
	
	SET NOCOUNT ON;
BEGIN TRY
		
 INSERT INTO Sales_Representative 
 SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
 'Excel 12.0;Database=D:\DBMS_Project\Docs\SalesRep.xls', [Sheet1$])
 
 END TRY
 BEGIN CATCH
     PRINT 'THERE IS ERROR IN THE Sales_Representative DATA'
 END CATCH 
END

--EXEC InsertSalesRepresentative;
--SELECT * FROM Sales_Representative;

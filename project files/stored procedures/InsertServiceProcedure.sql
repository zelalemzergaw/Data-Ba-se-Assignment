USE [TelephoneCompany]
GO
/****** Object:  StoredProcedure [dbo].[InsertServiceProcedure]....*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[InsertServiceProcedure]

AS
BEGIN
	
	SET NOCOUNT ON;
	BEGIN TRY
		
 INSERT INTO Service 
 SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
 'Excel 12.0;Database=D:\DBMS_Project\Docs\Services.xls', [Sheet1$])
 
  END TRY
  BEGIN CATCH
     PRINT 'THERE IS ERROR IN THE SERVICE DATA'
  END CATCH 
END

--SELECT * FROM Service;
--EXEC InsertServiceProcedure;
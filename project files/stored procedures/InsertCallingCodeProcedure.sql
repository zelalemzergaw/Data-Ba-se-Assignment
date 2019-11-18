USE [TelephoneCompany]
GO
/****** Object:  StoredProcedure [dbo].[InsertServiceProcedure]....*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertCallingCode]

AS
BEGIN
	
	SET NOCOUNT ON;
	BEGIN TRY
		
 INSERT INTO CallingCode 
 SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
 'Excel 12.0;Database=D:\DBMS_Project\Docs\calling_codes.xls', [Sheet1$])
 
  END TRY
  BEGIN CATCH
     PRINT 'THERE IS ERROR IN THE CallingCode DATA'
  END CATCH 
END

--EXEC InsertCallingCode;
--SELECT * FROM CallingCode;

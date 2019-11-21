USE [TelephoneCompany]
GO
/****** Object:  StoredProcedure [dbo].[InsertCallingCode] Script Date: 11/20/2019 3:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[InsertCallingCode]  @filePath  NVARCHAR(MAX)

AS
BEGIN
    
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX);

    SET @sql =  N' INSERT INTO CallingCode  SELECT * FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'', ''Excel 8.0;Database='+
         @filePath + ';'' ,''SELECT * FROM [Sheet1$]'')' 
    
        BEGIN TRY
            EXECUTE sp_executesql @sQL;
        END TRY
        BEGIN CATCH
            PRINT 'Some of the records might not be inserted';
        END CATCH;
    
END
GO
EXEC InsertCallingCode 'D:\DBMS_Project\Docs\calling_codes.xls';
SELECT * FROM CallingCode;

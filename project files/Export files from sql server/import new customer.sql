USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[InsertCallingCode]    Script Date: 11/18/2019 1:44:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertCustomer]  @filePath  NVARCHAR(MAX)

AS
BEGIN
    
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX);

    SET @sql =  ' INSERT INTO customer  SELECT * FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'', ''Excel 12.0;Database='+
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

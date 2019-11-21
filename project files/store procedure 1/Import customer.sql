USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[InsertCallingCode]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertCustomer] @filePath  NVARCHAR(MAX)

AS
BEGIN
    
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX);

    SET @sql =  ' INSERT INTO [dbo].[customer]  SELECT * FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'', ''Excel 12.0;Database='+
         @filePath + ';'' ,''SELECT * FROM [Sheet1$]'' )' 
    
        BEGIN TRY
            EXECUTE sp_executesql @sQL;
        END TRY
        BEGIN CATCH
            PRINT 'Some of the records might not be inserted';
        END CATCH;
    
END
GO
EXEC InsertCallingCode 'D:\givenfiles\Customer.xls';
SELECT * FROM Customer;

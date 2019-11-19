USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[InsertSalesRepresentative] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[InsertSalesRepresentative]@filePath  NVARCHAR(MAX)

AS
BEGIN
    
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX);

    SET @sql =  N' INSERT INTO Sales_Representative  SELECT * FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'', ''Excel 8.0;Database='+
         @filePath + ';'' ,''SELECT * FROM [Sheet1$]'')' 
    
        BEGIN TRY
            EXECUTE sp_executesql @sQL;
        END TRY
        BEGIN CATCH
            PRINT 'Some of the records might not be inserted';
        END CATCH;
    
END
GO

EXEC InsertSalesRepresentative 'D:\givenfiles\SalesRepresentative.xls';
SELECT * FROM Sales_Representative;


USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[InsertSalesRepresentative] Script Date: 11/20/2019 3:17:19 PM ******/
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

EXEC InsertSalesRepresentative 'E:\Data Base Assignments\Data-Ba-se-Assignment\Correct project File\Docs\SalesRep.xls';
SELECT * FROM Sales_Representative;


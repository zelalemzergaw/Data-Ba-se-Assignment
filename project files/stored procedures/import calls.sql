USE [Telephone Companey]
GO

/****** Object:  StoredProcedure [dbo].[InsertCall]   ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[InsertCall]
	@filePath  NVARCHAR(MAX),
	@sheetName NVARCHAR(MAX) 

AS
BEGIN	
	SET NOCOUNT ON;

	DECLARE @sql NVARCHAR(MAX);

	SET @sql =  ' INSERT INTO Calls SELECT * FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'', ''Excel 8.0;Database='+ @filePath + ';'' ,''SELECT * FROM ['+ @sheetName +'$]'')' 
	
	
		EXECUTE sp_executesql @sQL;

	print @sql

END
GO
--execute InsertCall 'D:\givenfiles\Calls_Dec_2007.xls','Dec_calls'
--execute InsertCall 'D:\givenfiles\Calls_Dec_2007.xls','Jan_2008_calls'
--execute InsertCall 'D:\givenfiles\Calls_Dec_2007.xls','Jan15_2008_calls'
SELECT * FROM Calls
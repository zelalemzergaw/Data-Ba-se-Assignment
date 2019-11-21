USE [Telephone Companey] 
GO
/** Object:  StoredProcedure [dbo].[AddNewCall]    Script Date: 11/20/2019 11:12:41 PM **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[ImportCall]
	@filePath  NVARCHAR(MAX)
AS
BEGIN	
	SET NOCOUNT ON;

	DECLARE @query NVARCHAR(MAX);
	DECLARE @tableName NVARCHAR(MAX);
	DECLARE @sheetName NVARCHAR(MAX);

	--DECLARE @valid BIT = 1;
	--DECLARE @validCountryCode BIT = 1;
	--DECLARE @validTelephoneNo BIT = 1;

	SET @tableName = 'Call'
	SET @sheetName = 'Nov_Calls'

--============================================================================================================

	--SET @validTelephoneNo = (SELECT COUNT(*) from Customer where telephoneNo = @telephoneNo);
	--SELECT @serviceNo =  ServiceNo from Service where countryCode = @countryCode AND serviceNo = @serviceNo;

	SET @query =  'INSERT INTO '+@tableName + ' SELECT * FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',
				  ''Excel 12.0;DATABASE='+ @filePath + ''',''SELECT * FROM ['+ @sheetName +'$]'')' 

	BEGIN TRY
		EXECUTE sp_executesql @query;
		PRINT 'Insert successful.'
	END TRY
	BEGIN CATCH
	    PRINT @query
		PRINT 'Sorry, inserting the file was not successful.'
		print ERROR_MESSAGE()
	END CATCH;
	
END
USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[AddNewCallingCode]  Script Date: 11/20/2019 3:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddNewCallingCode]
       @newCountry varchar(50),
	   @newCode int 
AS
BEGIN 
	SET NOCOUNT ON; 

	DECLARE @country varchar(50);
	DECLARE @code int; 
	DECLARE @valid bit = 1

IF(SELECT COUNT(countryName) FROM CallingCode WHERE countryName = @newCountry) > 0 
BEGIN 
	SET @valid = 0; 
	PRINT 'Country already registered.';
END

IF(SELECT COUNT(code) FROM CallingCode WHERE code = @newCode) > 0 
BEGIN 
	SET @valid = 0; 
	PRINT 'The code belongs to another country.';
END

IF @valid = 0 
BEGIN
	PRINT 'Can not add new calling code'; 
	RETURN; 
END
ELSE 
BEGIN
	INSERT INTO [dbo].[CallingCode] 
	([countryName]
	,[code])
		VALUES 
	(@newCountry, @newCode) 
	PRINT 'Success: calling call is added.'; 
	END 
	BEGIN
	SELECT * FROM CallingCode 
	ORDER BY countryName,code
	END
END

EXEC AddNewCallingCode 'Test',1222 ;
SELECT * FROM CallingCode 
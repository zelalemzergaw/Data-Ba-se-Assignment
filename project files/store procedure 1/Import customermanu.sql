USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[NewCustomer]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ImportCustomer]
(@filePath  NVARCHAR(MAX))


AS
BEGIN
	
	SET NOCOUNT ON;
	BEGIN TRY
		
	INSERT INTO Customer
	SELECT * FROM 
	  OPENROWSET('Microsoft.ACE.OLEDB.12.0',
	'Excel 12.0; Database=E:\Data Base Assignments\Data-Ba-se-Assignment\project files\givenfiles\Customer1.xls; HDR=YES; IMEX=0;',
	'SELECT * FROM [Sheet1$]') 
 
  END TRY
  BEGIN CATCH
     PRINT 'THERE IS ERROR IN THE CUSTOMER DATA'
  END CATCH
    
END
select * from service
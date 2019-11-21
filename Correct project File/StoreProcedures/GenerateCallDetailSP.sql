USE [TelephoneCompany]
GO
/****** Object:  StoredProcedure [dbo].[GenerateCallDetail] Script Date: 11/20/2019 3:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GenerateCallDetail]
  @fromDate date,
  @toDate date
AS
BEGIN

  SET NOCOUNT ON;
  DECLARE @valid bit = 1;

  IF @fromDate > GETDATE()
  BEGIN
    SET @valid = 0;
    RAISERROR('Invalid from date', 11, 1);    
    RETURN;
  END
  IF @toDate > GETDATE()
  BEGIN
    SET @valid = 0;
    RAISERROR('Invalid to date', 11, 1);
    RETURN;
  END

  IF @fromDate > @toDate
  BEGIN
    SET @valid = 0;
    RAISERROR('Invalid from date', 11, 1);    
    RETURN;
  END
  
  IF @valid = 1

  BEGIN

INSERT INTO OPENROWSET ('Microsoft.ACE.OLEDB.12.0', 
'Excel 8.0;Database=D:\DBMS_Project\Docs\Reports\CallDetail.xls;', 'SELECT * FROM [Sheet1$]') 

    SELECT fromCode, toCode, fromTel, toTel,duration, callDate, callTime
    FROM Calls
    WHERE callDate between @fromDate and @toDate
  END
  ELSE
    PRINT 'Invalid input'  
END
GO

exec GenerateCallDetail '11-05-2007','12-30-2007'
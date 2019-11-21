USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[InsertRate]   ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[InsertRate]
  @filePath NVARCHAR(MAX)
AS
BEGIN
  
  SET NOCOUNT ON;

  DECLARE @effectiveDateString varchar(50);
  DECLARE @effectiveDate date;
  DECLARE @ServiceCursor CURSOR;
  DECLARE @SNo int;
  DECLARE @SQL NVARCHAR(MAX);
  SET @effectiveDateString = SUBSTRING(reverse(left(reverse(@filePath), charindex('\',reverse(@filePath), 1) - 1)), 7, 8);
  SET @effectiveDate = CONVERT(date, SUBSTRING(@effectiveDateString, 5, 2)+'/'+SUBSTRING(@effectiveDateString, 7, 2)+'/'+SUBSTRING(@effectiveDateString, 1, 4), 101);
  
  
  BEGIN
    
    SET @ServiceCursor = CURSOR FOR
    SELECT ServiceNo from Service;
    OPEN @ServiceCursor;
    FETCH NEXT FROM @ServiceCursor INTO @SNo;
    WHILE @@FETCH_STATUS = 0
    BEGIN
  
      DECLARE @SheetName varchar(100);
      SELECT @SheetName = name + '_' + country FROM Service WHERE ServiceNo = @SNo;
            SET @SQL =  ' INSERT INTO Rate SELECT ''' + CAST(@effectiveDate as varchar) + 
      ''' as effectiveDate, dest, peak, offPeak, '+CAST(@SNo as varchar)+' 
      as serviceNo FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'', ''Excel 12.0;Database=' 
      + @filePath +';'', ''SELECT * FROM ['+ @SheetName +'$]'')';
    

      
        PRINT 'EFFECTIVE'
        PRINT @effectiveDate
          PRINT 'EFFECTIVEDATESTRING'
        PRINT  @effectiveDateString
        PRINT 'SHEETnAME'
         PRINT @SQL 

      BEGIN TRY
        EXECUTE sp_executesql @SQL;
      END TRY
      BEGIN CATCH
      END CATCH;
      FETCH NEXT FROM @ServiceCursor INTO @SNo;
      
    END; 
    CLOSE @ServiceCursor;
    DEALLOCATE @ServiceCursor;
    
  END;   
END
GO
EXECUTE InsertRate 'E:\Data Base Assignments\Data-Ba-se-Assignment\project files\givenfiles\rates_20070901.xls'
EXECUTE InsertRate 'E:\Data Base Assignments\Data-Ba-se-Assignment\project files\givenfiles\rates_20071215.xls'
EXECUTE InsertRate 'E:\Data Base Assignments\Data-Ba-se-Assignment\project files\givenfiles\rates_20080101.xls'
SELECT * FROM Rate
USE [TelephoneCompany]
GO
/****** Object:  StoredProcedure [dbo].[ImportCall] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ImportCalls] @path  VARCHAR(255),
                                   @sheet VARCHAR(255)
AS

     DECLARE @callsID int, @fromtel bigint, @calldate date, @callTime time, @fromcode int,
	 @tocode int, @totel bigint, @duration int, @sql VARCHAR(1000);

     CREATE TABLE #TempCall
     ( callsID INT IDENTITY(1,1) NOT NULL, fromtel  bigint, calldate date,
      callTime time, fromcode int, tocode   int, totel    bigint, duration  int )

     SET @sql = 'INSERT INTO #TempCall SELECT  from_code, to_code,from_tel,to_tel,duration, call_date, 
	 SUBSTRING(CAST(call_time AS VARCHAR(10)),  1,
	 LEN(CAST(call_time AS VARCHAR(10))) - 2) + '':'' + SUBSTRING(CAST(call_time AS VARCHAR(10)), LEN(CAST(call_time AS VARCHAR(10))) - 1, 2) AS callTime 
	 FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 8.0; Database=' + @path + ''', [' + @sheet + '$])';
     EXEC (@sql);
     DECLARE @count INT= 0;
     SELECT @count = COUNT(1) FROM #TempCall;

WHILE @count <> 0
BEGIN
  SELECT TOP 1 @callsID = callsID, @fromtel = fromtel, @calldate = calldate, @callTime = callTime,
  @fromcode = fromcode,@tocode = tocode,@totel = totel,@duration = duration
	FROM #TempCall;
		DECLARE @size INT= 0;
		SELECT @size = COUNT(*) FROM [Calls] c WHERE c.callsId = @callsID;
			IF @size = 0
			INSERT INTO Calls (fromcode,tocode, fromTel,toTel,duration, calldate,callTime)
			VALUES (@fromcode, @tocode, @fromtel,@totel, @duration, @calldate,@callTime);
			ELSE
			UPDATE Calls
				SET fromcode = @fromcode,tocode = @tocode, toTel = @totel,duration = @duration WHERE fromTel = @fromtel
                       AND calldate = @calldate AND calltime = @callTime;
             DELETE FROM #TempCall WHERE callsID = @callsID;
             SET @count = @count - 1;
END
Go

EXEC ImportCalls 'D:\DBMS_Project\Docs\Calls_Dec_2007.xls','Dec_calls'
EXEC ImportCalls 'D:\DBMS_Project\Docs\Calls_Jan_2008.xls','Jan_2008_calls'
EXEC ImportCalls 'D:\DBMS_Project\Docs\calls_jan15_2008.xls','Jan15_2008_Calls'
EXEC ImportCalls 'D:\DBMS_Project\Docs\Calls_Nov_2007.xls','Nov_call'



USE [Telephone Companey]
GO
/****** Object:  StoredProcedure [dbo].[ImportCall]    Script Date: 11/20/2019 11:43:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ImportCall] @path  VARCHAR(255),
                                   @sheet VARCHAR(255)
AS
     DECLARE @call_code int, @from_tel bigint, @call_date DATE, @call_time time, @from_code INT, 
  @to_code INT, @to_tel bigint, @duration INT, @ssql VARCHAR(500);
     CREATE TABLE #Temp_Call
     ( call_code      INT NOT NULL IDENTITY, from_tel  bigint,
      call_date DATE,
      call_time time,
      from_code INT,
      to_code   INT,
      to_tel    bigint,
      duration  INT
     );

     SET @ssql = 'INSERT INTO #Temp_Call SELECT from_tel,
call_date,SUBSTRING(CAST(call_time AS VARCHAR(10)),  1,
LEN(CAST(call_time AS VARCHAR(10))) - 2) + '':'' +
SUBSTRING(CAST(call_time AS VARCHAR(10)),
LEN(CAST(call_time AS VARCHAR(10))) - 1, 2) AS  call_time,
 from_code, to_code, to_tel,
 duration FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',
 ''Excel 12.0; Database=' + @path + ''', [' + @sheet + '$])';


     EXEC (@ssql);

     DECLARE @count INT= 0;
     SELECT @count = COUNT(1)
     FROM #Temp_Call;
     WHILE @count <> 0
         BEGIN
             SELECT TOP 1 @call_code = call_code,
             @from_tel = from_tel,
                          @call_date = call_date,
                          @call_time = call_time,
                          @from_code = from_code,
                          @to_code = to_code,
                          @to_tel = to_tel,
                          @duration = duration
             FROM #Temp_Call;
             DECLARE @size INT= 0;
             SELECT @size = COUNT(*)
             FROM [Calls] c
             WHERE c.callsId = @call_code;
             IF @size = 0
                 INSERT INTO calls
                 (fromTel,
                  callDate,
                  calltime,
                  fromcode,
                  tocode,
                  totel,
                  duration
                 )
                 VALUES
                 (@from_tel,
                  @call_date,
                  @call_time,
                  @from_code,
                  @to_code,
                  @to_tel,
                  @duration
                 );
                 ELSE
                 UPDATE calls
                   SET
                       fromcode = @from_code,
                       tocode = @to_code,
                       totel = @to_tel,
                       duration = @duration
                 WHERE fromtel = @from_tel
                       AND calldate = @call_date
                       AND calltime = @call_time;
             DELETE FROM #Temp_Call
             WHERE call_code = @call_code;
             SET @count = @count - 1;
    END;

EXEC ImportCall 'E:\Data Base Assignments\Data-Ba-se-Assignment\Correct project File\Docs\Calls_Dec_2007.xls','Dec_calls' 
EXEC ImportCall 'E:\Data Base Assignments\Data-Ba-se-Assignment\Correct project File\Docs\Calls_Jan_2008.xls','Jan_2008_calls'
EXEC ImportCall 'E:\Data Base Assignments\Data-Ba-se-Assignment\Correct project File\Docs\calls_jan15_2008.xls','Jan15_2008_Calls'
EXEC ImportCall 'E:\Data Base Assignments\Data-Ba-se-Assignment\Correct project File\Docs\Calls_Nov_2007.xls','Nov_calls'
   select * from Calls;
   DELETE FROM Calls;
Declare @TempID varchar(4) = 99,
@TempName VARCHAR(225) = '';
SELECT @TempID = hotelNo,
@TempName = hotelName
FROM Hotel
ORDER BY hotelNo;
SELECT @TempName = @TempName + ',' + hotel.hotelName
FROM Hotel;
SELECT @TempID AS ID, @TempName AS Name;

Go 
select *from hotel

DECLARE @count int =0;
 while(@count<6)
 begin
 print @count 
 set @count=@count+1
 end
 go
 CREATE PROCEDURE
getCustomerDetails
(@custName varchar(50))
AS
BEGIN
SELECT * FROM hotel
WHERE hotelName = @custName;
END
EXEC getCustomerDetails joh

go
create procedure globallocal(@country varchar(40))
as 
begin
create table #newTable(id int,fName varchar(50));
select * from #newTable
insert into #newTable values(1,'thomas')

create table ##newTable(id int,fName varchar(50));
select * from ##newTable
insert into ##newTable values(1,'thomas')
end


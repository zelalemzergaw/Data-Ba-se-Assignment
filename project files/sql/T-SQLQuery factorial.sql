Alter procedure getFactorial(@number int)
as 
begin
set nocount on
Declare @fact int = 1,
@result int=1
if(@number<0)
print 'no negative value is alowed';
else
begin
while (@fact<=@number)
Begin
	Set @result = @result * @fact
	Set @fact += 1
End
Select convert(varchar,@number)+'!='+convert(varchar,@result)
end
End
exec getFactorial -5;
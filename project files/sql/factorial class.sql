
Alter procedure getFactorial(@factorial int)
as 
begin

Declare @fact int =1 ,
   @val int=1
while (@fact>=@factorial)
Begin
	Set @val = @val * @fact
	Set @fact +=1
End
Select @val
End
GO

EXEC getFactorial 5;
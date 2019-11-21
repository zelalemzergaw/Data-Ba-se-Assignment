
ALTER PROCEDURE insertEmployer( @ssn varchar(50),
@name varchar(50), @position varchar(50), @dep int,
@salary money)

AS
DECLARE @count int = 0 
SELECT	@count = COUNT(*) FROM Employee
WHERE @ssn = ssn AND @name = name

if @count = 0 
BEGIN
INSERT INTO Employee VALUES(@ssn,@name,@position,@dep,@salary)
print 'Employee record added'
END ELSE
print 'Employee already exist . . . '



EXECUTE	insertEmployer	1010,'Tare','developer',1,100000;
EXECUTE	insertEmployer	1020,'Abela','accountant',6,00000;
EXECUTE	insertEmployer	1030,'Zola','tester',7,100000
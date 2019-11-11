USE CS422
GO
SET ANSI_NULLS ON
GO

ALTER procedure Compute_Tax
AS
BEGIN
create table Tax(SSN varchar(20),
	IncomeTax decimal)
	

INSERT INTO Tax
	SELECT empl.SSN,
	(CASE WHEN empl.netsalary>=15000 
			THEN 0.1*15000 
		ELSE 
		0.1*empl.netsalary 
		END +
		
	CASE WHEN empl.netsalary>=30000 
	   THEN 0.15*15000 
	   ELSE 
	CASE WHEN empl.netsalary>=15000 
		THEN 0.15*(empl.netsalary-15000)
		ELSE 0 end END +
	CASE WHEN empl.netsalary>=30000 
		THEN 0.28*(empl.netsalary-30000) 
		ELSE 0  END ) 
		
	AS IncomeTax from (select ssn ,(anualSalary-(7000+dependents*950)) as netSalary from dbo.Employee) AS empl;
END
select * from Tax;
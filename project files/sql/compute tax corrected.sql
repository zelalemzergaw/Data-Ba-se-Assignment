
--create employees table
create table Employees(SSN varchar(15) primary key NOT NULL,
	name varchar(20),position varchar(20),
	dependents int,anualSalary smallmoney);
Insert into Employee(SSN,name,position,dependents,anualSalary) 
     values('112-425-7896','tare','Accountant',2,95000),
    ('112-425-1247','zola','developer',1,105000),
   ('104-425-7896','abela','Accountant',2,95000);
select * from  Employee
--create a compute tax store procedure
create procedure compute_tax(@sal int)
as 
begin
declare @tax float
	if @sal>=



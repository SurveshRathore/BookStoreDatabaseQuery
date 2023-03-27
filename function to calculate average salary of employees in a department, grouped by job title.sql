--Create a stored function in sql server to calculate the average salary of employees in a department, grouped by job title
create database review

use review

create table employees 
(
	empID int primary key identity(100,1),
	empName varchar(255),
	empDepartment varchar(255),
	empSalary int,
	empJob varchar(255)

)

insert into employees(empName, empDepartment, empSalary, empJob) values ('ABC', 'HR', 10000, 'hr1')
insert into employees(empName, empDepartment, empSalary, empJob) values ('QWE', 'HR', 8000, 'hr2')
insert into employees(empName, empDepartment, empSalary, empJob) values ('ASD', 'HR', 5000, 'hr2')
insert into employees(empName, empDepartment, empSalary, empJob) values ('ZXC', 'DEVELOPER', 10000, 'junior')
insert into employees(empName, empDepartment, empSalary, empJob) values ('RTY', 'DEVELOPER', 8000, 'intern')
insert into employees(empName, empDepartment, empSalary, empJob) values ('UIO', 'DEVELOPER', 50000, 'senior')
insert into employees(empName, empDepartment, empSalary, empJob) values ('IOP', 'DEVELOPER', 70000, 'senior')
insert into employees(empName, empDepartment, empSalary, empJob) values ('SDF', 'DEVELOPER', 100000, 'senior')
insert into employees(empName, empDepartment, empSalary, empJob) values ('SDG', 'DEVELOPER', 10000, 'sa1')
insert into employees(empName, empDepartment, empSalary, empJob) values ('GHJ', 'DEVELOPER', 10000, 'junior')
insert into employees(empName, empDepartment, empSalary, empJob) values ('LKJ', 'DEVELOPER', 8000, 'intern')
insert into employees(empName, empDepartment, empSalary, empJob) values ('MNB', 'DEVELOPER', 50000, 'junior')
insert into employees(empName, empDepartment, empSalary, empJob) values ('TGV', 'DEVELOPER', 70000, 'junior')
insert into employees(empName, empDepartment, empSalary, empJob) values ('VFG', 'HR', 100000, 'hr1')
insert into employees(empName, empDepartment, empSalary, empJob) values ('KJH', 'HR', 10000, 'hr1')

select empJob, sum(empSalary) from employees  group by empJob 
select empJob, avg(empSalary) from employees where empDepartment = 'DEVELOPER'  group by empJob 
select empJob, avg(empSalary) from employees where empDepartment = 'HR'  group by empJob 




CREATE FUNCTION CalculateAverageSalaryByDepartmentJobTitle 
(
	@empDepartment VARCHAR(50)
)
RETURNS TABLE
AS
RETURN (
    SELECT empJob, AVG(empSalary) as avg_salary
    FROM employees
    WHERE empDepartment = @empDepartment
    GROUP BY empJob
);

SELECT * FROM CalculateAverageSalaryByDepartmentJobTitle('DEVELOPER')
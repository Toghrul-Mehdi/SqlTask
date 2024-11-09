Create database praktika

Create table Employees(
employee_id int primary key identity,
name nvarchar(20) not null,
position nvarchar(30) not null,
department_id int foreign key references Departments(department_id),
salary decimal(8,2) not null,
Check(salary>0)
)

Create table Departments(
department_id int primary key identity,
department_name nvarchar(20) not null
)

Create table Projects(
project_id int primary key identity,
project_name nvarchar(30) not null unique,
budget decimal(10,2) not null,
Check(budget>0),
department_id int foreign key references Departments(department_id)
)

Create table Employee_Projects(
employee_id int foreign key references Employees(employee_id),
project_id int foreign key references Projects(project_id),
hours_worked int,
Check(hours_worked>0)
)


select * from Departments
select * from Employees
select * from Projects
select * from Employee_Projects


--Görev: Tüm çalışanların isimlerini ve pozisyonlarını listeleyin.

Select [name] as [Workers Name],position as [Workers Position] from Employees


--Görev: Maaşı 6000’in üzerinde olan çalışanları listeleyin.

Select [name] as [Workers Name],salary as [Workers Salary] from Employees
Where salary>4500;


--Görev: Çalışanların isimlerini ve çalıştıkları departman isimlerini listeleyin.

Select [name] as [Workers Name],department_name as [Department's Name] from Employees
Join Departments on Employees.department_id = Departments.department_id;

--Görev: Çalışanların hangi projelerde çalıştıklarını listeleyin (çalışan adı, proje adı).

Select [name] as [Worker's Name], project_name as [Worker's Project]  from Employees
Join Employee_Projects on Employees.employee_id = Employee_Projects.employee_id
Join Projects on Employee_Projects.project_id = Projects.project_id


--Görev: Her departmandaki toplam maaş miktarını listeleyin.

Select Departments.department_name as [Department's Name] , Sum(Employees.salary) as [Total Salary]
From Employees
Join Departments on Departments.department_id = Employees.department_id
Group By Departments.department_name;

--Görev: Her projede toplam çalışılan saat sayısını bulun.

Select p.project_name as [Project's Name], Sum(Employee_Projects.hours_worked) as [Total Hours]  from Projects p
Join Employee_Projects on Employee_Projects.project_id = p.project_id
Group By p.project_name;

--Görev: En yüksek maaşa sahip çalışanı bulun.

Select name as [Worker's Name], salary as [Max Salary] from Employees 
Where salary = (Select Max(salary) from Employees);

--Görev: Çalışanların maaş ortalamasının üzerinde maaş alan çalışanları listeleyin.

Select name as [Worker's Name] , salary as [Worker's Salary] from Employees
Where salary > (Select Sum(Employees.salary)/Count(Employees.salary) from Employees);


--Görev: Proje başına ortalama çalışılan saatleri listeleyin ve ortalamadan fazla çalışanları bulun.

Select name as [Worker's Name],project_name as [Project's Name],Employee_Projects.hours_worked as [Project's Total Hours] from Employees
Join Employee_Projects on Employees.employee_id = Employee_Projects.employee_id
Join Projects on Projects.project_id = Employee_Projects.project_id
Where hours_worked > (Select Avg(hours_worked) from Employee_Projects Where Projects.project_id = Employee_Projects.project_id )

--Görev: En yüksek bütçeye sahip projeyi listeleyin ve bu projede çalışanları gösterin.

Select name as [Worker's Name], Projects.project_name as [Project's Name], Projects.budget as [Project's Budget] from Employees
Join Employee_Projects on Employee_Projects.employee_id = Employees.employee_id
Join Projects on Projects.project_id = Employee_Projects.project_id
Where budget = (Select Max(budget) from Projects )

--Görev: Her departman için, o departmanda çalışanların toplam maaşı, en düşük maaş,
--en yüksek maaş, çalışan sayısı ve projelerde harcadıkları toplam saatleri listeleyin.

Select Departments.department_name as [Department's Name],
Count(Employees.employee_id) as [Worker's Count],
SUM(Employees.salary) as [Department's Salary],
Min(Employees.salary) as [Department's Min Salary],
MAX(Employees.salary) as [Department's Max Salary],
COALESCE(SUM(Employee_Projects.hours_worked), 0) AS [Total Hours]
from Departments
Left Join Employees on Employees.department_id = Departments.department_id
Left Join Employee_Projects on  Employee_Projects.employee_id = Employees.employee_id
Group By Departments.department_name






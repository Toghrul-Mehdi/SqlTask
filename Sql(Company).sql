Create Database Company

Create Table Employ(
EmpId int primary key identity,
EmpName nvarchar(20) not null,
EmpSurname nvarchar(20) not null,
EmpSalary decimal(6,2) not null,
EmpEmail  nvarchar(30)  not null,
EmpDepartmentName nvarchar(20) not null
);

Select * from Employ


insert into Employ
Values('Togrul','Mehdiyev',450,'togrul@gmail.com','Bravo'),('Turan','Mirzeyev',650,'turan@gmail.com','Araz');

select *from Employ 
Where EmpSalary>500;

SELECT CONCAT(EmpName, ' ', EmpSurname) AS full_name
FROM Employ;

select *from Employ 
Where EmpSalary>500 and EmpSalary<2500;

select *from Employ
Where EmpName LIKE '%a%';


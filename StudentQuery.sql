Create Database BP215


Create Table Student(
StudentId Int identity(1,1) primary key,
StudentName nvarchar(20),
StudentSurname nvarchar(20),
StudentAge Int,
AvgPoint decimal
);

insert into Student(StudentName,StudentSurname,StudentAge,AvgPoint)
Values('Dadash','Dadashov',21,92),
('Rafa','Silva',22,93),
('Ricardo','Quaresma',33,100);

select *from Student

select *from Student
Where AvgPoint>51;

select *from Student
Where AvgPoint>51 and AvgPoint<90;

select *from Student 
Where StudentName Like 'A%i';




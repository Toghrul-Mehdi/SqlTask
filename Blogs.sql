Create database BlogsDB

Create Table Categories(
CategoriesID int primary key identity,
CategoriesName nvarchar(20) not null unique
);

Create Table Tags(
TagsID int primary key identity,
TagsName nvarchar(30) not null unique
);

Create Table Users(
UsersID int primary key identity,
UsersName nvarchar(30) not null unique,
FullName nvarchar(20) not null,
UsersAge int not null,
Check(UsersAge>0 and UsersAge<150)
);

Create Table Comments(
CommentsID int primary key identity,
CommentsContent nvarchar(400) not null unique,
UsersID int foreign key references Users(UsersID),
BlogsID int foreign key references Blogs(BlogsID)
);

Create Table Blogs(
BlogsID int primary key identity,
BlogsTitle nvarchar(50) not null,
BlogsDescription nvarchar(400) not null,
UsersID int foreign key references Users(UsersID),
CategoriesID int foreign key references Categories(CategoriesID)
);

Create Table BlogTags(
BlogsID int foreign key references Blogs(BlogsId),
TagsID int foreign key references Tags(TagsID),
Primary key(BlogsId,TagsId)
);

--1. Blogs'un Title, Users'in userName ve fullName columnlarini qaytaran view yazirsiniz.

Create View BlogUserData As
Select Blogs.BlogsTitle as [Blog Title],Users.UsersName as [User Name],Users.FullName as [Full Name]
From Users
Join Blogs on Blogs.UsersID=Users.UsersID;

Select * from BlogUserData

--2. Blogs'un Title, Categories'in Name columnlarini qaytaran view. 

Create View BlogCategory As
Select Blogs.BlogsTitle as [Blog Title],Categories.CategoriesName as [Category Name]
From Blogs
Join Categories on Categories.CategoriesID= Blogs.CategoriesID;

Select * from BlogCategory


--3. @userId parametri qebul edib hemin parametre uygun userin yazdigi commentleri qaytaran procedure yazirsiniz.

alter Procedure UserComment @userId int As
Select Comments.CommentsContent as [Comment] 
From Comments
Where Comments.UsersID=@userId;

Exec UserComment 1;

--4. @userId parametri qebul edib hemin parametre uygun userin bloglarini qaytaran procedure yazirsiniz.

Create Procedure UserBlog @userId int As
Select Blogs.BlogsTitle as [Blogs] 
From Blogs
Where Blogs.UsersID=@userId;

Exec UserBlog 2;


--5. Parametr olaraq, @categoryId qebul edib, hemin parametre Bloglarin sayini geri qaytaran function yazirsiniz. 

Create Function BlogsCount (@categoryId int)
Returns int
As
Begin
Declare @blogscount int
Select @blogscount=Count(*) from Blogs
Where Blogs.CategoriesID = @categoryId;
return @blogscount
end

Select dbo.BlogsCount(2) as BlogsCount


--6. Parametr olaraq, @userId qebul edib, hemin user'in yaratdigi bloglari table kimi geri qaytaran function yazirsiniz. 

Create Function UsersBlogs (@userId int)
returns table
As
Return(
Select Blogs.BlogsTitle as [Blogs] from Blogs
Where Blogs.UsersID = @userId
);

Select * from dbo.UsersBlogs(1);




--7. Blog datasi silindiyi zaman o datanin isDeleted columnun deyerini true eden bir trigger yazirsiniz. 


alter table Blogs
add isDeleted bit not null default 0;

Create Trigger trigger_Blogs 
on Blogs
for delete
as
begin 
update Blogs
set isDeleted=1
Where Blogs.BlogsID in (select BlogsID from deleted);
end;

--Blogu geri qaytarma
update Blogs
set isDeleted = 0
where BlogsID = 1;







----Create Database Books

Create Table Book(
book_id int primary key identity,
book_name nvarchar(100) not null unique Check(len(book_name)>2),
author_id int foreign key references Author(author_id),
page_count int Check(page_count >=10)
);

Create Table Author(
author_id int primary key identity,
author_name nvarchar(30) not null,
author_surname nvarchar(30) not null
);


-- Id,Name,PageCount ve AuthorFullName columnlarinin valuelarini qaytaran bir view yaradin

Create View FullData 
As
Select 
Book.book_id as [Book ID], 
Book.book_name as [Book's Name], 
Book.page_count as [Book's Page Count],
(Author.author_name+' '+Author.author_surname) as [AuthorFullName]
from Book 
Left Join Author on Author.author_id = Book.author_id

Select * from FullData


--Gonderilmis axtaris deyirene gore hemin axtaris deyeri name ve ya authorFullNamelerinde olan 
--Book-lari Id,Name,PageCount,AuthorFullName columnlari seklinde gostern procedure yazin

Create Procedure SearchAuthor (@name nvarchar(30))
As
Begin
Select 
Book.book_id as [Book ID], 
Book.book_name as [Book's Name], 
Book.page_count as [Book's Page Count],
(Author.author_name+' '+Author.author_surname) as [AuthorFullName]
from Book 
Left Join Author on Author.author_id = Book.author_id
Where @name = author_name
End;


Exec SearchAuthor 'J.K.'


--Authors tableinin insert,update ve deleti ucun (her biri ucun ayrica) procedure yaradin


--INSERT

Create Procedure InsertData (@name nvarchar(30) , @surname nvarchar(30))
As
Begin
Insert Into Author Values
(@name,@surname)
End;

Exec InsertData 'Abdulla','Shaiq'


--UPDATE

Create Procedure UpdateData (@authorID int,@name nvarchar(30),@surname nvarchar(30))
As
Begin 
Update Author
Set author_name = @name , author_surname = @surname
Where author_id = @authorID
End;

Exec UpdateData 1,'George','Orwell'

--DELETE

Create Procedure DeleteData (@authorID int)
As
Begin
Delete Author
Where author_id = @authorID
End;

Exec DeleteData 11




--Authors-lari Id,FullName,BooksCount,MaxPageCount seklinde qaytaran view yaradirsiniz 
--Id-author id-si, FullName - Name ve Surname birlesmesi, 
--BooksCount - Hemin authorun elaqeli oldugu kitablarin sayi, 
--MaxPageCount - hemin authorun elaqeli oldugu kitablarin icerisindeki max pagecount deyeri

Create View DataForAuthor
As
Select
Author.author_id as [Author's ID],
author_name+' '+author_surname as [FullName],
Count(Book.book_id) as [Book's Count],
Max(Book.page_count) as [MaxPageCount]
from Book
Left Join Author on Book.author_id = Author.author_id
Group By Author.author_id,author_name,author_surname

Select * from DataForAuthor
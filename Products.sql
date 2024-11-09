Create Database Market

Create Table Products(
PrdId int primary key identity,
[Name] nvarchar(20) not null Default 'XXX',
Price Decimal(6,2) not null,
CtgId int foreign key references Categories(CtgId)
);

Create Table Categories(
[Name] nvarchar(20) not null,
CtgId int primary key identity
);


Create Table Colors(
[Name] nvarchar(20) not null,
ColorId int primary key identity
);


CREATE TABLE ProductColors (
    PrdId int foreign key references Products(PrdId),
    ColorId int foreign key references Colors(ColorId),
    PRIMARY KEY (PrdId, ColorId)  
);

Insert into Categories
Values('Drink'),('Fresh'),('Meat');

Insert into Products
Values ('Sirab 19L',10.5,1),('Dana Eti Premium',24.99,3),('Sizlik Sud 1L',1.99,2);

Insert into Colors
Values('White'),('Blue'),('Red');

Insert into ProductColors(PrdId, ColorId)
Values(1,2),(1,1),(2,3),(3,1);





Select *From Products
Select *From Categories
Select *From Colors
Select *From ProductColors


Select Products.PrdId,Products.[Name],Products.Price,Categories.[Name] as CategoryName
From Products
Join Categories on Categories.CtgId = Products.CtgId


Select 
    Products.Name as ProductName,
    Products.Price,
    Categories.Name as CategoryName,
    Colors.Name as ColorName
From 
    Products
JOIN 
    Categories on Products.CtgId = Categories.CtgId
JOIN 
    ProductColors on Products.PrdId = ProductColors.PrdId
JOIN 
    Colors on Colors.ColorId = ProductColors.ColorId;


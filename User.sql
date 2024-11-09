Create Database Shirket


CREATE TABLE Users (
UserId INT PRIMARY KEY IDENTITY,
Username NVARCHAR(20) NOT NULL,
[Password] NVARCHAR(20) NOT NULL,
RoleId INT FOREIGN KEY REFERENCES Roles(RoleId)  
);


CREATE TABLE Roles (
RoleId INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(20) NOT NULL
);

Insert Into Users(
Values('user1','kod1',1),('user2','kod2',2),('user3','kod3',3);

Insert Into Roles(
Values('Moderator'),('Adminstrator'),('Ceo');

SELECT 
    Users.UserId,
    Users.Username,
    Roles.[Name] AS RoleName
FROM 
    Users
JOIN 
    Roles ON Users.RoleId = Roles.RoleId;
--1
Create database Company

use Company

Create table Employees 
(
	Id int identity Constraint PK_Id Primary Key,
	FullName nvarchar(10) Not Null Check(Len(FullName) >= 3),
	Salary money Check(Salary>0),
	Email nvarchar(100) Not Null Unique
)

Create table Departments
(
	Id int identity Primary Key,
	Name nvarchar(10) Not Null Check(Len(Name) >= 2)
)

Alter table Employees 
Add DepartmentId int Not Null Foreign Key References Departments(Id)

--2
use master

Create database Commerce

use Commerce

Create table Brands
(
	Id int identity Primary Key,
	Name nvarchar(10) Not Null 
)

Create table Notebooks
(
	Id int identity Primary Key,
	Name nvarchar(10) Not Null,
	Price money
)

Create table Phones
(
	Id int identity Primary Key,
	Name nvarchar(100) Not Null,
	Price money
)
--1) Notebook ve Brand Arasinda Mentiqe Uygun Relation Qurun.

Alter table Notebooks
Add BrandId int Not Null Foreign Key References Brands(Id)

--2) Phones ve Brand Arasinda Mentiqe Uygun Relation Qurun.
Alter table Phones
Add BrandId int Not Null Foreign Key References Brands(Id)

Insert into Brands
Values
('Dell'),
('Apple'),
('Lenovo'),
('Samsung')

Insert into Notebooks
values
('Mac',4500,1),
('Legion',2950,2),
('Samsung-2',1200,3)



--3) Notebooks Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
Select n.Name,n.Price,b.Name BrandName from Notebooks n
Join Brands b
on n.BrandId=b.Id

Insert into Phones
values
('Galaxy S20',1400,3),
('Iphone 14 Pro',4500,1),
('Lenovo Moto Z',220,2),
('Z Flip',2900,3)

--4) Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
Select p.Name,p.Price,b.Name BrandName from Phones p
Join Brands b
on p.BrandId=b.Id

--5) Brand Adinin Terkibinde s Olan Butun Notebooklari Cixardan Query.
Select n.Name,n.Price from Notebooks n
Join Brands b
on n.BrandId=b.Id
where b.Name LIKE '%s%'

--6) Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Notebooklari Cixardan Query.
Select Name,Price from Notebooks 
where Price>2000 AND Price<5000


--7) Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.
Select Name,Price from Phones
where Price>1000 AND Price<1500

--8) Her Branda Aid Nece dene Notebook Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
Select Brands.Name,COUNT(Notebooks.Id) from Notebooks
Right Join Brands
on Brands.Id=Notebooks.BrandId

--10) Hem Phone Hem de Notebookda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.
Select n.Name,n.BrandId,p.Name,p.BrandId from Notebooks n
Join Phones p
on p.Id=n.Id

--11) Phone ve Notebook da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.
Select * from Notebooks
Union all 
Select * from Phones

--12) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.
Select * from Brands
full Join (Select * from Notebooks
Union all 
Select * from Phones)sq
on sq.BrandId=Brands.Id

--13) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.
Select * from Brands
full Join (Select * from Notebooks
Union all 
Select * from Phones)sq
on sq.BrandId=Brands.Id
where Price>1000

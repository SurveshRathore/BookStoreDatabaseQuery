create database BookStoreDB

use BookStoreDB

create table UserTable 
(
	UserID INT PRIMARY KEY IDENTITY,
    FullName varchar(255),
	EmailId varchar(255),
	Password varchar(255),
	MobileNumber BIGINT
)

--ALTER TABLE UserTable
--ALTER COLUMN MobileNumber varchar(255);
--drop table UserTable

--------------------------
--create table Login 
--(
--	UserID INT PRIMARY KEY IDENTITY,
--	emailId varchar(255),
--	password varchar(255),
--)

--drop table Registration
select * from UserTable


create table Admintable
(
	AdminID INT PRIMARY KEY IDENTITY,
    AdminName varchar(255),
	AdminEmailId varchar(255),
	AdminPassword varchar(255),
	AdminMobileNumber BIGINT
)

insert into Admintable(AdminName, AdminEmailId, AdminPassword, AdminMobileNumber) values ('Book Admin', 'admin@gmail.com', 'admin@123', 9876543210)

create table BookTable
(
	BookID INT PRIMARY KEY IDENTITY,
    BookName varchar(255),
	AuthorName varchar(255),
	BookTotalRating int,
	TotalPeopleRated int,
	DiscountPrice int,
	OriginalPrice int,
	BookDescription varchar(255),
	BookImage varchar(255),
	BookQuantity int
)



create table cartTable
(
	CartID int Primary Key identity,
	BookQuantity int,
	bookID int foreign key references BookTable(BookID),
	UserID int foreign key references UserTable(UserID)
)

create table wishListTable
(
	WishListID int primary key identity,
	BookID int foreign key references BookTable(BookID),
	UserID int foreign key references UserTable(UserID)
)



--drop table whishListTable

--create table OrderTable
--(
--OrderId int primary key identity,
--BookQuantity int,
--OrderPrice int,
--BookId int foreign key references BookTable(BookId ),
--UserId int foreign key references UserTable(UserID),
--AddressId int foreign key references AddressTable (AddressId )
--)
--drop table OrderTable

create table OrderTable
(
OrderId int primary key identity,
CartId int,
OrderPrice int,
UserId int foreign key references UserTable(UserID),
AddressId int foreign key references AddressTable (AddressId )
)
 create table AddressTable
(
AddressId int primary key identity,
Address1 varchar(255),
City varchar(255),
State varchar(255),
Pincode int,
AddressTypeId int foreign key references AddressTypeTable(AddressTypeId),
UserId int foreign key references UserTable(UserID)
)

--drop table AddressTypeTable

 create table AddressTypeTable
(
AddressTypeId int primary key identity,
AddressType varchar(255)
)

create table FeedBackTable
(
FeedBackId int primary key identity,
Rating int,
Comment varchar(255),
BookId int foreign key references BookTable(BookId ),
UserId int foreign key references UserTable(UserID)
)

insert into AddressTypeTable(AddressType) values ('Home')
insert into AddressTypeTable(AddressType) values ('Work')
insert into AddressTypeTable(AddressType) values ('Other')
select * from AddressTypeTable

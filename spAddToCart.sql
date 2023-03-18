cartTable
(
	CartID int Primary Key identity,
	BookQuantity int,
	bookID int foreign key references BookTable(BookID),
	UserID int foreign key references UserTable(UserID)
)

create procedure spAddToCart
(
	@BookQuantity int,
	@bookID int,
	@UserID int
)
As
Begin
	insert into cartTable (BookQuantity, bookID, UserID)
	values(@BookQuantity, @bookID, @UserID)

END
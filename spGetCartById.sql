create table cartTable
(
	CartID int Primary Key identity,
	BookQuantity int,
	bookID int foreign key references BookTable(BookID),
	UserID int foreign key references UserTable(UserID)
)


create proc getCartById
(
	@CartID int,
	@UserID int
)
As

Begin
	BEGIN TRY
		if EXISTS(select * from cartTable where CartID = @CartID and UserID = @UserID)
		Begin 
			Select * from cartTable where CartID = @CartID and UserID = @UserID
		End

	END TRY
	BEGIN CATCH
		print 'Error'
	END CATCH
END

exec getCartById @CartID = 1, @UserID = 2
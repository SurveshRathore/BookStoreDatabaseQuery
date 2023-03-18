create table wishListTable
(
	WishListID int primary key identity,
	BookID int foreign key references BookTable(BookID),
	UserID int foreign key references UserTable(UserID)
)




create procedure spGetFromWishList
(
	@UserID int
)
As
Begin
	Begin Try
		if ((select count(*) from wishListTable where UserID = @UserID )>= 1)
		Begin
			select * from wishListTable where UserID = @UserID
			
		End
	End Try
	Begin Catch
		print 'WishList is empty'
	End Catch

END

--drop proc spGetFromWishList

create procedure spAddToWishlist
(
	@bookID int,
	@UserID int
)
As
Begin
	insert into wishListTable (bookID, UserID)
	values(@bookID, @UserID)

END

--drop proc spRemoveFromWishList

create procedure spRemoveFromWishList
(
	@WishListID int,
	@UserID int
	
)
As
Begin
	Begin Try
		if Exists(select * from wishListTable where WishListID = @WishListID AND UserID = @UserID)
		Begin
			delete wishListTable 
			where WishListID = @WishListID 
		End
	End Try
	Begin Catch
		print 'Invalid WishList id'
	End Catch

END
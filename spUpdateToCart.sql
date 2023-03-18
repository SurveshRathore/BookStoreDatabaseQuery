
create procedure spUpdateToCart
(
	@CartID int,
	@bookID int,
	@UserID int,
	@BookQuantity int
	
)
As
Begin
	Begin Try
		if Exists(select * from cartTable where CartID = @CartID)
		Begin
			update cartTable set BookQuantity = @BookQuantity 
			where CartID = @CartID 
		End
	End Try
	Begin Catch
		print 'Invalid cart id'
	End Catch

END
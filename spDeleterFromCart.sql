

create procedure spDeleterFromCart
(
	@CartID int
	
)
As
Begin
	Begin Try
		if Exists(select * from cartTable where CartID = @CartID)
		Begin
			delete cartTable 
			where CartID = @CartID 
		End
	End Try
	Begin Catch
		print 'Invalid cart id'
	End Catch

END
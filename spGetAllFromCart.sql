

create procedure spGetAllFromCart
(
	@UserID int
)
As
Begin
	Begin Try
		if ((select count(*) from cartTable where UserID = @UserID )>= 1)
		Begin
			select * from cartTable where UserID = @UserID
			
		End
	End Try
	Begin Catch
		print 'Cart is empty'
	End Catch

END

--drop proc spGetAllFromCart
USE [BookStoreDB]
GO
/****** Object:  StoredProcedure [dbo].[spGetFromWishList]    Script Date: 29-03-2023 12:34:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[spGetFromWishList]
(
	@UserID int
)
As
Begin
	Begin Try
		if ((select count(*) from wishListTable where UserID = @UserID )>= 1)
		Begin
			--select * from wishListTable where UserID = @UserID
			
			SELECT *
			FROM wishListTable
			INNER JOIN BookTable ON wishListTable.BookID=BookTable.BookID
			where UserID = @UserID
			
		End
	End Try
	Begin Catch
		print 'WishList is empty'
	End Catch

END

exec [spGetFromWishList] @UserID = 6

SELECT *
FROM wishListTable
INNER JOIN BookTable ON wishListTable.BookID=BookTable.BookID;
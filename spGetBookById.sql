create procedure spGetBookById
(
@BookID int
)
As
Begin
	if(@BookID > 0)
	BEGIN
	select * from BookTable where BookID = @BookID
	END
	ELSE
	BEGIN
		PRINT 'Invalid ID'
	END
End

--DROP PROC spGetBookById
--exec spGetBookById @BookID = 1
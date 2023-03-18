create procedure spDeleteBookById
(
@BookID int
)
As
Begin
	delete from BookTable where BookID = @BookID
End
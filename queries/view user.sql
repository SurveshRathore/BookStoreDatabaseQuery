
create view viewUser
as
select
	*
	from 
	UserTable


	select * from viewUser


--select * from cartTable

create view cartView
as
	select cartTable.CartID, cartTable.BookQuantity, cartTable.bookID, BookTable.BookName 
	from cartTable
	inner join BookTable ON cartTable.bookID = BookTable.BookID


select * from cartView
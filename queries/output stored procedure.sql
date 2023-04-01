create procedure spoutputProc
(
	@totalCount INT OUTPUT	
)
AS
BEGIN
	select @totalCount = count(*) from BookTable
END


Declare @countBook int

Exec spoutputProc @countBook OUTPUT
select @countBook


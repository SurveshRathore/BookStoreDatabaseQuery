create procedure spUpdateBook
(
    @BookID int,
	@BookName varchar(255),
	@AuthorName varchar(255),
	@BookTotalRating int,
	@TotalPeopleRated int,
	@DiscountPrice int,
	@OriginalPrice int,
	@BookDescription varchar(255),
	@BookImage varchar(255),
	@BookQuantity int
)
As
Begin
	update BookTable
	set 
		BookName = @BookName, 
		AuthorName = @AuthorName, 
		BookTotalRating = @BookTotalRating, 
		TotalPeopleRated = @TotalPeopleRated, 
		DiscountPrice = @DiscountPrice,	
		OriginalPrice = @OriginalPrice, 
		BookDescription = @BookDescription, 
		BookImage = @BookImage,	
		BookQuantity = @BookQuantity
	
	where
		BookID = @BookID
End

--DROP PROC spUpdateBook
--exec spUpdateBook @BookID = 1
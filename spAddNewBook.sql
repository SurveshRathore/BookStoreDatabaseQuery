create procedure spAddNewBook
(
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

	if(@DiscountPrice <= @OriginalPrice)
	BEGIN

	insert into BookTable (
		BookName, AuthorName, BookTotalRating, TotalPeopleRated, DiscountPrice,	OriginalPrice, BookDescription, BookImage,	BookQuantity
	)
	values
	(
		@BookName, @AuthorName, @BookTotalRating, @TotalPeopleRated, @DiscountPrice, @OriginalPrice, @BookDescription,	@BookImage,	@BookQuantity
	)
	END

	ELSE
	BEGIN
		PRINT 'Original Price must be greater than the Discount price'
	END

End

--exec spAddNewBook @BookName = 'Book1', @AuthorName = 'auth1', @BookTotalRating =4, @TotalPeopleRated =10, @DiscountPrice = 120, @OriginalPrice = 200, @BookDescription ='book desc', @BookImage = 'image',	@BookQuantity = 10
--exec spAddNewBook @BookName = 'Book2', @AuthorName = 'auth1', @BookTotalRating =4, @TotalPeopleRated =10, @DiscountPrice = 120, @OriginalPrice = 100, @BookDescription ='book desc', @BookImage = 'image',	@BookQuantity = 10
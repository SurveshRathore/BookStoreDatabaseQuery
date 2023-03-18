create table FeedBackTable
(
FeedBackId int primary key identity,
Rating int,
Comment varchar(255),
BookId int foreign key references BookTable(BookId ),
UserId int foreign key references UserTable(UserID)
)

---------------------------------------
create proc spAddFeedBack
(
	@Rating int,
	@Comment varchar(255),
	@BookId int,
	@UserId int
)
As
Begin
	insert into FeedBackTable(Rating, Comment, BookId, UserId)
	values(@Rating, @Comment, @BookId, @UserId)
End

--------------------------------------------

create proc spGetAllFeedBack
@UserId int
AS
SET XACT_ABORT on;
Begin
BEGIN TRY
	BEGIN TRANSACTION;

		DECLARE @Result int = 0;

		if((Select count(*) from FeedBackTable where UserId = @UserId)>=1)
		begin
			Set @Result = 1;
			select * from FeedBackTable where UserId = @UserId 
		End
		else
		begin
			Set @Result = 2;
			THROW 52000, 'FeedBack Table is Empty', -1;
		end
	COMMIT TRANSACTION;

	return @Result;
END TRY
BEGIN CATCH
	if(XACT_STATE()) = -1
	begin
		print 'Transaction is Uncomplitable ' + 'Rolling Back Transaction'
		RollBack Transaction;
		Print @Result;
		return @result;
	end;
	else if(XACT_STATE()) = 1
	begin
		print 'Transaction is complitable ' + 'Commiting Back Transaction'
		COMMIT TRANSACTION;
		Print @Result;
		return @result;
	end;
END CATCH
END

--exec spGetAllAddress @UserId = 2

---------------------------
create proc UpdateFeedBack
(
	@FeedBackId int,
	@Rating int,
	@Comment varchar(255),
	@BookId int,
	@UserId int
)
AS
SET XACT_ABORT on;
Begin
BEGIN TRY
BEGIN TRANSACTION;
		DECLARE @Result int = 0;
		
		if Exists (Select * from FeedBackTable where FeedBackId = @FeedBackId and UserID = @UserID)
			begin
			Set @Result = 1;
			update FeedBackTable set Rating = @Rating, Comment = @Comment, BookId = @BookId where FeedBackId = @FeedBackId and UserID= @UserID
			end
		else
			begin
			Set @Result = 2;
			THROW 52000, 'FeedBackId does not Exists', -1;
			end 
		
COMMIT TRANSACTION;

return @Result;
End TRY
BEGIN CATCH

if(XACT_STATE()) = -1
	begin 
		print 
		'Transaction is Uncomplitable' + 'Rolling Back Transaction'
		RollBack Transaction;
		Print @Result;
		return @result;
	End;
Else if(XACT_STATE()) = 1
	Begin
		Print
		'Transaction is Complitable' + 'Commiting Back Transaction'
		COMMIT TRANSACTION;
		Print @Result;
		return @result;
	End;
End Catch
End

-------------------------

create procedure SPDeleteFeedBack
	@FeedBackId int,
	@UserID int
AS
SET XACT_ABORT on;
Begin
BEGIN TRY
BEGIN TRANSACTION;

		DECLARE @Result int = 0;
		
		if Exists (Select * from FeedBackTable where FeedBackId = @FeedBackId and UserID= @UserID)
			begin
			Set @Result = 1;
			Delete FeedBackTable where FeedBackId = @FeedBackId and UserID= @UserID
			end
		else
			begin
			set @Result = 2;
			THROW 52000, 'FeedBackId Not Exists', -1;
			End
COMMIT TRANSACTION;

return @Result;
End TRY
BEGIN CATCH

if(XACT_STATE()) = -1
	begin 
		print 
		'Transaction is Uncomplitable' + 'Rolling Back Transaction'
		RollBack Transaction;
		Print @Result;
		return @result;
	End;
Else if(XACT_STATE()) = 1
	Begin
		Print
		'Transaction is Complitable' + 'Commiting Back Transaction'
		COMMIT TRANSACTION;
		Print @Result;
		return @result;
	End;
End Catch
End
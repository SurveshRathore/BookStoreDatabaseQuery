create table OrderTable
(
OrderId int primary key identity,
BookQuantity int,
OrderPrice int,
BookId int foreign key references BookTable(BookId ),
UserId int foreign key references UserTable(UserID),
AddressId int foreign key references AddressTable (AddressId )
)

---------------------------

create proc spAddOrder
(
	@CartId int,
	@UserId int,
	@AddressId int
)
As
Begin
	insert into OrderTable(CartId, UserId, AddressId)
	values(@CartId, @UserId, @AddressId)
End

--------------------------------------------

--drop proc spGetAllOrder

create proc spGetAllOrder
@UserId int
AS
SET XACT_ABORT on;
Begin
BEGIN TRY
	BEGIN TRANSACTION;

		DECLARE @Result int = 0;

		if((Select count(*) from OrderTable where UserId = @UserId)>=1)
		begin
			Set @Result = 1;
			select * from OrderTable where UserId = @UserId 
		End
		else
		begin
			Set @Result = 2;
			THROW 52000, 'Order Table is Empty', -1;
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
create proc UpdateOrder
(
	@OrderId int,
	@BookQuantity int,
	@OrderPrice varchar(255),
	@BookId int,
	@UserId int,
	@AddressId int
)
AS
SET XACT_ABORT on;
Begin
BEGIN TRY
BEGIN TRANSACTION;
		DECLARE @Result int = 0;
		
		if Exists (Select * from OrderTable where OrderId = @OrderId and UserID = @UserID)
			begin
			Set @Result = 1;
			update OrderTable set BookQuantity = @BookQuantity, OrderPrice = @OrderPrice, BookId = @BookId, AddressId = @AddressId where OrderId = @OrderId and UserID= @UserID
			end
		else
			begin
			Set @Result = 2;
			THROW 52000, 'OrderId does not Exists', -1;
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

create procedure SPDeleteOrder
	@OrderId int,
	@UserID int
AS
SET XACT_ABORT on;
Begin
BEGIN TRY
BEGIN TRANSACTION;

		DECLARE @Result int = 0;
		
		if Exists (Select * from OrderTable where OrderId = @OrderId and UserID= @UserID)
			begin
			Set @Result = 1;
			Delete OrderTable where OrderId = @OrderId and UserID= @UserID
			end
		else
			begin
			set @Result = 2;
			THROW 52000, 'OrderId Not Exists', -1;
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
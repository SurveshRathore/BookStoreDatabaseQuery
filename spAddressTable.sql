create table AddressTable
(
AddressId int primary key identity,
Address1 varchar(255),
City varchar(255),
State varchar(255),
Pincode int,
AddressTypeId int foreign key references AddressTypeTable(AddressTypeId),
UserId int foreign key references UserTable(UserID)
)
---------------------------------------

--drop proc spAddAddress
create proc spAddAddress
(
	@Address1 varchar(255),
	@City varchar(255),
	@State varchar(255),
	@Pincode int,
	@AddressTypeId int,
	@UserId int
)
As
SET XACT_ABORT on;
Begin
	BEGIN TRY
		DECLARE @Result int = 0;

		if Exists (Select * from AddressTypeTable where AddressTypeId = @AddressTypeId)
		begin
			set @Result = 1;
			insert into AddressTable(Address1, City, State, Pincode, AddressTypeId, UserId)
			values(@Address1, @City, @State, @Pincode, @AddressTypeId, @UserId)
		end
		

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

--------------------------------------------
create proc spGetAllAddress
@UserId int
AS
SET XACT_ABORT on;
Begin
BEGIN TRY
	BEGIN TRANSACTION;

		DECLARE @Result int = 0;

		if((Select count(*) from AddressTable where UserId = @UserId)>=1)
		begin
			Set @Result = 1;
			select * from AddressTable where UserId = @UserId 
		End
		else
		begin
			Set @Result = 2;
			THROW 52000, 'Address_Table is Empty', -1;
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
create proc UpdateAddress
(
	@AddressId int,
	@Address1 varchar(255),
	@City varchar(255),
	@State varchar(255),
	@Pincode int,
	@AddressTypeId int,
	@UserId int
)
AS
SET XACT_ABORT on;
Begin
BEGIN TRY
BEGIN TRANSACTION;
		DECLARE @Result int = 0;
		
		if Exists (Select * from AddressTable where AddressID = @AddressID and UserID = @UserID)
			begin
			Set @Result = 1;
			update AddressTable set Address1 = @Address1, city=@city,State=@State, AddressTypeId=@AddressTypeId where AddressID = @AddressID and UserID= @UserID
			end
		else
			begin
			Set @Result = 2;
			THROW 52000, 'AddressID does not Exists', -1;
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

create procedure SPDeleteAddress
	@AddressID int,
	@UserID int
AS
SET XACT_ABORT on;
Begin
BEGIN TRY
BEGIN TRANSACTION;

		DECLARE @Result int = 0;
		
		if Exists (Select * from AddressTable where AddressID = @AddressID and UserID= @UserID)
			begin
			Set @Result = 1;
			Delete AddressTable where AddressID = @AddressID and UserID= @UserID
			end
		else
			begin
			set @Result = 2;
			THROW 52000, 'AddressID Not Exists', -1;
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
use BookStoreDB

create procedure spAddUser
(
@FullName varchar(255)
,@EmailId varchar(255)
,@Password varchar(255)
,@MobileNumber Bigint
)
AS
Begin
	insert into UserTable
	(
		FullName, EmailId, Password, MobileNumber
	)
	values
	(
		@FullName, @EmailId, @Password, @MobileNumber	
	)
End;

--
--Drop procedure spAddUser

exec spAddUser @FullName = "abc", @EmailId = "abc@gmail.com", @Password = "12essdf", @MobileNumber=89765
create procedure spValidateUser
@EmailId varchar(255)
,@Password varchar(255)

AS
Begin
	select * from UserTable where EmailId = @EmailId And Password = @Password	
End;


--test@gmail.com
--Test@123

create procedure spValidateAdmin
@AdminEmailId varchar(255)
,@AdminPassword varchar(255)

AS
Begin
	select * from Admintable where AdminEmailId = @AdminEmailId And AdminPassword = @AdminPassword
End;

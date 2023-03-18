create procedure spValidateEmail
@EmailId varchar(255)
AS
Begin
	select * from UserTable where EmailId = @EmailId	
End;


create procedure spResetPassword
@EmailId varchar(255)
,@Password varchar(255)
AS
Begin
    update UserTable
	set Password = @Password
    where EmailId = @EmailId	
End;
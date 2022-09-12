USE WestMunicipalLibrary
;
GO

/*Purpose: Create trigger for juvenile members turning of age */
CREATE TRIGGER ins_memberships_juvenile_check_age 
ON Memberships.juvenile
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @adult_no INT
	DECLARE @juvenile_no INT

	select @adult_no = adult_member_no,
		@juvenile_no = juvenile_member_no
	from inserted

	IF EXISTS(SELECT * FROM inserted 
		where (DATEDIFF(HOUR,inserted.birth_date,GETDATE())/8766) >= 18)
	BEGIN
		INSERT INTO Memberships.adult (adult_member_no, street, city, [state], zip, phone_no, expr_date)
		SELECT @juvenile_no, street, city, [state], zip, phone_no, expr_date
		FROM Memberships.adult
		WHERE adult_member_no = @adult_no
		RETURN
	END

	INSERT INTO Memberships.juvenile
	SELECT * FROM inserted
END


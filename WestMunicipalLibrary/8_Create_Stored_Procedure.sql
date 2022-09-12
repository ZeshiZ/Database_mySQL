USE WestMunicipalLibrary
;
GO

/* Purpose: Creating stored procedure to transfer juvenile members 18 years old and up to adult table. */ 
CREATE PROCEDURE sp_membership_juvenile_tranfer_if_age_greater_than_18
AS
BEGIN
	INSERT INTO Memberships.adult
	SELECT j.juvenile_member_no, street, city, [state], zip, phone_no, expr_date
	FROM Memberships.juvenile j
	LEFT JOIN Memberships.adult a ON j.adult_member_no = a.adult_member_no
	WHERE (DATEDIFF(HOUR,birth_date,GETDATE())/8766) >= 18

	DELETE FROM Memberships.juvenile
	WHERE (DATEDIFF(HOUR,birth_date,GETDATE())/8766) >= 18
END 
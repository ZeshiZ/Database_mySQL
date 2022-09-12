/* Purpose: Manipulating Data*/
USE WestMunicipalLibrary
;
GO

/* Creating a mailing list. */
SELECT MM.member_no as 'Member No.', CONCAT_WS(' ', MM.firstName, MM.middleInitial+'.', MM.lastName) as 'Member Name', MM.street as 'Street Address', MM.city as 'City', MM.zip as 'ZIP Code'
FROM (SELECT m.*,
		a.street,
		a.[state],
		a.city,
		a.zip,
		a.phone_no,
		a.expr_date
	FROM Memberships.juvenile j
	LEFT JOIN Memberships.adult a
	ON j.adult_member_no = a.adult_member_no
	LEFT JOIN Memberships.member m
	ON j.juvenile_member_no = m.member_no
	UNION
	SELECT m.*,
		a.street,
		a.[state],
		a.city,
		a.zip,
		a.phone_no,
		a.expr_date
	FROM Memberships.adult a
	LEFT JOIN Memberships.member m
	ON a.adult_member_no = m.member_no) MM
	ORDER BY MM.member_no ASC
;
GO

/* return the ISBN, copy_no, on_loan, title, translation, and cover. */
SELECT BI.isbn as 'ISBN', copy_no as 'Copy No.', on_loan as 'Availabiliy', BT.title as 'Title', BI.language as 'Translation', binding as 'Cover'
FROM Books.item BI INNER JOIN Books.copy BC
	ON (BI.isbn = BC.isbn)
	INNER JOIN Books.title BT ON (BT.title_no = BC.title_no)
WHERE BI.isbn IN ('1', '500', '1000')
ORDER BY BI.isbn asc
;
GO

/* retrieve the member's full name and member_no from the member table and the isbn and the log_date values from reservation table for members 250, 341, 1675 ordered by member_no. */
SELECT MM.member_no as 'Member No.', CONCAT_WS(' ',MM.firstName,MM.middleInitial,MM.lastName) as 'Member Name', TR.isbn as 'ISBN', TR.log_date
FROM Memberships.member MM LEFT JOIN Transactions.reservation TR
	ON (MM.member_no = TR.member_no)
WHERE MM.member_no IN(250,341,1675)
ORDER BY MM.member_no
;
GO



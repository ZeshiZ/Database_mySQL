/* Purpose: Creating views*/
USE WestMunicipalLibrary
;
GO

/* ********** AdultwideView ********** */
/* Purpose: Creating a view that queries the member and adult tables. Lists the names & addres for all adults */
CREATE VIEW AdultwideView
AS
SELECT MA.adult_member_no as 'Member No.', CONCAT_WS(' ', firstName, middleInitial+'.', lastName) as 'Member Name', street as 'Street Address', city as 'City', zip as 'ZIP Code'
FROM Memberships.member AS MM
	INNER JOIN Memberships.adult AS MA
	ON (MM.member_no = MA.adult_member_no)
;
GO

SELECT * FROM AdultwideView
;
GO

/* ********** ChildwideView ********** */
/* Purpose: Creating a view that queries the member, adult and juvenile tables. Lists the name & address for the juveniles. */
CREATE VIEW ChildwideView
AS
SELECT MJ.juvenile_member_no as 'Member No.', CONCAT_WS(' ', firstName, middleInitial+'.', lastName) as 'Member Name', MA.street as 'Street Address', MA.city as 'City', MA.zip as 'ZIP Code'
FROM Memberships.member AS MM 
	INNER JOIN Memberships.juvenile AS MJ
	ON (MM.member_no = MJ.juvenile_member_no)
	INNER JOIN Memberships.adult AS MA
	ON (MJ.adult_member_no = MA.adult_member_no)
;
GO

SELECT * FROM ChildwideView
;
GO

/* ********** CopywideView ********** */
/* Purpose: Creating a view that queries the copy, title, and item tables. Lists complete information about each copy. */
CREATE VIEW CopywideView
AS
	SELECT BI.isbn as 'ISBN', BC.copy_no as 'Copy No.', BT.title_no as 'Title No.', BC.on_loan as 'On Loan', BI.language as 'Translation', BI.binding as 'Binding', BI.availability as 'Loanable', BT.title as 'Title', BT.authorName as 'Author', BT.synopsis as 'Synopsis'
	FROM Books.copy BC INNER JOIN Books.item BI
		ON (BC.isbn = BI.isbn)
	INNER JOIN Books.title BT ON (BT.title_no = BI.title_no)
;
GO

SELECT * FROM CopywideView
;
GO

/* ********** LoanableView ********** */
/* Purpose: List complete information about each copy marked as loanable (loanable='Y'). */
CREATE VIEW LoanableView
AS
	SELECT *
	FROM CopywideView
	WHERE Loanable = 'Y'
;
GO

SELECT * FROM LoanableView
;
GO

/* ********** OnshelfView ********** */
/* Purpose: Lists complete information about each copy that is not currently on loan(on_loan = 'N'). */
CREATE VIEW OnshelfView
AS
	SELECT *
	FROM CopywideView
	WHERE [On Loan] = 'N'
;
GO

SELECT * FROM OnshelfView
;
GO

/* ********** OnLoanView ********** */
/* Purpose: Create a view that queries the loan, title, and member tables. Lists the member, title, and loan information of a copy that is currently on loan. */
CREATE VIEW OnLoanView
AS
	SELECT MM.member_no as 'Member No.', CONCAT_WS(' ',MM.firstName,MM.middleInitial+'.',MM.lastName) as 'Member Name', TL.isbn AS 'ISBN', TL.copy_no AS 'Copy No.', BT.title as 'Title', TL.out_date as 'Out Date', TL.due_date as 'Due Date'
	FROM Memberships.member MM INNER JOIN Transactions.loan TL
		ON (MM.member_no = TL.member_no)
	INNER JOIN Books.title BT ON (BT.title_no = TL.title_no)
;
GO

SELECT * FROM OnLoanView
;
GO

/* ********** OverdueView ********** */
/* Purpose: Create a view that queries Onloanview. Lists the member, title, and loan information of a copy on loan that is overdue(due_date < current_date). */
CREATE VIEW OverdueView
AS
	SELECT *
	FROM OnLoanView
	WHERE [Due Date] < GETDATE()
;
GO

SELECT * FROM OverdueView
;
GO

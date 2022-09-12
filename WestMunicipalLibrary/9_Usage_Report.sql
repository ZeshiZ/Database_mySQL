USE WestMunicipalLibrary
;
GO

/* Purpose: Count the number of loans the library do in a specific year. */
CREATE PROCEDURE GetYearCounts
    @year INT
AS
    SELECT YEAR(out_date) AS 'Year',
           COUNT(*) AS 'Number of Loans'
    FROM   Transactions.loanhist
    WHERE  YEAR(out_date) = @year
    GROUP BY
           YEAR(out_date)
;
GO

EXEC GetYearCounts @year = 2007;
GO

/* Purpose: Count the percentage of membership that borrowed at least one book. */
SELECT 
COUNT(DISTINCT TL.member_no) as 'Number of Members that Borrowed at leat one Book',
COUNT(MM.member_no) as 'Total Number of Members',
(COUNT(DISTINCT TL.member_no) * 100) / (COUNT(MM.member_no)) as 'Percentage of Membership Who Borrowed at least one Book'
FROM Transactions.loanhist AS TL
INNER JOIN Memberships.member AS MM
ON MM.member_no = TL.member_no
;
GO

/* Purpose: Count the greatest number of books borrowed by any one individual. */

SELECT 
DISTINCT TL.member_no as 'Member No', COUNT(TL.isbn) Books
FROM Transactions.loanhist TL
GROUP BY TL.member_no
ORDER BY Books DESC
;
GO

SELECT *
FROM Transactions.loanhist
;
GO

/* Purpose: Count the percentage of membership that borrowed at least one book. */
SELECT 
(COUNT(DISTINCT TL.isbn) * 100) / (COUNT(BI.isbn)) as 'Percentage of Loaned Books'
FROM Transactions.loanhist TL
INNER JOIN Books.item BI ON BI.isbn = TL.isbn
;
GO

/* Purpose: Count the percentage of books that become overdue. */

SELECT SUM(DATEDIFF(DAY, TL.in_date, TL.due_date)) / COUNT(TL.out_date) AS 'PERCENT OVERDUE'
FROM Transactions.loanhist TL
;
GO

/* Purpose: Count average length of a loan. */
SELECT SUM(DATEDIFF(DAY, out_date, in_date)) / COUNT(*) AS 'AveragelengthOfLoan'
FROM Transactions.loanhist TL
;
GO

/* Purpose: Show the library peak hours. */
SELECT TOP 5 FORMAT(out_date, 'h tt') as [Time], 
	count(out_date) as [Count]
FROM Transactions.loanhist
GROUP BY FORMAT(out_date, 'h tt')
ORDER BY count(out_date) DESC
;
GO


/* Purpose: Populate tables with the sample data. */

Use WestMunicipalLibrary
;
GO

/* ******** Memberships.member ******** */
BULK INSERT Memberships.member FROM 'C:\Users\zeshi\OneDrive\Documents\My Stuff\Full Stack Developer\Database\Final Project\WestMunicipalLibrary\WestMunicipalLibrary\Sample_Library_Data_Sources\member.txt'
   WITH (
      FIELDTERMINATOR = '\t',
      ROWTERMINATOR = '\n'
);
GO

select *
from Memberships.member
;
go

/* ******** Memberships.adult ******** */

ALTER TABLE Memberships.adult
	ALTER COLUMN zip nchar(10) NOT NULL -- had to change length to fit extended zip codes
;
go

BULK INSERT Memberships.adult FROM 'C:\Users\zeshi\OneDrive\Documents\My Stuff\Full Stack Developer\Database\Final Project\WestMunicipalLibrary\WestMunicipalLibrary\Sample_Library_Data_Sources\adult.txt'
   WITH (
      FIELDTERMINATOR = '\t',
      ROWTERMINATOR = '\n'
);
GO


SELECT * FROM Memberships.adult
;
go

/* ******** Memberships.juvenile ******** */
BULK INSERT Memberships.juvenile FROM 'C:\Users\zeshi\OneDrive\Documents\My Stuff\Full Stack Developer\Database\Final Project\WestMunicipalLibrary\WestMunicipalLibrary\Sample_Library_Data_Sources\juvenile.txt'
   WITH (
      FIELDTERMINATOR = '\t',
      ROWTERMINATOR = '\n'
);
GO

SELECT * FROM Memberships.juvenile
;
go

/* ******** Books.item ******** */
BULK INSERT Books.item FROM 'C:\Users\zeshi\OneDrive\Documents\My Stuff\Full Stack Developer\Database\Final Project\WestMunicipalLibrary\WestMunicipalLibrary\Sample_Library_Data_Sources\item.txt'
   WITH (
      FIELDTERMINATOR = '\t',
      ROWTERMINATOR = '\n'
);
GO

SELECT * FROM Books.item
;
go


/* ******** Books.title ******** */
ALTER TABLE Books.title
	ALTER COLUMN title nvarchar(255) NOT NULL -- had to increase character limit to accomodate long titles
;
GO

BULK INSERT Books.title FROM 'C:\Users\zeshi\OneDrive\Documents\My Stuff\Full Stack Developer\Database\Final Project\WestMunicipalLibrary\WestMunicipalLibrary\Sample_Library_Data_Sources\title.txt'
   WITH (
      FIELDTERMINATOR = '|',
      ROWTERMINATOR = '\n'
);
GO

select * from Books.title;
GO

/* ******** Books.copy ******** */
BULK INSERT Books.copy FROM 'C:\Users\zeshi\OneDrive\Documents\My Stuff\Full Stack Developer\Database\Final Project\WestMunicipalLibrary\WestMunicipalLibrary\Sample_Library_Data_Sources\copy.txt'
   WITH (
      FIELDTERMINATOR = '\t',
      ROWTERMINATOR = '\n'
);
GO

select * from Books.copy;
GO

/* ******** Transactions.loan ******** */
BULK INSERT Transactions.loan FROM 'C:\Users\zeshi\OneDrive\Documents\My Stuff\Full Stack Developer\Database\Final Project\WestMunicipalLibrary\WestMunicipalLibrary\Sample_Library_Data_Sources\loan.txt'
   WITH (
      FIELDTERMINATOR = '\t',
      ROWTERMINATOR = '\n'
);
GO

select * from Transactions.loan;
GO

/* ******** Transactions.reservation ******** */
ALTER TABLE Transactions.reservation
	ALTER COLUMN log_date datetime NOT NULL -- had to change data type from date to datetime
;
go

BULK INSERT Transactions.reservation FROM 'C:\Users\zeshi\OneDrive\Documents\My Stuff\Full Stack Developer\Database\Final Project\WestMunicipalLibrary\WestMunicipalLibrary\Sample_Library_Data_Sources\reservation.txt'
   WITH (
      FIELDTERMINATOR = '|',
      ROWTERMINATOR = '|'
);
GO

select * from Transactions.reservation;
GO

/* ******** Transactions.loanhist ******** */
BULK INSERT Transactions.loanhist FROM 'C:\Users\zeshi\OneDrive\Documents\My Stuff\Full Stack Developer\Database\Final Project\WestMunicipalLibrary\WestMunicipalLibrary\Sample_Library_Data_Sources\loanhist.txt'
   WITH (
      FIELDTERMINATOR = '\t',
      ROWTERMINATOR = '\n'
);
GO

select * from Transactions.loanhist;
GO
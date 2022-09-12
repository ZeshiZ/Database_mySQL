/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the WestMunicipalLibrary database
-- Syntax: use database_name
use WestMunicipalLibrary
;
go -- includes end of the batch marker

/* Consider the following facts when you create tables in SQL Server. You can have up to:
	• two billions tables per database
	• 1024 columns per table
	• 8092 bytes per row (this does not apply to image and text data types)
*/

/* The following script must be used only during the development process and NOT on the production database. */

select * 
from sys.all_objects
;
go

	
if OBJECT_ID('Books.item', 'U') is not null
	drop table Books.item
;
go

create table Books.item
(
	-- column_name data_type constraint(s)
	isbn int not null,
	title_no int not null, -- FK title
	language nvarchar(15) not null,
	binding nchar(10) not null,
	availability nchar(1) not null,
	constraint pk_item primary key clustered (isbn asc)
)
;
go

/* return the definition of the database */
execute sp_helpdb 'WestMunicipalLibrary'
;
go

/* return the definition of the table Sales.Customers */
execute sp_help 'Books.item'
;
go


/* Creates an identity column in a table. The IDENTITY property has the following syntax:
	IDENTITY [ (seed , increment) ]  

	where 
	• seed Is the value that is used for the very first row loaded into the table
	• increment Is the incremental value that is added to the identity value of the previous row that was loaded.
	You must specify both the seed and increment or neither. If neither is specified, the default is (1,1).


	SET IDENTITY_INSERT [ [ database_name . ] schema_name . ] table_name { ON | OFF }

For example, set identity_insert Sales.Shippers2 on 
;
*/


if OBJECT_ID('Books.titles', 'U') is not null
	drop table Books.titles
;
go


create table Books.title
(
	title_no int identity(1, 1) not null,	--PK
	title nvarchar(50) not null,
	authorName nvarchar(30) not null,
	synopsis text null,
	constraint pk_title primary key clustered (title_no asc)
)
;
go

select * 
from Books.title
;
go

if OBJECT_ID('Books.copy', 'U') is not null
	drop table Books.copy
;
go

CREATE TABLE Books.copy
(	
	isbn int not null, -- FK item
	copy_no int NOT NULL,
	title_no int not null, --FK title
	on_loan nchar(1) NOT NULL, -- 1 means item is no longer available
	CONSTRAINT pk_copy PRIMARY KEY CLUSTERED (isbn, copy_no asc) 
)
;
go

if OBJECT_ID('Transactions.reservation', 'U') is not null
	drop table Transactions.reservation
;
go

CREATE TABLE Transactions.reservation
(	
	isbn int not null, -- FK
	member_no int NOT NULL, --FK
	log_date date not null,
	-- reservation_no int identity(1,1) NOT NULL, -- PK auto-generated number assigned to a new supplier
	-- CONSTRAINT pk_reservation PRIMARY KEY CLUSTERED (reservation_no ASC)
)
;
go

if OBJECT_ID('Transactions.loan', 'U') is not null
	drop table Transactions.loan
;
go


CREATE TABLE Transactions.loan

(	isbn int not null, -- FK
	copy_no int NOT NULL,
	title_no int not null, --FK
	member_no int NOT NULL, --FK
	out_date datetime NOT NULL,
	due_date datetime NOT NULL,
	-- loan_no int IDENTITY(1,1) NOT NULL, -- auto-generated number assigned to a new category
	-- CONSTRAINT pk_loan PRIMARY KEY CLUSTERED (loan_no ASC)
)
; 
go

if OBJECT_ID('Transactions.loanhist', 'U') is not null
	drop table Transactions.loanhist
;
go


CREATE TABLE Transactions.loanhist

(	isbn int not null, -- FK
	copy_no int NOT NULL,
	out_date datetime NOT NULL,
	title_no int not null, --FK
	member_no int NOT NULL, --FK
	due_date datetime NOT NULL,
	in_date datetime NOT NULL,
)
; 
go

if OBJECT_ID('Memberships.member', 'U') is not null
	drop table Memberships.member
;
go


CREATE TABLE Memberships.member
(
	member_no int IDENTITY(1,1) NOT NULL, -- auto-generated number assigned to a new shipper
	lastName nvarchar(20) NOT NULL,
	firstName nvarchar(20) NOT NULL,
	middleInitial nchar(1) NUll,
	photograph varbinary(max) null,
	CONSTRAINT pk_member PRIMARY KEY CLUSTERED (member_no ASC)
)
;
go

if OBJECT_ID('Memberships.adult', 'U') is not null
	drop table Memberships.adult
;
go

CREATE TABLE Memberships.adult
(
	adult_member_no int NOT NULL, -- FK member_no in member table
	street nvarchar(60) NOT NULL, -- Street Number and Street Name
	city nvarchar(15) NOT NULL,
	state nchar(2) NOT NULL, -- State or Province
	zip nchar(5) NOT NULL,
	phone_no nchar(10) NULL,
	expr_date date not null,
	CONSTRAINT pk_adult PRIMARY KEY CLUSTERED (adult_member_no ASC)
)
;
go

if OBJECT_ID('Memberships.juvenile', 'U') is not null
	drop table Memberships.juvenile
;
go

CREATE TABLE Memberships.juvenile
(
	juvenile_member_no int NOT NULL, -- FK member_no in member table
	adult_member_no int not null, -- FK adult_member_no in adult table
	birth_date date not null,
	CONSTRAINT pk_juvenile PRIMARY KEY CLUSTERED (juvenile_member_no ASC)
)
;
go

/* display user-defined and system tables */

-- in schema Production
execute sp_tables
@table_owner = 'Books',
@table_qualifier = 'WestMunicipalLibrary'
;
go

-- in schema HumanResources
execute sp_tables
@table_owner = 'Transactions',
@table_qualifier = 'WestMunicipalLibrary'
;
go

-- in schema Sales
execute sp_tables
@table_owner = 'Memberships',
@table_qualifier = 'WestMunicipalLibrary'
;
go
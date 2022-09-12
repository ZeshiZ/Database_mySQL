use master
;
go -- includes end of the batch marker

/* Partial syntax to create a database
create object_type object_name
create database database_name
*/

-- database name
-- create the library database
create database WestMunicipalLibrary
on primary
(
	-- 1) rows data logical filename
	name = 'WestMunicipalLibrary',
	-- 2) rows data initial file size
	size = 12MB,
	-- 3) rows data auto growth size
	filegrowth = 8MB,
	-- 4) rows data maximum size
	maxsize = 500MB, -- unlimited
	-- 5) rows data path and file name
	filename = 'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\WestMunicipalLibrary.mdf'
)
-- transaction log
log on
(
	-- 1) log logical filename
	name = 'WestMunicipalLibrary_log',
	-- 2) log initial file size (1/4 the rows data file size)
	size = 3MB,
	-- 3) log auto growth size
	filegrowth = 10%,
	-- 4) log maximum size
	maxsize = 25MB, 
	-- 5) log path and file name
	filename = 'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\WestMunicipalLibrary_log.ldf'
)
;
go
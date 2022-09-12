/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the library database
use WestMunicipalLibrary
;
go -- includes end of the batch marker

/* Partial Syntax:
create schema schema_name authorization owner_name
*/

/* a schema is a distinct namespace to facilitate the separation,
organization, management, and ownership of database objects.

Schemas are used as containers for objects such as tables, views, and stored procedures. Schemas can be particularly helpful in providing a level of organization and structure when large numbers of objects are present in a database.

Security permissions can also be assigned at the schema level rather than individually on the objects contained within the schemas. Doing this can greatly simplify the design of system security requirements

In SQL Server, an object is formally referred to by a name of the form:
Server.Database.Schema.Object

• Security Boundary
Schemas can be used to simplify the assignment of permissions. An example of applying permissions at the schema level would be to assign the EXECUTE permission on a schema to a user. The user could then execute all stored procedures within the schema. This simplifies the granting of permissions as there is no need to set up individual permissions on each stored procedure.

It is important to understand that schemas are not used to define physical storage locations for data, as occurs in some other database engines, such as in MySQL Server. 
*/

/* Syntax:
create schema schema_name authorization owner_name
*/

create schema Books authorization dbo
;
go

create schema Transactions authorization dbo
;
go

create schema Memberships authorization dbo
;
go
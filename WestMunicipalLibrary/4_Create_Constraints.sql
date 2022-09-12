use WestMunicipalLibrary
;
go -- includes end of the batch marker


/* Integrity Types:
	1. Domain (column)
	2. Entity (row)
	3. Referential (between two columns or tables)

Constraint Types:
1. Primary Key (pk_)
	alter table schema_name.table_name
		add constraint pk_table_name primary key clustered (column_name asc)

2. Foreign key (fk_)
	alter table schema_name.table_name
		add constraint fk_first_table_name_second_table_name foreign key (fk_column_name) references second_table_name (pk_column_name)

3. Default (df_)
	alter table schema_name.table_name
		add constraint df_column_name_table_name default (value) for column_name

4. Check (ck_)
	alter table schema_name.table_name
		add constraint ck_column_name_table_name check (condition)

5. Unique (uq_)
alter table schema_name.table_name
		add constraint uq_column_name_table_name unique (column_name)
*/

-- Foreign key constraints
ALTER TABLE Books.item
	add constraint fk_item_title foreign key (title_no) references Books.title (title_no)
;
go

alter table Books.copy
	add constraint fk_copy_item foreign key (isbn) references Books.item (isbn)
;
go

alter table Books.copy
	add constraint fk_copy_title foreign key (title_no) references Books.title (title_no)
;
go

alter table Transactions.reservation
	add
	constraint fk_reservation_member foreign key (member_no) references Memberships.member (member_no),
	constraint fk_reservation_item foreign key (isbn) references Books.item (isbn)
;
go

alter table Transactions.loan
	add 
	constraint fk_loan_title foreign key (title_no) references Books.title (title_no),
	constraint fk_loan_member foreign key (member_no) references Memberships.member (member_no),
	constraint fk_loan_item foreign key (isbn) references Books.item (isbn),
	constraint fk_loan_copy foreign key (copy_no) references Books.copy (copy_no)
;
go

alter table Transactions.loanhist
add
constraint fk_loanhist_title foreign key (title_no) references Books.title (title_no),
constraint fk_loanhist_member foreign key (member_no) references Memberships.member (member_no),
constraint fk_loanhist_item foreign key (isbn) references Books.item (isbn),
constraint fk_loanhist_copy foreign key (copy_no) references Books.copy (copy_no)
;
go

alter table Memberships.adult
	add constraint fk_adult_member foreign key (adult_member_no) references Memberships.member (member_no)
;
go

alter table Memberships.juvenile
	add 
	constraint fk_juvenile_member foreign key (juvenile_member_no) references Memberships.member (member_no),
	constraint fk_juvenile_adult foreign key (adult_member_no) references Memberships.adult (adult_member_no)
;
go

alter table Memberships.adult
	add constraint df_adult_state
	default 'WA' for state
;
go

alter table Transactions.loan
	add constraint ck_out_date_due_date
	check (due_date > out_date)
;
go
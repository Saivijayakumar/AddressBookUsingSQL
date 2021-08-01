-------------UC1: Creating DataBase---------
create database Address_Book_service_DB;
use Address_Book_service_DB;
------------UC2: Create Table and Adding Attributes
create table Address_Book_Table
(FirstName varchar(100) not null,LastName varchar(100),Address varchar(200),City varchar(100),State varchar(100),Zip bigint,PhoneNumber Bigint,Email varchar(100));
select * from Address_Book_Table;
----------UC3: Insert values to Attributes-----------
Insert into Address_Book_Table values('sai','kumar','Gandinagar second street','Nellore','Ap',53423,9857778489,'kumar@gmail.com'),
('Arun','k','Gandinagar Third street','Hyderabad','TS',54423,9474738489,'arun@gmail.com'),('sasi','kanth','Gandinagar street','Nellore','Ap',53423,888585854,'sasi22@gmail.com'),
('vijaya','M','36 Newburgh','Goa','TN',53333,93757889809,'luck@gmail.com');
select * from Address_Book_Table;
-------------UC4: Edit Contacts------------
update Address_Book_Table set Email='arun.k@gmail.com' where FirstName = 'Arun';
select * from Address_Book_Table where FirstName ='Arun';
------------UC5 : Delete Contact-----------
delete from Address_Book_Table where FirstName = 'sai';
----------------UC6: Retrieve person Belonging to city or state------
select * from Address_Book_Table where City = 'Hyderabad' or State = 'AP';
-------------UC7: Count Of Person Base On State and City-------------
select count(*) as TotalCount,State from Address_Book_Table group by State;
select count(*) as TotalCount,City from Address_Book_Table group by City;
select * from Address_Book_Table;
-------------UC8: Display the contacts in Sorted Order-----
select * from Address_Book_Table order by (FirstName);
--------------UC9: Identify each Address Book with Name and Type-----------
alter table Address_Book_Table add AddressBookName varchar(100) not null default 'LocalBook',Type varchar(100) not null default 'LocalType';

update Address_Book_Table set AddressBookName='Good',Type = 'Family' where State='Ap';
update Address_Book_Table set AddressBookName='Perfect',Type = 'Profession' where State='TN';
select * from Address_Book_Table;
------------------UC10 : Display count of Contacts Based on Type---------------
select count(*) as TotalContacts,Type from Address_Book_Table group by Type;

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
select * from Address_Book_Table;
------------------UC11:Adding person to Both Friends and Family Type
insert into Address_Book_Table values 
('sasi','kanth','Gandinagar street','Nellore','Ap',53423,888585854,'sasi22@gmail.com','Good','Friend');
select * from Address_Book_Table;
------------------UC12:Implementing ER Dagram----
create table AddressBook
(AddressBookID int identity(1,1) primary key,AddressBookName varchar(50));

insert into AddressBook values ('Rockers'),('Silent');
select * from AddressBook;

create table PersonType(
PersonTypeID int identity(1,1) primary key,PersonType varchar(50));

insert into PersonType values ('Family'),('Friend'),('Profession');
select * from PersonType;

create table Person(
PersonID int identity(1,1) primary key,
AddressBookID int,
FirstName varchar(50),
LastName varchar(50),
Address Varchar(50),
City varchar(50),
State varchar(50),
ZipCode int ,
PhoneNumber bigint,
EmailID varchar(30),
foreign key (AddressBookID) references AddressBook(AddressBookID));

insert into Person values (1,'Ram','K','Egmore','Chennai','TN',694938,9984948393,'Ram@gmail.com'),
(2,'vijay','B','Palakkad','Kochin','TN',89889,998848383,'Vijay@gmail.com'),
(2,'kumar','V','SBI','Nellore','AP',524137,98664983939,'Kumar2@gmail.com');
select * from Person;

create table PersonTypeMap(
PersonID int foreign key references Person(PersonID),
PersonTypeID int foreign key references PersonType(PersonTypeID)
);

insert into PersonTypeMap values (1,1),(2,2),(3,3),(2,1);

select * from PersonTypeMap;
------------UC13:Ensure all retrieve queries done especially in UC 6, UC 7, UC 8 andUC 10 are working with new table structure
----Retrive all data using parent child relation
select p.PersonID,concat(p.FirstName,'.',p.LastName)as Name,concat(p.Address,',',p.City,',',p.State,',',p.ZipCode) as Address,p.PhoneNumber,p.EmailID,
pt.PersonTypeID,pt.PersonType,ab.AddressBookID ,ab.AddressBookName
from AddressBook ab,Person p,PersonType pt,PersonTypeMap ptm
where ab.AddressBookID=p.AddressBookID  and p.PersonID=ptm.PersonID and ptm.PersonTypeID=pt.PersonTypeID;
-------------Retrive  using city or state
select p.PersonID,concat(p.FirstName,'.',p.LastName)as Name,concat(p.Address,',',p.City,',',p.State,',',p.ZipCode) as Address,p.PhoneNumber,p.EmailID,
pt.PersonTypeID,pt.PersonType,ab.AddressBookID ,ab.AddressBookName
from AddressBook ab,Person p,PersonType pt,PersonTypeMap ptm
where (ab.AddressBookID=p.AddressBookID  and p.PersonID=ptm.PersonID and ptm.PersonTypeID=pt.PersonTypeID) and (City='Nellore' or State='AP') ;
--------------Retrive count of person by city and state
-----State
select count(*)as PersonCount,State
from Person 
inner join AddressBook on Person.AddressBookID= AddressBook.AddressBookID group by State;
----City
select count(*)as PersonCount,City
from Person 
inner join AddressBook on Person.AddressBookID= AddressBook.AddressBookID group by City;
-------------------Retrive with Name Order
select p.PersonID,concat(p.FirstName,'.',p.LastName)as Name,
concat(p.Address,',',p.City,',',p.State,',',p.ZipCode) as Address,p.PhoneNumber,p.EmailID,
pt.PersonTypeID,pt.PersonType,ab.AddressBookID ,ab.AddressBookName
from AddressBook ab,Person p,PersonType pt,PersonTypeMap ptm
where (ab.AddressBookID=p.AddressBookID  and p.PersonID=ptm.PersonID and ptm.PersonTypeID=pt.PersonTypeID) and (State='TN') order by FirstName;
----------------------Number of Persons using Type
SELECT COUNT(*) as RelationCount,pt.PersonType FROM
PersonTypeMap AS ptm 
inner join PersonType as pt On pt.PersonTypeId = ptm.PersonTypeId
inner join Person as p on p.PersonId = ptm.PersonId GROUP BY pt.PersonType;
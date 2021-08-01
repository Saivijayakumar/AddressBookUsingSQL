-------------UC1: Creating DataBase---------
create database Address_Book_service_DB;
use Address_Book_service_DB;
------------UC2: Create Table and Adding Attributes
create table Address_Book_Table
(FirstName varchar(100) not null,LastName varchar(100),Address varchar(200),City varchar(100),State varchar(100),Zip bigint,PhoneNumber Bigint,Email varchar(100)); 
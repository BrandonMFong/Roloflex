create table Contacts
(
ID int primary key,
Guid char(16) not null,
Firstname varchar(100),
Lastname varchar(100),
Phonenumber varchar(50),
Email varchar(100),
StartDate Datetime
);

create table Passwords
(
ID int primary key,
Guid char(16) not null,
Value varchar(100),
StartDate datetime
);
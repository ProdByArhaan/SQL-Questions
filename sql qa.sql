select database();
create database employee;
use employee;
create table employee(id int primary key auto_increment, 
name varchar(100), city varchar(100), department varchar(50), salary int);

create table department(id int primary key auto_increment, 
name varchar(100));

create table company(id int primary key auto_increment, 
name varchar(100), revenue int);

select * from department;
select * from company;
select * from employee;

insert into department values(1,'IT');
insert into department(id,name) values(3, 'IT'),
(4, 'Support');

insert into company values(1, 'IBM', 2000000),
(2, 'GOOGLE', 9000000),
(3, 'Apple', 10000000);
insert into employee values(1, 'David', 'London', 'IT', 80000),
(2, 'Emily', 'London', 'IT', 70000),
(3, 'Peter', 'Paris', 'IT', 60000),
(4, 'Ava', 'Paris', 'IT', 50000),
(5, 'Penny', 'London', 'Management', 110000),
(6, 'Jim', 'London', 'Management', 90000),
(7, 'Amy', 'Rome', 'Support', 30000),
(8, 'Cloe', 'London', 'IT', 110000);

select * from department;

update department set name='Management' where id=1;
SET SQL_SAFE_UPDATES = 0;

delete from employee where salary>100000; 
select name from company;



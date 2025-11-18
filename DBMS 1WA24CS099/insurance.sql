create database insurance23;
use insurance23;

create table PERSON023
(
driver_id varchar(10) primary key,
name varchar(20),
address varchar(10)
);

create table car13
(
reg_num varchar(20) primary key,
model char(10),
year int
);

create table owns23
(
driver_id varchar(10),
reg_num varchar(10),
foreign key(driver_id) references PERSON023(driver_id),
foreign key(reg_num) references car13(reg_num)
);

create table participated31
(
driver_id varchar(10),
reg_num varchar(20),
report_num int primary key,
damage_amount int,
foreign key(driver_id) references PERSON023(driver_id),
foreign key(reg_num) references car13(reg_num)
);

create table accident41
(
report_num int,
accident_date date,
location varchar(20),
foreign key(report_num) references participated31(report_num)
);

select * from PERSON023,car13,owns23;
insert into person023 values ('A01','Richard','Srinivas');
insert into person023 values ('A02','Pradeep','Rajaji');
insert into person023 values ('A03','Smith','Ashok');
insert into person023 values ('A04','Venu','NRcolony');
insert into person023 values ('A05','jhon','hanmanth');
select * from person023;

insert into car13 values ('KA052250','I',1990);
insert into car13 values ('KA031181','L',1957);
insert into car13 values ('KA095477','T',1998);
insert into car13 values ('KA095478','T',1998);

select * from car13;

alter table PERSON023 add email varchar(255);
select * from PERSON023;

insert into owns23 values ('A01','KA052250');
select * from owns23;
insert into  accident41 (report_num,accident_date,location) values (12,'2025-9-01','mysore_road');
insert into  accident41 values (12,'02-SEP-2025','south_end_circle');


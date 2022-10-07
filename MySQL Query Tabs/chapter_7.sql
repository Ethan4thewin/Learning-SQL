create table string_tbl
(id smallint unsigned primary key auto_increment,
char_fld char(30),
vchar_fld varchar(30),
text_fld text
);

select * from string_tbl;
desc string_tbl;
drop table `sakila`.`string_tbl`;

delete from string_tbl
where id = 3;

insert into string_tbl (char_fld, vchar_fld, text_fld)
values ( 'this is char data',
'this is varchar data',
'this is text data'
);

update string_tbl
set vchar_fld = 'This is a piece of extremely long varchar data'
where id = 1;

update string_tbl
set text_fld = 'This string didn''t work, but it does now'
where id = 1;

select quote(text_fld)
from string_tbl;

SELECT CONCAT('danke sch', CHAR(148), 'n');
SELECT ASCII('ö');

insert into string_tbl (char_fld, vchar_fld, text_fld)
values ( 'This string is 28 characters',
'This string is 28 characters',
'This string is 28 characters'
);

select length(char_fld), length(vchar_fld), length(text_fld)
from string_tbl;

select position('characters' in vchar_fld)
from string_tbl;

select locate('is', vchar_fld, 5)
from string_tbl;

select name, name like '%y'
from category;

select name, name regexp 'y$' ends_in_y
from category;

insert into string_tbl (text_fld)
values ('This string was 29 characters');
update string_tbl
set text_fld = concat(text_fld, ', but now it is longer')
where id = 4;

select * from string_tbl;

select concat(c.first_name, ' ', c.last_name, ' has been a customer since ', date(c.create_date)
) as lol
from customer as c;

select insert('hello world', 6, 0, ' fun') string;
select insert('hello world', 1, 5, ' goodbye') string;

Select concat(
upper(substring(c.first_name,1,1)),
lower(substring(c.first_name,2))
)
from customer as c;

select mod(22.75 , 5);
select pow(2,8);
select
pow(2,10) kilobyte,
pow(2,20) megabyte,
pow(2,10) gigabyte,
pow(2,10) terabyte;

select ceil(72.0555), floor(72.0555);
select round(72.5416165, 2);
select truncate(72.0555, 0), truncate(72.0555, 2), truncate(72.0555, 1);
select truncate(27, -1), round(27, -1);

create table account_temp
(account_id int,
acct_type varchar(30),
balance float(5,2)
);

drop table `sakila`.`account_temp`;
select * from account_temp;
desc account_temp;

insert into account_temp ()
values
(123, 'Money Market', 785.22),
(456,'Savings', 0),
(789, 'Checking', 324.22);

alter table account_temp
add primary key(account_id);

update account_temp
set balance = -324.22
where account_id = 789;

select account_id, sign(balance), abs(balance)
from account_temp;

select @@global.time_zone, @@session.time_zone;

select cast('2009/02/25' as date),
cast('15342' as time);

select current_date(), current_time(), current_timestamp(), current_user();
select date_add(current_date(), interval 24 hour);
select date_add(current_date(), interval 2 day);
select date_add(current_timestamp(), interval '2-11' year_month);

select last_day(current_date());
select dayname(current_date());

select extract(minute from current_timestamp());

select datediff('2021-04-14', '2022-04-30');
select '2023-04' - '2021-05';

select cast('56df1651' as unsigned integer);

select substring('Please find the substring in this string',17,9);
select -25.76823 as the_number, abs(-25.76823), sign(-25.76823), round(-25.76823, 2);
select extract(month from current_date());
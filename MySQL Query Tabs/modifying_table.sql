desc person;
desc favourite_food;

insert into person(fname, lname, eye_color, birth_date)
values
('William', 'Turner', 'BR', '1972-05-27');

insert into person(fname, lname, eye_color, birth_date, address, district, city)
values
('Killian', 'Albrighton', 'BL', '1985-12-09', '111 Wall St.', 'New York', 'NY'),
('Susan', 'Smith', 'BL', '1975-11-02', '23 Maple St.', 'Arlington', 'VA');

update person
set eye_color = 'GR'
where person_id = 3;

delete from person
where person_id = 2;

update person
set birth_date = str_to_date('DEC-21-1980', '%b-%d-%Y')
where person_id = 1;

insert into favourite_food (person_id, food)
values
(1, 'pizza'),
(1, 'cookies'),
(1, 'nachos');

select * from person;
select * from favourite_food order by food;
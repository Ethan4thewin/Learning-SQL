create table person (
person_id smallint unsigned,
fname varchar(20),
lname varchar(20),
eye_color enum ('BR','GR','BL'),
birth_date date,
address varchar(30),
district varchar(20),
city varchar(20),
constraint pk_person primary key (person_id)
);

create table favourite_food (
person_id smallint unsigned,
food varchar(20),
constraint pk_favourite_food primary key (person_id, food),
constraint fk_fav_food_person_id foreign key (person_id)
references person (person_id)
);

set foreign_key_checks=0;
alter table person modify person_id smallint unsigned auto_increment;
set foreign_key_checks=1;

drop table favourite_food;
drop table person;

select language_id,
'yo boy' as lang_usage,
language_id * 3.14 as lang_pi,
upper(name) as language_name
from language;

select version (), user(), database();

select * from film_actor;
select distinct actor_id from film_actor order by actor_id;

select concat(cust.first_name, ', ', cust.last_name) as full_name
from (select first_name, last_name, email
from customer
where first_name = 'jessie') as cust;

create temporary table actors_d (
actor_id varchar(20),
first_name varchar(45),
last_name varchar(45)
);

insert into actors_d
select actor_id, first_name, last_name
from actor
where last_name like 'd%';

select * from actors_d;

create view cust_vw as
select first_name, last_name, active, customer_id
from customer;

select concat(first_name, ' ', last_name) full_name
from cust_vw
where active=0;

select film_actor.actor_id, film.title
from film
	inner join film_actor
	on film.film_id = film_actor.film_id
where film_actor.actor_id = 15;

select title, rating, rental_duration
from film
where (rating = 'G' and rental_duration = 3)
	or (rental_duration = 7);

select c.first_name, c.last_name, count(*)
from customer as c
	inner join rental as r
    on c.customer_id = r.customer_id
group by c.first_name, c.last_name
having count(*) >= 40
order by c.last_name;

select customer_id
from rental
where date(rental_date) = '2005-07-05';

select * from rental;

select date('2005-05-24 22:53:30');

SELECT c.email, r.return_date
FROM customer as c
	INNER JOIN rental as r
	ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY 2 desc;
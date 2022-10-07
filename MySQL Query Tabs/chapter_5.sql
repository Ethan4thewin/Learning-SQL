select first_name, last_name, address
from customer as c
	inner join address as a
	using (address_id);

select c.first_name, c.last_name, a.address
from customer c, address a
where c.address_id = a.address_id
	and a.postal_code = 52137;
    
select first_name, last_name, city
from customer as c
	inner join address as a
	on c.address_id = a.address_id
    inner join city as ct
    on a.city_id = ct.city_id;
/* joinning 3 tables */

select first_name, last_name, address
from customer as c join address as a;

select first_name, last_name, address, city
from customer as c
	inner join
		(select address_id, address, city
		from address as a
			inner join city as ct
			on a.city_id = ct.city_id
		where a.district = 'California') as addr
	on c.address_id = addr.address_id;

select title
from actor as a
	inner join film_actor as fa
    on a.actor_id = fa.actor_id
    inner join film as f
    on fa.film_id = f.film_id
where (first_name = 'PENELOPE' and last_name = 'GUINESS')
	or (first_name = 'NICK' and last_name = 'WAHLBERG');
    
select f.title
from film as f
	inner join film_actor as fa1
    on f.film_id = fa1.film_id
    inner join actor as a1
    on fa1.actor_id = a1.actor_id
    inner join film_actor as fa2
    on f.film_id = fa2.film_id
    inner join actor as a2
    on fa2.actor_id = a2.actor_id
where (a1.first_name = 'CATE' and a1.last_name = 'MCQUEEN')
	and (a2.first_name = 'NICK' and a2.last_name = 'WAHLBERG');

select * from film_actor;
select * from actor;
select * from film;
select * from address;

select f.title, concat(a.first_name, ' ',a.last_name) as full_name
from film_actor as fa
	inner join actor as a
	on fa.actor_id = a.actor_id
    inner join film as f
    on fa.film_id = f.film_id
where a.first_name = 'JOHN';

select ct.city, a1.address as add_1, a2.address as add_2
from city as ct
	inner join address as a1
    on ct.city_id = a1.city_id
    inner join address as a2
    on ct.city_id = a2.city_id
where a1.address_id <> a2.address_id;
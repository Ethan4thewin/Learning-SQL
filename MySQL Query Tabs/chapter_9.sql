select first_name, last_name, customer_id
from customer
where customer_id <> (select max(customer_id) from customer);

select city_id, city, country_id
from city
where country_id not in
(select country_id
from country
where country = 'canada' or country = 'mexico');

select * from city;
select * from rental;

select first_name, last_name
from customer
where customer_id <> all
(select customer_id
from payment
where amount = 0);

select customer_id, count(*)
from rental
group by customer_id
having count(*) > all
(select count(*)
from rental as r
	inner join customer as c
    on r.customer_id = c.customer_id
    inner join address as a
    on c.address_id = a.address_id
    inner join city as ct
    on ct.city_id = a.city_id
    inner join country as co
    on co.country_id = ct.country_id
where co.country in ('United States','Mexico','Canada')
group by r.customer_id);

select customer_id, sum(amount)
from payment
group by customer_id
having sum(amount) > any
(select sum(p.amount)
from payment as p
	inner join customer as c
    on p.customer_id = c.customer_id
    inner join address as a
    on c.address_id = a.address_id
    inner join city as ct
    on ct.city_id = a.city_id
    inner join country as co
    on co.country_id = ct.country_id
where co.country in ('Bolivia','Paraguay','Chile')
group by co.country_id);

select actor_id, film_id
from film_actor
where (actor_id, film_id) in
(select a.actor_id, f.film_id
from actor as a
	cross join film as f
where a.last_name ='Monroe'
	and f.rating = 'PG'
);

select c.first_name, c.last_name
from customer as c
where (
select count(*)
from rental as r
where r.customer_id = c.customer_id) between 20 and 22;

select c.first_name, c.last_name
from customer as c
where (
select sum(p.amount)
from payment as p
where p.customer_id = c.customer_id) between 180 and 220;

select c.first_name, c.last_name
from customer as c
where exists (
select * from rental as r
where r.customer_id = c.customer_id
	and r.rental_date < '2005-05-25');
    
select a.first_name, a.last_name
from actor as a
where not exists
(select fa.actor_id
from film_actor as fa
	inner join film as f on fa.film_id = f.film_id
    where fa.actor_id = a.actor_id
		and f.rating ='R');

select c.first_name, c.last_name, temp.num_rent, temp.total_payment
from customer as c
	inner join
		(select customer_id, count(*) as num_rent, sum(amount) as total_payment
		from payment
		group by customer_id) as temp
	on c.customer_id = temp.customer_id;
    
select temp.Name, sum(cust.tot_payment), count(*) num_cust
from
	(select 'Small Fry' Name, 0 low_limit, 74.99 high_limit
	union all
	select 'Average Joes', 75, 149.99
	union all
	select 'Heavy Hitters', 150, 9999999.99) as temp
inner join
	(select customer_id, count(*) as num_rentals, sum(amount) as tot_payment
	from payment
	group by customer_id) as cust
on cust.tot_payment between temp.low_limit and temp.high_limit
group by temp.Name;

select c.first_name, c.last_name, ct.city, count(*) as num_rentals, sum(amount) as tot_payment
from payment as p
	inner join customer as c
    on p.customer_id = c.customer_id
    inner join address as a
    on c.address_id = a.address_id
    inner join city as ct
    on a.city_id = ct.city_id
group by p.customer_id;


select c.first_name, c.last_name, ct.city, temp.num_rentals, temp.tot_payment
from
		(select customer_id, count(*) as num_rentals, sum(amount) as tot_payment
		from payment
		group by customer_id) as temp
    inner join customer as c
    on c.customer_id = temp.customer_id
    inner join address as a
    on c.address_id = a.address_id
    inner join city as ct
    on a.city_id = ct.city_id
group by temp.customer_id;

select
	(select c.first_name from customer as c
	where c.customer_id = p.customer_id) as first_name,
	(select c.last_name from customer as c
	where c.customer_id = p.customer_id) as last_name,
	(select ct.city from customer as c
		inner join address as a
        on c.address_id = a.address_id
        inner join city as ct
        on a.city_id = ct.city_id
	where c.customer_id = p.customer_id) as city,
    count(*) as num_rentals,
    sum(amount) as tot_payments
from payment as p
group by p.customer_id;

select * from payment;
select * from inventory;
select * from rental;

with actor_s as
	(select actor_id, first_name, last_name
	from actor
	where last_name like 'S%'),
actor_s_pg as
	(select s.first_name, s.last_name, f.film_id
	from actor_s as s
		inner join film_actor as fa
		on s.actor_id = fa.actor_id
		inner join film as f
		on fa.film_id = f.film_id
    where f.rating = 'PG'),
actor_s_pg_rev as
	(select spg.first_name, spg.last_name, p.amount as sump
    from actor_s_pg as spg
		inner join inventory as i
        on spg.film_id = i.film_id
        inner join rental as r
        on i.inventory_id = r.inventory_id
        inner join payment as p
        on r.rental_id = p.rental_id)
select spgrev.first_name, spgrev.last_name, sum(spgrev.sump)
from actor_s_pg_rev as spgrev
group by spgrev.first_name, spgrev.last_name
order by 3 desc;

select *
from actor as a
order by (select count(*) from film_actor as fa
			where fa.actor_id = a.actor_id) desc;
            
select * from category;
select * from film_category;

select * from film as f
	inner join film_category as fc
    on fc.film_id = f.film_id
where fc.category_id =
	(select c.category_id
	from category as c
	where name = 'Action');
    
select * from film as f
where exists (
	select 1
	from film_category as fc
		inner join category as c
		on fc.category_id = c.category_id
	where fc.film_id = f.film_id
		and c.name ='Action');
        
select act_role.first_name, act_role.last_name, temp.level
from
	(SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
	UNION ALL
	SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
	UNION ALL
	SELECT 'Newcomer' level, 1 min_roles, 19 max_roles) as temp
inner join
	(select a.actor_id, a.first_name, a.last_name, count(*) as num_roles
	from actor as a
		inner join film_actor as fa
		on a.actor_id = fa.actor_id
        group by a.actor_id) as act_role
where act_role.num_roles between temp.min_roles and temp.max_roles;
create view customer_vw (customer_id, first_name, last_name, email)
as
select customer_id, first_name, last_name,
	concat(substring(email,1,2), '******', substring(email,-6))
from customer;

select cv.first_name, cv.last_name, p.amount
from customer_vw as cv
	inner join payment as p
    on cv.customer_id = p.customer_id
where p.amount > 11;

select * from customer_vw;

create view sales_by_film_category
as
select c.name as category, sum(p.cmount) as total_sales
from category as c
	inner join film_category as fc on fc.category_id = c.category_id
    inner join film as f on f.film_id = fc.film_id
    inner join inventory as i on i.film_id = f.film_id
    inner join rental as r on r.inventory_id = i.inventory_id
    inner join payment as p on p.rental_id = r.rental_id
group by c.name
order by 2 desc;

# all of the films, along with the film category, the number of actors
# appearing in the film, the total number of copies in inventory, and the number of
# rentals for each film.

create view film_stats as
select f.film_id, f.title,
	(select c.name from category as c
		inner join film_category as fc
		on fc.category_id = c.category_id
		where f.film_id = fc.film_id) as category,
    (select count(*) from film_actor as fa
		where fa.film_id = f.film_id) as num_actors,
    (select count(*) from inventory as i
		where i.film_id = f.film_id) as num_available,
    (select count(*) from rental as r
		inner join inventory as i
        on i.inventory_id = r.inventory_id
        where f.film_id = i.film_id) as num_rentals
from film as f;

select * from payment;

select datediff(max(payment_date), min(payment_date))
from payment;
# the number of days difference in the dataset

select * from payment
where payment_date >= now() - interval 3 month;
# the last 3 months in a dataset that are happened now

select max(payment_date) from payment;

select * from payment
where payment_date between '2005-11-14 15:16:03' and '2006-02-14 15:16:03';

create view customer_vw (customer_id, first_name, last_name, email)
as
select customer_id, first_name, last_name,
	concat(substring(email,1,2), '******', substring(email,-6))
from customer;

update customer_vw
set last_name = upper('creepingson')
where customer_id = 1;

select * from customer_vw;
select * from customer;

create view cust_detail
as
select c.active, c.customer_id, c.store_id, c.first_name, c.last_name,
	c.address_id, a.address, ct.city, cn.country, a.postal_code, c.create_date
from customer as c
	inner join address as a on c.address_id = a.address_id
    inner join city as ct on a.city_id = ct.city_id
    inner join country as cn on ct.country_id = cn.country_id;
    
select * from cust_detail order by 2 desc;

drop view cust_detail;

update cust_detail
set last_name = 'SMITH', active = 0
where customer_id =1;
update cust_detail
set address = '27 Helling Way'
where customer_id =1;

insert into cust_detail (active, customer_id, store_id, first_name, last_name, address_id, create_date)
values (1, 600, 2, 'ETHAN', 'BRADBERRY', 5, now());

select * from film;

create view film_ctgry_actor
as
select a.first_name, a.last_name, c.name as category_name, f.title
from actor as a
	inner join film_actor as fa on fa.actor_id = a.actor_id
    inner join film as f on f.film_id = fa.film_id
    inner join film_category as fc on fc.film_id = f.film_id
    inner join category as c on c.category_id = fc.category_id;

select * from film_ctgry_actor;

SELECT title, category_name, first_name, last_name
FROM film_ctgry_actor
WHERE last_name = 'FAWCETT';

select * from customer;

create view country_payment
as select cn.country,
	(select sum(p.amount) from payment as p
    inner join customer as c on c.customer_id = p.customer_id
    inner join address as a on a.address_id = c.address_id
    inner join city as ct on ct.city_id = a.city_id
    where cn.country_id = ct.country_id) as tot_payments
from country as cn;

select * from country_payment;
drop view country_payment;
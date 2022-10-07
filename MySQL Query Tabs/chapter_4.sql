select first_name, last_name, create_date
from customer
where (first_name <> 'STEVEN' and last_name <> 'YOUNG')
	and create_date > '2006-01-01';

select * from customer;

select title, rating
from film
where rating not in ('G', 'PG');

select title, rating
from film
where title like '_E_L%' or title like 'Y%';

select rental_id, customer_id, return_date
from rental
where return_date is null
	or return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';

select payment_id, customer_id, amount, date(payment_date)
from payment
where payment_id between 101 and 120;

select *
from customer
where last_name like '_A%W%';
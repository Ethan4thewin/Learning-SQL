select customer_id, count(*)
from rental
group by customer_id
having count(*) >= 40;

select customer_id,
max(amount) max_amt,
min(amount) min_amt,
avg(amount) avg_amt,
sum(amount) sum_amt,
count(*) num_payments
from payment
group by customer_id;

select
count(customer_id),
count(distinct customer_id)
from payment;

select max(datediff(return_date, rental_date))
from rental;

create table temp_tbl
(val smallint);
insert into temp_tbl
values (1), (3), (5);

select count(*) num_rows,
count(val) num_vals,
max(val) max_val,
min(val) min_val,
avg(val) avg_val,
sum(val) sum_val
from temp_tbl;

insert into temp_tbl
values (NULL);

select fa.actor_id, f.rating,count(*)
from film_actor as fa
	inner join film as f
    on fa.film_id = f.film_id
group by fa.actor_id, f.rating
having count(*) > 9;

select extract(year from rental_date) as year1,
count(*) how_many
from rental
group by year1;

select customer_id, count(*), sum(amount)
from payment
group by customer_id
having count(*) >= 40;
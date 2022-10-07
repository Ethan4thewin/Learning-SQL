select f.film_id, f.title, count(i.inventory_id), r.rental_date
from film as f
	right outer join inventory as i
    on f.film_id = i.film_id
    left outer join rental as r
    on r.inventory_id = i.inventory_id
group by f.film_id;

select c.name, l.name
from language as l
	cross join category as c;

select days.dt, count(r.rental_id)
from rental as r
right outer join
	(SELECT date_add('2005-01-01', interval (ones.num + tens.num + hundreds.num) day) dt
	from
		(SELECT 0 num UNION ALL
		SELECT 1 num UNION ALL
		SELECT 2 num UNION ALL
		SELECT 3 num UNION ALL
		SELECT 4 num UNION ALL
		SELECT 5 num UNION ALL
		SELECT 6 num UNION ALL
		SELECT 7 num UNION ALL
		SELECT 8 num UNION ALL
		SELECT 9 num) ones
	cross join
		(SELECT 0 num UNION ALL
		SELECT 10 num UNION ALL
		SELECT 20 num UNION ALL
		SELECT 30 num UNION ALL
		SELECT 40 num UNION ALL
		SELECT 50 num UNION ALL
		SELECT 60 num UNION ALL
		SELECT 70 num UNION ALL
		SELECT 80 num UNION ALL
		SELECT 90 num) tens
	CROSS JOIN
		(SELECT 0 num UNION ALL
		SELECT 100 num UNION ALL
		SELECT 200 num UNION ALL
		SELECT 300 num) hundreds
	where date_add('2005-01-01', interval (ones.num + tens.num + hundreds.num) day) < '2006-01-01'
	order by 1) days
on days.dt = date(r.rental_date)
group by days.dt
order by 1;

select c.first_name, c.last_name, r.rental_date
from (
	select customer_id, first_name, last_name
    from customer) as c
	natural join rental as r;

select Customer.Name, sum(Payment.Amount)
from
	(select 101 Payment_id, 1 Customer_id, 8.99 Amount
	union all
	select 102 Payment_id, 3 Customer_id, 4.99 Amount
	union all
	select 103 Payment_id, 1 Customer_id, 7.99 Amount) as Payment
right outer join
	(select 1 Customer_id, 'John Smith' Name
	union all
	select 2 Customer_id, 'Kathy Jones' Name
	union all
	select 3 Customer_id, 'Greg Oliver' Name) as Customer
on Customer.Customer_id = Payment.Customer_id
group by Customer.Customer_id;

select (nums.num + tens.num +1) temp
from
	(SELECT 0 num UNION ALL SELECT 1 num UNION ALL
	SELECT 2 num UNION ALL SELECT 3 num UNION ALL
	SELECT 4 num UNION ALL SELECT 5 num UNION ALL
	SELECT 6 num UNION ALL SELECT 7 num UNION ALL
	SELECT 8 num UNION ALL SELECT 9 num) as nums
cross join
	(SELECT 0 num UNION ALL SELECT 10 num UNION ALL
	SELECT 20 num UNION ALL SELECT 30 num UNION ALL
	SELECT 40 num UNION ALL SELECT 50 num UNION ALL
	SELECT 60 num UNION ALL SELECT 70 num UNION ALL
	SELECT 80 num UNION ALL SELECT 90 num) as tens
order by 1;
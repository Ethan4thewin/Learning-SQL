select quarter(payment_date) as quarter,
	monthname(payment_date) as month,
	sum(amount) as monthly_sales,
    max(sum(amount)) over() as max_overall_sales,
    max(sum(amount)) over(partition by quarter(payment_date)) as max_qrtr_sales
from payment
where year(payment_date) = 2005
group by 1,2;

select quarter(payment_date) as quarter,
	monthname(payment_date) as month,
	sum(amount) as monthly_sales,
    rank() over(partition by quarter(payment_date) order by sum(amount) desc) as sales_rank
from payment
where year(payment_date) = 2005
group by 1,2
order by 1, month(payment_date);

select customer_id, count(*),
	dense_rank() over(order by count(*) desc) as ranking
from rental as r
group by customer_id
order by 2 desc;

select * from
(select customer_id, month(rental_date), count(*),
	rank() over(partition by month(rental_date) order by count(*) desc) as ranking
from rental
group by month(rental_date), customer_id
order by 2,3 desc) as cust_rank
where ranking <= 5;

select customer_id, month(payment_date), amount,
	sum(amount) over() grand_total,
    sum(amount) over(partition by month(payment_date))
from payment
where amount >= 10
order by 2;

select month(payment_date),
	sum(amount) monthly_total,
    round(sum(amount) / sum(sum(amount)) over() * 100, 4) as pct_of_total,
    case sum(amount)
		when max(sum(amount)) over() then 'Highest'
        when min(sum(amount)) over() then 'Lowest'
        else 'Middle'
	end discriptor
from payment
group by 1
order by 1;

select yearweek(payment_date) payment_week,
	sum(amount) week_total,
    sum(sum(amount)) over(order by yearweek(payment_date) rows unbounded preceding) rolling_sum,
    avg(sum(amount)) over(order by yearweek(payment_date) rows between 1 preceding and 1 following) rolling_avg_3wk
from payment
group by 1;

select date(payment_date), sum(amount),
	avg(sum(amount)) over(order by date(payment_date) 
		range between interval 3 day preceding and interval 3 day following) as 7day_avg
from payment
group by 1;

select yearweek(payment_date) payment_week,
	sum(amount) week_total,
    lag(sum(amount),1) over(order by yearweek(payment_date)) pre_week_tot,
    lead(sum(amount),1) over(order by yearweek(payment_date)) next_week_tot,
    round(
		((sum(amount) / lag(sum(amount),1) over(order by yearweek(payment_date)))-1)*100,
        2) as differences
from payment
group by 1 order by 1;

select f.title,
	group_concat(a.last_name order by a.last_name separator ', ')
from actor as a
	inner join film_actor as fa on a.actor_id = fa.actor_id
    inner join film as f on fa.film_id = f.film_id
group by f.title
having count(*) =3;

select * from rental;

select year(payment_date) year_no,
	month(payment_date) month_no,
	count(*) tot_sales,
    rank() over(order by count(*) desc) as sales_rank,
    lag(count(*),1) over(order by month(payment_date)) prev_tot_sales
from payment
where year(payment_date) = 2005
group by 1,2
order by 1,2;
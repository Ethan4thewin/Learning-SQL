select first_name, last_name,
	case
    when active = 1 then 'active'
    else 'inactive'
    end activity_type
from customer;

select first_name,last_name,
	case when active = 0 then 0
		else (select count(*) from rental as r
			where r.customer_id = c.customer_id)
	end num_rentals
from customer as c;

select monthname(rental_date) rental_month,
	count(*) num_rentals
from rental as r
where rental_date between '2005-05-01' and '2005-08-01'
group by 1;

select
	sum(case when monthname(rental_date) = 'May' then 1
		else 0 end) as May_rentals,
	sum(case when monthname(rental_date) = 'June' then 1
		else 0 end) as June_rentals,
	sum(case when monthname(rental_date) = 'July' then 1
		else 0 end) as July_rentals
from rental;

select a.first_name, a.last_name,
	case
		when exists (select 1 from film_actor as fa
		inner join film as f on f.film_id = fa.film_id
        where fa.actor_id = a.actor_id
			and f.rating = 'G') then 'Y' else 'N'
	end g_actor,
    case
		when exists (select 1 from film_actor as fa
		inner join film as f on f.film_id = fa.film_id
        where fa.actor_id = a.actor_id
			and f.rating = 'PG') then 'Y' else 'N'
	end pg_actor,
    case
		when exists (select 1 from film_actor as fa
		inner join film as f on f.film_id = fa.film_id
        where fa.actor_id = a.actor_id
			and f.rating = 'NC-17') then 'Y' else 'N'
	end nc17_actor
from actor as a;

select f.title,
	case (select count(*) from inventory as i
	where i.film_id = f.film_id)
		when 0 then 'Out Of Stock'
        when 1 then 'Scarce'
        when 2 then 'Scarce'
        when 3 then 'Available'
        when 4 then 'Available'
        else 'Common'
	end film_availbility
from film as f;

select c.first_name, c.last_name,
sum(p.amount) tot_payment,
count(p.amount) num_rentals,
	case when count(p.amount) = 0 then 0
		else sum(p.amount) / count(p.amount)
	end avg_payment
from customer as c
	inner join payment as p
    on c.customer_id = p.customer_id
group by c.first_name, c.last_name
order by 4;

update customer
set active =
	case
		when 90 <= (select datediff(now(), max(rental_date))
					from rental as r
                    where r.customer_id = c.customer_id)
		then 0 else 1
	end
where active = 1;

select c.first_name, c.last_name,
	case when a.address is null then 'Unknown'
		else a.address
    end address,
    case when ct.city is null then 'Unknown'
		else ct.city
    end city,
    case when cn.country_id is null then 'Unknown'
		else cn.country_id
    end country_id
from customer c
	left outer join address a
    on c.address_id = a.address_id
    left outer join city ct
    on a.city_id = ct.city_id
    left outer join country cn
    on cn.country_id = ct.country_id;
    
SELECT name,
CASE name
WHEN 'English' THEN 'latin1'
WHEN 'Italian' THEN 'latin1'
WHEN 'French' THEN 'latin1'
WHEN 'German' THEN 'latin1'
WHEN 'Japanese' THEN 'utf8'
WHEN 'Mandarin' THEN 'utf8'
ELSE 'Unknown'
END character_set
FROM language;

select name,
	case
		when name in ('English', 'Italian', 'French', 'German') then 'latin1'
        when name in ('Japanese', 'Mandarin') then 'utf8'
        else 'Unknown'
	end character_set
from language;

SELECT rating, count(*)
fROM film
GROUP BY rating;

select
	sum(case when rating = 'PG' then 1 end) as PG,
	sum(case when rating = 'G' then 1 end) as G,
    sum(case when rating = 'NC-17' then 1 end) as NC17,
    sum(case when rating = 'PG-13' then 1 end) as PG13,
    sum(case when rating = 'R' then 1 end) as R
from film;
select 1 num, 'abc' str
union
select 9, 'xyz';

select 'cust' typ, c.first_name, c.last_name
from customer as c
union all
select 'actr', a.first_name, a.last_name
from actor as a
order by first_name, last_name;

select c.first_name, c.last_name
from customer as c
where c.last_name like 'L%'
union
select a.first_name, a.last_name
from actor as a
where a.last_name like 'L%'
order by last_name;
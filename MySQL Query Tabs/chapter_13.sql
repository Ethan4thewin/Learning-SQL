alter table customer
add index idx_email (email);

alter table customer
add index idx_full_name (last_name, first_name);

alter table customer
drop index idx_full_name;

alter table customer
add unique index idx_email (email);

desc customer;
show index from customer;
show index from rental;

INSERT INTO customer
(store_id, first_name, last_name, email, address_id, active)
VALUES
(1,'ALAN','KAHN', 'ALAN.KAHN@sakilacustomer.org', 394, 1);

explain
SELECT customer_id, first_name, last_name
FROM customer
WHERE first_name LIKE 'S%' AND last_name LIKE 'P%';

select * from payment;

alter table rental
add constraint fk_rental_customer foreign key (customer_id)
references customer (customer_id) on delete restrict;

alter table payment
add index idx_date_amount (payment_date, amount);
create index idx_date_amount
on payment (payment_date, amount);

alter table payment
drop index idx_date_amount;

show index from payment;
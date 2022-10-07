show table status like 'customer';
alter table customer engine = InnoDB;

start transaction;

insert into Transaction1 (txn_id, txn_date, account_id, txn_type_cd, amount)
values (1003, current_date(), 123, 'D', 50),
(1004, current_date(), 789, 'C', 50);

update Account1
set avail_balance = 450, last_activity_date = now()
where account_id = 123;

update Account1
set avail_balance = 125, last_activity_date = now()
where account_id = 789;

commit;
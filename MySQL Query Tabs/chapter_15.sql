desc actor;

select table_name, table_type, table_schema
from information_schema.tables;

select table_name, is_updatable, table_schema
from information_schema.views;

select table_name, column_name, character_maximum_length, numeric_scale, numeric_precision
from information_schema.columns
where table_schema = 'sakila'
order by 1;

select constraint_name, table_name, constraint_type
from information_schema.table_constraints
where table_schema = 'sakila'
order by 2;

select *
from information_schema.statistics
where table_schema = 'sakila';

SHOW TABLES FROM INFORMATION_SCHEMA;

select tbl.table_name,
	(select count(*) from information_schema.columns as clm
		where clm.table_name = tbl.table_name
		and clm.table_schema = tbl.table_schema) num_columns,
    (select count(*) from information_schema.statistics as sta
		where sta.table_name = tbl.table_name
		and sta.table_schema = tbl.table_schema) num_indexes,
	(select count(*) from information_schema.table_constraints as tc
		where tc.table_name = tbl.table_name
		and tc.table_schema = tbl.table_schema
        and tc.constraint_type = upper('primary key')) num_primary_keys
from information_schema.tables as tbl
where tbl.table_schema = 'sakila' and tbl.table_type = 'BASE TABLE';

set @qry = 'select customer_id, first_name, last_name from customer';
select @qry;
prepare dynsql1 from @qry;
execute dynsql1;
deallocate prepare dynsql1;

set @qry = 'select customer_id, first_name, last_name from customer where customer_id = ?';
prepare dynsql2 from @qry;
set @custid = 9;
execute dynsql2 using @custid;
set @custid = 135;
execute dynsql2 using @custid;
deallocate prepare dynsql2;

select
concat('select ',
	concat_ws(',', cols.col1, cols.col2, cols.col3, cols.col4,
		cols.col5, cols.col6, cols.col7, cols.col8, cols.col9),
        ' from customer where customer_id = ?')
into @qry
from
	(SELECT
	max(CASE WHEN ordinal_position = 1 THEN column_name ELSE NULL END) col1,
	max(CASE WHEN ordinal_position = 2 THEN column_name	ELSE NULL END) col2,
	max(CASE WHEN ordinal_position = 3 THEN column_name	ELSE NULL END) col3,
	max(CASE WHEN ordinal_position = 4 THEN column_name	ELSE NULL END) col4,
	max(CASE WHEN ordinal_position = 5 THEN column_name	ELSE NULL END) col5,
    max(CASE WHEN ordinal_position = 6 THEN column_name	ELSE NULL END) col6,
	max(CASE WHEN ordinal_position = 7 THEN column_name	ELSE NULL END) col7,
	max(CASE WHEN ordinal_position = 8 THEN column_name	ELSE NULL END) col8,
	max(CASE WHEN ordinal_position = 9 THEN column_name	ELSE NULL END) col9
    from information_schema.columns
    where table_schema = 'sakila' and table_name = 'customer'
    group by table_name) cols;

select @qry;
    
prepare dynsql3 from @qry;
set @custid = 45;
execute dynsql3 using @custid;
deallocate prepare dynsql3;

select * from information_schema.statistics
where table_schema = 'sakila';

select table_name, index_name, seq_in_index, column_name
from information_schema.statistics
where table_schema = 'sakila' and table_name = 'customer';
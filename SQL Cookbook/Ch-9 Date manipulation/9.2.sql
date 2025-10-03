use practice;
create table t1 (ids int);
insert into t1 values (1);

select * from cal_dim_table;
-- Number of days in a year(using caalendar table)
-- mistake in the query it takes today's date and just add 365(1 year) in that date which returns no_of_days 
-- correctly if we use a date before february, the moment you use date that comes after january you are going to make mistakes.
select count(date_add('2024-01-03', interval 1 year)) as no_of_days from cal_dim_table
where date_year=year(current_date);

-- (using t1 table)
-- first subtract the number of days passed +1 then it reaches first day of the year 

select datediff((curr_year + interval 1 year),curr_year) as no_of_days
from 
(select adddate(current_date,-dayofyear(current_date)+1) curr_year -- not using DATE_ADD since it takes INTERVAL ,not direct values
 from t1
) x ;
select  adddate(current_date,-dayofyear(current_date)+1);

-- most direct way to just count everything
SELECT 
    COUNT(*) AS no_of_days 
FROM 
    cal_dim_table 
WHERE 
    date_year = YEAR(CURRENT_DATE) ;

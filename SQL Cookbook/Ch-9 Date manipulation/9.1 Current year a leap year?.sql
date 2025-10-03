use practice;
select * from cal_dim_table;
-- 1. Whether the year is leap year or not?

-- All leap years between 2000 and 2050
select date_year,count(cal_month_day)as no_of_days from cal_dim_table where date_month=2
group by date_year
having count(cal_month_day)=29;

-- current year is leap year or not 
select date_year,(day(
last_day(
date_add(
date_add(date_add('2025-08-01',interval -dayofyear('2025-08-01') day), interval 1 day),interval 1 month)))) dy
from cal_dim_table
where date_year=year('2025-08-01')
group by 1;

-- 
with recursive cte as(
-- Base Case: Start at the first day of February
select year('2025-08-01') as year,1 as cal_month_day 
from cal_dim_table
union all
-- Recursive Case: Increment the day until it reaches 29
select year('2025-08-01') as year,cal_month_day+1
from cte
where cal_month_day < 29)
select year,max(cal_month_day) as last_day_of_februrary  -- if 29 a leap year
from cte
group by 1;




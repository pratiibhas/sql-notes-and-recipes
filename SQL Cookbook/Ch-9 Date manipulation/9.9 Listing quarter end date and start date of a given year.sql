-- When given a year and quarter in the format of YYYYQ (four-digit year, one-digit
-- quarter), you want to return the quarter’s start and end dates.
use practice;

 with cte as(
SELECT 
   SUBSTRING(yrq, 5) as quarter,
    CONCAT(SUBSTRING(yrq, 1, 4), '-',
            LPAD(MOD(yrq, 10)*3-2 ,2,'0'),'-','01') AS quarter_start_date,
    CONCAT(SUBSTRING(yrq, 1, 4), '-',
           LPAD(MOD(yrq, 10) * 3 , 2, '0'), '-01') AS quarter_last_date       
            
from(
select 20051 as yrq  union all
select 20052 as yrq union all
select 20053 as yrq  union all
select 20054 as yrq ) x)
select quarter,cast(quarter_start_date as date) as quarter_start_date,
cast(quarter_last_date as date) as quarter_last_date 
 from cte;




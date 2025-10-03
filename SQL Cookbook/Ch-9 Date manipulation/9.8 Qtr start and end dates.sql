-- You want to return the start and end dates for each of the four quarters of a given
-- year.
use practice;
with recursive cte  as(select adddate(current_date ,interval -dayofyear(current_date)+1 day) as qtr,1 as cnt
union all 
select adddate(qtr,interval 3 month) as qtr,cnt+1
from cte
where cnt+1<=4
)
select cnt as QTR,
qtr as QUARTER_START,
adddate(adddate(qtr , interval 3 month),interval -1 day) as QTR_END_DATE
FROM cte;

-- cookbook's approach
with recursive x as (
select
adddate(current_date,(-dayofyear(current_date))+1) dy
,1 as id
union all
select adddate(dy, interval 3 month ), id+1
from x
where id+1 <= 4
 )
 
select quarter(adddate(dy,-1)) QTR
, date_add(dy, interval -3 month) Q_start
, adddate(dy,-1) Q_end
 from x
 order by 1;
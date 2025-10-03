-- You want to find all the dates in a year that correspond to a given day of the week. For
-- example, you may want to generate a list of Fridays for the current year.
with recursive cte as(

select adddate(current_date ,-dayofyear(current_date)+1) as current_day
union all
select date_Add(current_day, interval 1 day) current_day
from cte 
where year(current_day)='2025')
select * from cte
where dayofweek(current_day)=6;


WITH RECURSIVE cal (dy, yr) AS (
    -- Base Case: Start with the first day of the current year
    SELECT 
        DATE_ADD(DATE_SUB(CURRENT_DATE, INTERVAL DAYOFYEAR(CURRENT_DATE) - 1 DAY), INTERVAL 0 DAY) AS dy,
        YEAR(CURRENT_DATE) AS yr
    UNION ALL
    -- Recursive Case: Add one day at a time, staying within the same year
    SELECT 
        DATE_ADD(dy, INTERVAL 1 DAY),
        yr
    FROM cal
    WHERE YEAR(DATE_ADD(dy, INTERVAL 1 DAY)) = yr
)
-- Final Query: Select only Fridays
SELECT dy 
FROM cal
WHERE DAYOFWEEK(dy) = 6;


-- first day of the year
select adddate(
adddate(current_date,
interval -dayofyear(current_date) day),
interval 1 day ) dy;

-- COOKBOOK's solution
 with recursive cal (dy,yr)
 as
(select dy, extract(year from dy) as yr
 from
(select 
adddate(adddate(current_date, interval -dayofyear(current_date) day), interval 1 day) dy) tmp
union all
 select date_add(dy, interval 1 day), yr
from cal
where extract(year from date_add(dy, interval 1 day)) = yr)
select dy from cal
where dayofweek(dy) = 6

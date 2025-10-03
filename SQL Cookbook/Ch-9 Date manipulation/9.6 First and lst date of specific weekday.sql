-- Determine the first and last occurence of a specific weekday

use practice;
select * from cal_dim_table;

select date_month,min(cal_date)as first_occurence_of_sunday,max(cal_date) as last_occurence_of_sunday
from (
select date_month,cal_date,cal_weekday
from cal_dim_table where date_month= month(current_date)and date_year=year(current_date)
)a
where cal_weekday=6
group by 1;


select first_monday,
case month(adddate(first_monday,28))
when mth then adddate(first_monday,28) -- if fourth week lied in the same month
else adddate(first_monday,21)-- if fourth week exceeds this month
end last_monday
from (

select case sign(dayofweek(dy)-2) -- return whether the number is positive negative or zero
when 0 then  dy 
when -1 then adddate(dy,abs(7-(dayofweek(dy)-2)))
when 1 then adddate(dy,(7-(dayofweek(dy)-2))) end
 first_monday,
mth
from (
select adddate(adddate(current_date,-day(current_date)),1) dy,
month(current_date) mth
from t1)x)y;
/*
dayofweek(dy): Returns the weekday number (1 = Sunday, 2 = Monday, ..., 7 = Saturday).
Subtracting 2 shifts the range:
Sunday → -1
Monday → 0
Tuesday → 1
Wednesday → 2
Thursday → 3
Friday → 4
Saturday → 5*/

-- for other week days the value we use to subtract can change according ly for example, for tuesday it becomes
-- dayofweek(dy)-3
SELECT SIGN(-12);

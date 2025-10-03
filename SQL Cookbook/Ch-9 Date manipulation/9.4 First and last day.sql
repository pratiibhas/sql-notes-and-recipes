-- first and last day of a month 
-- LAST_DAY is a function
select date_add(current_date,interval -day(current_date)+1 day) first_day,
last_day(current_date) as last_day
select 
hour(current_timestamp) as current_hour,
minute(current_timestamp) as current_min,
second(current_timestamp) as current_second,
day(current_timestamp) as current_day,
month(current_timestamp) as current_month,
year(current_timestamp) as current_year
;

select date_format(current_timestamp,'%k') hr,
date_format(current_timestamp,'%i') min,
date_format(current_timestamp,'%s') sec,
date_format(current_timestamp,'%d') dy,
date_format(current_timestamp,'%m') mon,
date_format(current_timestamp,'%Y') yr
from t1
-- 6.7 Extracting Initials from a Name
/*Problem
You want convert a full name into initials. Consider the following name:
Stewie Griffin
You would like to return:
S.G.*/
use practice;
select concat_ws('.',
substr(substring_index(name, ' ',1),1,1),
substr(substring_index(name,' ',-1),1,1),
'.' ) a
from (select 'Stewie Griffin' as name from t1) x; -- no middle name

select case when cnt=2 then 
        concat_ws('.',
	    substr(substring_index(name, ' ',1),1,1),
		substr(name,length(substring_index(name,' ',1))+2,1),
        substr(substring_index(name,' ',-1),1,1),
        '.' ) 
        else
        trim(trailing '.' from
		concat_ws('.',
        substr(substring_index(name, ' ',1),1,1),
        substr(substring_index(name,' ',-1),1,1)))
        end as a from (
select name,length(name)-length(replace(name,' ','')) as cnt
from (select 'Stewie Griffin' as name from t1) x)y;
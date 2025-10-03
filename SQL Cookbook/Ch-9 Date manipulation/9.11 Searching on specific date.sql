/*You want to search for dates that match a given month, day of the week, or some
other unit of time. For example, you want to find all employees hired in February or
December, as well as employees hired on a Tuesday.*/
use practice;
select * from emp_table
where month(hiredate)=2;

select * from emp_table
where weekday(hiredate)=2;

select * from emp_table
where monthname(hiredate) in ('February','December') or dayname(hiredate)='Tuesday';

-- outputting only names
select ename
from emp_table
where monthname(hiredate) in ('February','December')
or dayname(hiredate) = 'Tuesday'
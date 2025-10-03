use practice;
/*
You want to find which employees have been hired on the same month and weekday.
For example, if an employee was hired on Monday, March 10, 2008, and another
employee was hired on Monday, March 2, 2001, you want those two to come up as a
match since the day of week and month match. In table EMP, only three employees
meet this requirement. You want to return the following result set:
MSG
------------------------------------------------------
JAMES was hired on the same month and weekday as FORD
SCOTT was hired on the same month and weekday as JAMES
SCOTT was hired on the same month and weekday as FORD*/

select 
    CONCAT(e1.ename, ' was hired on the same month and weekday as ', e2.ename) AS msg
from emp_table e1 inner join emp_table e2 
on month(e1.hiredate)=month(e2.hiredate) and weekday(e1.hiredate)=weekday(e2.hiredate)
where e1.ename>e2.ename
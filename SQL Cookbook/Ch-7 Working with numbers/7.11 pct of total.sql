use practice;
-- 7.11 Determining the Percentage of a Total
/*Problem
You want to determine the percentage that values in a specific column represent
against a total. For example, you want to determine what percentage of all salaries are
the salaries in DEPTNO 10 (the percentage that DEPTNO 10 salaries contribute to
the total).
*/

select * from emp_table;
with cte as(
select sum(sal) as s,10 as deptno from emp_table where deptno=10
union
select sum(sal) as s,20 as deptno from emp_table where deptno=20
union 
select sum(sal) as s,30 as deptno from emp_table where deptno=30
),
tot as(
select sum(sal) as s from emp_table)
select deptno,round(c.s*100 /t.s,2) as pct
from  cte c,tot t;

select (sum(
case when deptno = 10 then sal end)/sum(sal)
)*100 as pct from emp_table;


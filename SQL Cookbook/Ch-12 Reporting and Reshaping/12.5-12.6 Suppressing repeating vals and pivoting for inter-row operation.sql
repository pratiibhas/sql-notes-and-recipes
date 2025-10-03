-- 12.5 Suppressing Repeating Values from a Result Set

/* You are generating a report, and when two rows have the same value in a column,
you want to display that value only once. For example, you want to return DEPTNO
and ENAME from table EMP, you want to group all rows for each DEPTNO, and you
want to display each DEPTNO only one time.*/
/*DEPTNO ENAME
------ ---------
10 CLARK
KING
MILLER
20 SMITH
ADAMS
FORD
SCOTT
JONES
30 ALLEN
BLAKE
MARTIN
JAMES
TURNER
WARD*/
use practice;
select * from emp_table;

select ename,
case when lag(deptno) over (partition by deptno)=deptno then null else deptno end as lg
from emp_table;

-- 12.6 Pivoting a Result Set to Facilitate Inter-Row Calculations
/*You want to make calculations involving data from multiple rows. To make your job
easier, you want to pivot those rows into columns such that all values you need are
then in a single row.*/
-- You want to calculate the difference between the salaries of DEPTNO 20 and
-- DEPTNO 10 and between DEPTNO 20 and DEPTNO 30.
select d20_sal - d10_sal as d20_10_diff,
d20_sal - d30_sal as d20_30_diff
 from (
select sum(case when deptno=10 then sal end) as d10_sal,
sum(case when deptno=20 then sal end) as d20_sal,
sum(case when deptno=30 then sal end) as d30_sal
from emp_table
) totals_by_dept;


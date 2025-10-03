use practice;
-- 12.1 Pivoting a Result Set into One Row

/*You want to take values from groups of rows and turn those values into columns in a
single row per group.*/
select sum(case when deptno=10 then 1 else 0 end) as deptno_10,
 sum(case when deptno=20 then 1 else 0 end) as deptno_20,
sum(case when deptno=30 then 1 else 0 end) as deptno_30
from emp_table;

-- for understanding purposes only
select deptno, sum(case when deptno=10 then 1 else 0 end) as deptno_10,
 sum(case when deptno=20 then 1 else 0 end) as deptno_20,
sum(case when deptno=30 then 1 else 0 end) as deptno_30
from emp_table
group by 1;

select max(case when deptno=10 then empcount else null end) as deptno_10,
max(case when deptno=20 then empcount else null end) as deptno_20,
max(case when deptno=30 then empcount else null end) as deptno_30
from(
select deptno, count(*) as empcount
from emp_table
group by deptno)x;

/*This approach uses an inline view to generate the employee counts per department.
CASE expressions in the main query translate rows to columns, getting you to the
following results:
DEPTNO_10 DEPTNO_20 DEPTNO_30
--------- ---------- ----------
3              NULL   NULL
NULL           5      NULL
NULL           NULL   6*/
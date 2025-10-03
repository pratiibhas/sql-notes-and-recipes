
/*3.1 Stacking One Rowset atop Another*/
-- UNION ALL
Select deptno
from emp
union
select deptno
from dept;
 -- OR
 select distinct deptno
from (
select deptno
from emp
union all
select deptno
from dept
);
/*You wouldn’t use DISTINCT in a query unless you had to, and the same rule applies
for UNION: don’t use it instead of UNION ALL unless you have to. For example,
although in this book we have limited the number of tables for teaching purposes, in
real life if you are querying one table, there may be a more suitable way to query a
single table.*/

-- 3.2 Combining Related Rows
/*
You want to return rows from multiple tables by joining on a known common col‐
umn or joining on columns that share common values. For example, you want to dis‐
play the names of all employees in department 10 along with the location of each
employee’s department, but that data is stored in two separate tables. You want the
result set to be the following:*/

select e.ename, d.loc,
e.deptno as emp_deptno,
d.deptno as dept_deptno
from emp e, dept d
where e.deptno = 10; -- BASICALLY CROSS JOIN WITH A CONDITION
-- joins
Select e.ename, d.loc
from emp e inner join dept d
on (e.deptno = d.deptno)
where e.deptno = 10;

-- 3.3 Finding Rows in Common Between Two Tables
/*You want to find common rows between two tables, but there are multiple columns
on which you can join. For example, consider the following view V created from the
EMP table for teaching purposes:*/
use practice;
with cte as(
select ename,job,sal
from emp_table
where job = 'CLERK')
select * from cte;

/*Only clerks are returned from view cte. However, the view does not show all possible
EMP columns. You want to return the EMPNO, ENAME, JOB, SAL, and DEPTNO of
all employees in EMP that match the rows from view V. You want the result set to be
the following:*/
with cte as(
select ename,job,sal
from emp_table
where job = 'CLERK')
select e.empno,e.ename,e.job,e.sal,e.deptno
from emp_table  e, cte v
where e.ename = v.ename
and e.job = v.job
and e.sal = v.sal;

-- You can also use INTERSECT to get common rows between two tables (using EXISTS in MySQL).


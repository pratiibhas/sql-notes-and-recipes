-- 3.7 Determining Whether Two Tables Have the Same Data
/*You want to know whether two tables or views have the same data (cardinality and
values). Consider the following view:*/
with cte as(
select * from emp_table where deptno != 10
union all
select * from emp_table where ename = 'WARD')
select * from cte;
-- You want to determine whether this view has exactly the same data as table EMP_table
with cte as(
select * from emp_table where deptno != 10
union all
select * from emp_table where ename = 'WARD')
select * from cte
;
use practice;

with v as(
select * from emp_table where deptno != 10
union all
select * from emp_table where ename = 'WARD'
)

select *
from (
select e.empno,e.ename,e.job,e.mgr,e.hiredate,
e.sal,e.comm,e.deptno, count(*) as cnt
from emp_table e
group by empno,ename,job,mgr,hiredate,
sal,comm,deptno
) e
where not exists (
select null
from (
select v.empno,v.ename,v.job,v.mgr,v.hiredate,
v.sal,v.comm,v.deptno, count(*) as cnt
from v
group by empno,ename,job,mgr,hiredate,
sal,comm,deptno
) v
where v.empno = e.empno
and v.ename = e.ename
and v.job = e.job
and v.mgr = e.mgr
and v.hiredate = e.hiredate
and v.sal = e.sal
and v.deptno = e.deptno
and v.cnt = e.cnt
and coalesce(v.comm,0) = coalesce(e.comm,0)
)
union all
select *
from (
select v.empno,v.ename,v.job,v.mgr,v.hiredate,
v.sal,v.comm,v.deptno, count(*) as cnt
from v
group by empno,ename,job,mgr,hiredate,
sal,comm,deptno
) v
where not exists (
select null
from (
select e.empno,e.ename,e.job,e.mgr,e.hiredate,
e.sal,e.comm,e.deptno, count(*) as cnt
from emp_table e
group by empno,ename,job,mgr,hiredate,
sal,comm,deptno
) e
where v.empno = e.empno
and v.ename = e.ename
and v.job = e.job
and v.mgr = e.mgr
and v.hiredate = e.hiredate
and v.sal = e.sal
and v.deptno = e.deptno
and v.cnt = e.cnt
and coalesce(v.comm,0) = coalesce(e.comm,0)
);
/*Summary of the Query Logic
1. The first part checks if emp_table has extra records.
2. The second part checks if v has extra records.
3. If both parts return an empty result, v and emp_table have identical data.*/


SELECT COUNT(*) ROWS_RETURNED FROM (
    SELECT * FROM emp_table
    EXCEPT
    SELECT * FROM (
        SELECT * FROM emp_table WHERE deptno != 10
        UNION ALL
        SELECT * FROM emp_table WHERE ename = 'WARD'
    ) v
) diff1

UNION ALL

SELECT COUNT(*) FROM (
    SELECT * FROM (
        SELECT * FROM emp_table WHERE deptno != 10
        UNION ALL
        SELECT * FROM emp_table WHERE ename = 'WARD'
    ) v
    EXCEPT
    SELECT * FROM emp_table
) diff2;

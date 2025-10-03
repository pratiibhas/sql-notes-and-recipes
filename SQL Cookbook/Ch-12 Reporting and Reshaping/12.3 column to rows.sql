-- 12.3  Reverse Pivoting a Result Set
-- You want to transform columns to rows.
with emp_cnts as
(
select sum(case when deptno=10 then 1 else 0 end) as deptno_10,
sum(case when deptno=20 then 1 else 0 end) as deptno_20,
sum(case when deptno=30 then 1 else 0 end) as deptno_30
from emp_table
)

select dept.deptno,
case when deptno=10 then deptno_10 
when deptno=20 then deptno_20 
 when deptno=30 then deptno_30 else null end as cnts
 from emp_cnts cross join
(select deptno from dept where deptno <= 30) dept;
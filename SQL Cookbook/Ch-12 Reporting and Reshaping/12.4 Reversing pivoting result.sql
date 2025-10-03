-- 12.4 Reverse Pivoting a Result Set into One Column
/*You want to return all columns from a query as just one column. For example, you
want to return the ENAME, JOB, and SAL of all employees in DEPTNO 10, and you
want to return all three values in one column.*/

-- The key is to use a recursive CTE combined with Cartesian product to return four
-- rows for each employee. 
use practice;
with recursive four_rows (id)
as
(select 1
union all
select id+1
from four_rows
where id < 4
)
,
x_tab (ename,job,sal,rn )
as
(select e.ename,e.job,e.sal,
row_number()over(partition by e.empno
order by e.empno)
from emp_table e
join four_rows on 1=1)
select case rn
when 1 then ename
when 2 then job
when 3 then cast(sal as char(4))
end emps
from x_tab;
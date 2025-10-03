-- 12.12 Calculating Simple Subtotals
/*For the purposes of this recipe, a simple subtotal is defined as a result set that contains
values from the aggregation of one column along with a grand total value for the
table.*/

/*JOB       SAL
--------- ----------
ANALYST     6000
CLERK       4150
MANAGER     8275
PRESIDENT   5000
SALESMAN    5600
TOTAL      29025*/

-- my appraoch
use practice;

select job, sum(sal) as sal from emp_table
group by 1
union all
select 'Total' as job,sum(sal) from emp_table;

-- ROLLUP Function
select coalesce(job,'TOTAL') job, sum(sal) sal
from emp_table
group by job with rollup;
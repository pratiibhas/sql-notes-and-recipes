-- 12.18  Performing Aggregations over Different Groups/Partitions Simultaneously
/*You want to aggregate over different dimensions at the same time. For example, you
want to return a result set that lists each employee’s name, their department, the num‐
ber of employees in their department (themselves included), the number of employ‐
ees that have the same job (themselves included in this count as well), and the total
number of employees in the EMP table. */

use practice;
select * from emp_table;
select ename,deptno,count(empno) over(partition by deptno) as no_of_emp,
job,
count(empno) over(partition by job) as no_of_emp_same_job,
count(empno) over() as total
from emp_table
order by 2;
-- NOTE: Window function runs after  WHERE CLAUSE

-- 12.19 Performing Aggregations over a Moving Range of Values
/*You want to compute a moving aggregation, such as a moving sum on the salaries in
table EMP. You want to compute a sum for every 90 days, starting with the HIRE‐
DATE of the first employee. You want to see how spending has fluctuated for every
90-day period between the first and last employee hired. You want to return the fol‐
lowing result set:*/

select * from emp_table;
select hiredate,sum(sal) over(order by hiredate range interval 90 day preceding) as moving_sum
from emp_table;

-- 12.20  Pivoting a Result Set with Subtotals
/*You want to create a report containing subtotals and then transpose the results to
provide a more readable report.

 For example, you’ve been asked to create a report
that displays for each department, the managers in the department, and a sum of the
salaries of the employees who work for those managers. Additionally, you want to
return two subtotals: the sum of all salaries in each department for those employees
who have managers, and a sum of all salaries in the result set (the sum of the depart‐
ment subtotals). You currently have the following report*/
-- Cookbook's 
select mgr,
sum(case deptno when 10 then sal else 0 end) dept10,
sum(case deptno when 20 then sal else 0 end) dept20,
sum(case deptno when 30 then sal else 0 end) dept30,
sum(case flag when '11' then sal else null end) total
from (
select deptno,mgr,sum(sal) sal,
cast(grouping(deptno) as char(1))+cast(grouping(mgr) as char(1)) flag
from emp_table
where mgr is not null
group by deptno,mgr with rollup
) x
group by mgr
order by coalesce(mgr,9999);



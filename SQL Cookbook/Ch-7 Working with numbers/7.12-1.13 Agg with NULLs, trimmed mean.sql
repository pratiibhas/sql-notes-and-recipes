use practice;
-- 7.12 Aggregating Nullable Columns
/*Problem
You want to perform an aggregation on a column, but the column is nullable. You
want the accuracy of your aggregation to be preserved, but are concerned because
aggregate functions ignore NULLs. For example, you want to determine the average
commission for employees in DEPTNO 30, but there are some employees who do not
earn a commission (COMM is NULL for those employees). Because NULLs are
ignored by aggregates, the accuracy of the output is compromised. You would like to
somehow include NULL values in your aggregation.*/
select avg(coalesce(comm,0)) as avg_comm
from emp_table
where deptno=30;

-- 7.13 Computing Averages Without High and Low Values
/*Problem
You want to compute an average, but you want to exclude the highest and lowest val‐
ues to (hopefully) reduce the effect of skew. In statistical language, this is known as a
trimmed mean. For example, you want to compute the average salary of all employees
excluding the highest and lowest salaries.*/

select avg(sal) from emp_table
where deptno=20 and 
sal not in(
(select max(sal) from emp_table
where deptno=20),
(select min(sal) from emp_table
where deptno=20)) ;
/*these approaches are valuable to someone analyzing
data within an RDBMS because they don’t require the analyst to
make assumptions that are difficult to test with the relatively limi‐
ted range of statistical tools available in SQL.*/

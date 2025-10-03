use practice;
-- 	7.1 Computing average
select round(avg(sal),2) from emp_table; -- avg ignores nulls 30/2 if one val is null out of three
select deptno,round(avg(sal),2) from emp_table
group by 1;

-- ALternative 
select round(avg(coalesce(sal,0)),2) as avg_sal from emp_table;


-- 7.2  Finding the Min/Max Value in a Column
select min(sal),max(sal) from emp_table; -- min/max also ignore nulls
select deptno, max(sal) from emp_table
group by 1;
-- you can group by even when if nothing other than aggregate functions are listed in the SELECT clause, 
-- you can still group by other columns in the table; for example
select min(comm), max(comm)
from emp
group by deptno;


-- 7.3 Summing the Values in a Column
select sum(sal) from emp_table; -- SUM function will ignore NULLs, but you can have NULL groups
-- 7.4 Counting Rows in a Table
select count(*) from emp_table;
/*COUNT function will ignore NULLs when passed a column name as an
argument, but will include NULLs when passed the * character or any constant*/
select count(*)
from emp_table
group by deptno;
--  7.5 Counting Values in a Column
select count(sal) from emp_table; -- NULLs will be ignored

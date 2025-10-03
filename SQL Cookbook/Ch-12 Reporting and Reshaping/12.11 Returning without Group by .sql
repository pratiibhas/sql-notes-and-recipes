-- 12.11 Returning Non-GROUP BY Columns
/*You are executing a GROUP BY query, and you want to return columns in your select
list that are not also listed in your GROUP BY clause. This is not normally possible,
as such ungrouped columns would not represent a single value per row.*/

/**Say that you want to find the employees who earn the highest and lowest salaries in
each department, as well as the employees who earn the highest and lowest salaries in
each job. You want to see each employee’s name, the department he works in, his job
title, and his salary. You want to return the following result set:*/


/*DEPTNO ENAME JOB SAL DEPT_STATUS JOB_STATUS
------ ------ --------- ----- --------------- --------------
10 MILLER CLERK 1300 LOW SAL IN DEPT TOP SAL IN JOB
10 CLARK MANAGER 2450 LOW SAL IN JOB
10 KING PRESIDENT 5000 TOP SAL IN DEPT TOP SAL IN JOB
20 SCOTT ANALYST 3000 TOP SAL IN DEPT TOP SAL IN JOB
20 FORD ANALYST 3000 TOP SAL IN DEPT TOP SAL IN JOB
20 SMITH CLERK 800 LOW SAL IN DEPT LOW SAL IN JOB
20 JONES MANAGER 2975 TOP SAL IN JOB
30 JAMES CLERK 950 LOW SAL IN DEPT
30 MARTIN SALESMAN 1250 30 WARD SALESMAN 1250 30 ALLEN SALESMAN 1600 LOW SAL IN JOB
LOW SAL IN JOB
TOP SAL IN JOB
30 BLAKE MANAGER 2850 TOP SAL IN DEPT*/

/*This recipe explains a technique for including
ENAME without the need to GROUP BY that column.*/
use practice;
select * from emp_table;
select ename,deptno,job,max(sal)
from emp_table 
group by 1,2,3;
-- this will not work as we wish it to work
with cte as(
select deptno,job,ename,sal, max(sal) over(partition by deptno) as max_sal_in_dept,
min(sal) over(partition by deptno) as min_sal_in_dept,
max(sal) over(partition by job) as max_sal_in_job,
min(sal) over(partition by job) as min_sal_in_job
from emp_table)

select deptno,job,ename,sal, 
case when sal=max_sal_in_dept then 'TOP SAL IN DEPT' 
     when sal=min_sal_in_dept then 'LOW SAL IN DEPT' 
else null end as dept_status,
case when sal=max_sal_in_job then 'TOP SAL IN JOB'
     when sal=min_sal_in_job then 'LOW SAL IN JOB' 
else null end as job_status
 from cte
 order by 1

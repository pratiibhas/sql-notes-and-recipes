-- 12.2 Pivoting a Result Set into Multiple Rows

/*You want to turn rows into columns by creating a column corresponding to each of
the values in a single given column. However, unlike in the previous recipe, you need
multiple rows of output. Like the earlier recipe, pivoting into multiple rows is a fun‐
damental method of reshaping data.*/
use practice;
select ename,job from emp_table;

select (case when job ='Editor' then ename else null  end) as Editor,
(case when job ='Clerk' then ename else null  end )as Clerk,
(case when job ='Salesman' then ename else null  end )as Salesman,
(case when job ='Manager' then ename else null end ) as Manager,
(case when job ='Analyst' then ename else null  end ) as Analyst
from emp_table;
--  When it comes time to pivot the result set, using MIN or MAX should serve
-- as a means to remove NULLs from the result set, not restrict the ENAMEs returned.

select max(case when job ='Editor' then ename else null  end) as Editor,
 max(case when job ='Clerk' then ename else null  end )as Clerk,
 max(case when job ='Salesman' then ename else null  end )as Salesman,
 max(case when job ='Manager' then ename else null end ) as Manager,
 max(case when job ='Analyst' then ename else null  end ) as Analyst
from emp_table;

-- This will not work as receipe 12.1
-- Here, you must make each JOB/ENAME combination unique.
select rn,max(case when job ='Editor' then ename else null  end) as Editor,
 max(case when job ='Clerk' then ename else null  end )as Clerks,
 max(case when job ='Salesman' then ename else null  end )as Sales,
 max(case when job ='Manager' then ename else null end ) as Managers,
 max(case when job ='Analyst' then ename else null  end ) as Analysts,
 max(case when job ='President' then ename else null  end ) as Prez
from (select ename,job ,
row_number()over(partition by job order by ename) rn -- ROW_NUMBER OVER to help make
-- each JOB/ENAME combination unique
 from emp_table) x
group by 1;

/*By simply modifying what you group by (hence the nonaggregate items in the previ‐
ous SELECT list), you can produce reports with different formats.*/

select deptno,job,
max(case when deptno =10 then ename  else null  end) as d10,
max(case when deptno =20 then ename  else null  end) as d20,
max(case when deptno =30 then ename  else null  end) as d30,
max(case when job ='Editor' then ename else null  end) as Editor,
 max(case when job ='Clerk' then ename else null  end )as Clerks,
 max(case when job ='Salesman' then ename else null  end )as Sales,
 max(case when job ='Manager' then ename else null end ) as Managers,
 max(case when job ='Analyst' then ename else null  end ) as Analysts,
 max(case when job ='President' then ename else null  end ) as Prez
from (select ename,job ,deptno,
row_number()over(partition by job order by ename) rn_job,
row_number()over(partition by job order by ename) rn_deptno
 from emp_table) x
group by 1,2,rn_job,rn_deptno;


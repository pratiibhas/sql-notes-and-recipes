use practice;
-- 12.9 Creating Horizontal Histograms
/*you want to display the number of employees in each department as a horizontal his‐
togram with each employee represented by an instance of */
select * from emp_table;
select deptno, lpad('*',count(*),'*') as cnt from emp_table
where deptno is not null
group by 1
order by 1;

-- 12.10 Creating Vertical Histograms
/*You want to generate a histogram that grows from the bottom up. For example, you
want to display the number of employees in each department as a vertical histogram
with each*/
select max(dept_10) d10,
max(dept_20) d20,
max(dept_30) d30
from (
select row_number()over(partition by deptno order by empno) rn,
 case when deptno =10 then "*" else null end as dept_10,
case when deptno =20 then "*" else null end as dept_20,
case when deptno =30 then "*" else null end as dept_30
from emp_table) x
group by rn
order by 1 ,2 ,3 ;




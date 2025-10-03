-- 3.10  Performing Outer Joins When Using Aggregates

/*Begin with the same problem as in Recipe 3.9, but modify table EMP_BONUS such
that the difference in this case is not all employees in department 10 have been given
bonuses. */
select * from emp_bonuses;
CREATE TABLE e_bonus_copy AS 
SELECT * FROM emp_bonuses;
select * from e_bonus_copy;
delete from e_bonus_copy
where empno= 7839;
delete from e_bonus_copy
where empno= 7782;
set sql_safe_updates=0;
-- Consider the EMP_BONUS table and a query to (ostensibly) find both the
-- sum of all salaries for department 10 and the sum of all bonuses for all employees in department 10:
-- NO FULL OUTER JOINS IN MySQL
with cte as(select e.deptno,
e.empno,e.sal,eb.type
from 
emp_table e 
left outer join e_bonus_copy eb
on e.empno=eb.empno
where e.deptno=10
)
select deptno,sum(distinct sal) as total_sal,
sum(sal* case when type=1 then 0.1
                when type=2 then 0.2
                when type=3 then 0.3
                else null end) as total_bonus
from cte;

-- correlated query
select d.deptno,
d.total_sal,
sum(e.sal*case when eb.type = 1 then .1
               when eb.type = 2 then .2
               else .3 end) as total_bonus
from emp_table e,
e_bonus_copy eb,
(
select deptno, sum(sal) as total_sal
from emp_table
where deptno = 10
group by deptno
) d
where e.deptno = d.deptno
and e.empno = eb.empno
group by d.deptno,d.total_sal;




              
                




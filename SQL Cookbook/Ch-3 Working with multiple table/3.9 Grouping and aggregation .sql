-- 3.9 Performing Joins When Using Aggregates
/*You want to perform an aggregation, but your query involves multiple tables. You
want to ensure that joins do not disrupt the aggregation. 

For example, you want to find the sum of the salaries for employees in department 10 along with the sum of
their bonuses. Some employees have more than one bonus, and the join between
table EMP and table EMP_BONUS is causing incorrect values to be returned by the
aggregate function SUM.*/
CREATE TABLE EMP_BONUSES (
    EMPNO INT,
    RECEIVED DATE,
    TYPE INT
);
INSERT INTO EMP_BONUSES (EMPNO, RECEIVED, TYPE) VALUES
(7934, '2005-03-17', 1),
(7934, '2005-02-15', 2),
(7839, '2005-02-15', 3),
(7782, '2005-02-15', 1);

select * from emp_table;
select * from emp_bonuses;

select sum(sal) from emp_table where deptno=10;

with cte as(
select e.empno,e.sal,row_number() over(partition by e.empno order by type) as rn,
           e.sal*case when eb.type = 1 then .1
           when eb.type = 2 then .2
           else .3
           end as bonus
from emp_table e
join emp_bonuses eb
on e.empno=eb.empno)

SELECT 
    SUM(bonus) AS total_bonus, 
    (SELECT SUM(sal) FROM cte WHERE rn = 1) AS total_salary
FROM cte;
/* you can simply use the keyword DISTINCT in the call to the aggregate
function, so only unique instances of each value are used in the computation; can perform the aggregation 
first (in an inline view) prior to joining, thus avoidingthe incorrect computation by the aggregate function 
because the aggregate will already be computed before you even join, */

-- The error occurs because MySQL does not support DISTINCT inside window functions (e.g., SUM(DISTINCT ..) OVER (...) is invalid).

select d.deptno,
d.total_sal,
sum(e.sal*case when eb.type = 1 then .1
               when eb.type = 2 then .2
               else .3 end) as total_bonus
from emp_table e

join emp_bonuses eb 
on e.empno = eb.empno 

join(
       select deptno, sum(sal) as total_sal
       from emp_table
       where deptno = 10
        group by deptno
                       ) d
on e.deptno = d.deptno
group by d.deptno,d.total_sal;





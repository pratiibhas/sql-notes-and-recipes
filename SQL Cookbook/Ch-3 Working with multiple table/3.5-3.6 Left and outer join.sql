-- 3.5 Retrieving Rows from One Table That Do Not
-- Correspond to Rows in Another

/*You want to find rows that are in one table that do not have a match in another table,
for two tables that have common keys. For example, you want to find which depart‐
ments have no employees. The result set should be the following:
DEPTNO       DNAME         LOC
---------- -------------- -------------
40          OPERATIONS     BOSTON*/
use practice;
select * from dept d
left join emp_table e
on d.deptno=e.deptno
where e.deptno is null;

-- here difference between left join and using exists is that we can return many more columns 
SELECT *
FROM dept d
WHERE NOT EXISTS (
    SELECT 1 
    FROM emp_table e
    WHERE e.deptno = d.deptno
);

-- For large datasets, NOT EXISTS is usually faster. 🚀
-- For smaller datasets, LEFT JOIN is often easier to understand. 😊


-- 3.6 Adding Joins to a Query Without Interfering with
-- Other Joins

select * from emp_bonus;
ALTER TABLE emp_bonus 
ADD COLUMN received DATETIME;
UPDATE emp_bonus 
SET received = '2024-07-20' 
WHERE empno = 7369;
UPDATE emp_bonus 
SET received = '2025-07-20' 
WHERE empno = 7900;
UPDATE emp_bonus 
SET received = '2026-07-20' 
WHERE empno = 7934;

select e.ename, d.loc
from emp_table e, dept d
where e.deptno=d.deptno;

/*You want to add to these results the date a bonus was given to an employee, but join‐
ing to the EMP_BONUS table returns fewer rows than you want because not every
employee has a bonus:*/

select e.ename, d.loc,eb.received
from emp_table e, dept d, emp_bonus eb
where e.deptno=d.deptno
and e.empno=eb.empno;

-- returns much lesser rows
select e.ename, d.loc, eb.received
from emp_table e join dept d
on (e.deptno=d.deptno)
left join emp_bonus eb
on (e.empno=eb.empno)
order by 2;
-- solution is to use a outer join
select e.ename, d.loc,
(select eb.received from emp_bonus eb
 where eb.empno=e.empno) as received
 from emp_table e, dept d
 where e.deptno=d.deptno
 order by 2;
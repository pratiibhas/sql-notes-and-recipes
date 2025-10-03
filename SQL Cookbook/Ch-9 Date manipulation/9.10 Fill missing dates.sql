use practice;
-- Create EMP table
CREATE TABLE EMP_table (
    EMPNO INT PRIMARY KEY,
    ENAME VARCHAR(50),
    JOB VARCHAR(20),
    MGR INT,
    HIREDATE DATE,
    SAL INT,
    COMM INT DEFAULT NULL,
    DEPTNO INT
);

-- Insert records
INSERT INTO EMP_table (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES
(7369, 'SMITH', 'CLERK', 7902, '2005-12-17', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '2006-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '2006-02-22', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '2006-04-02', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '2006-09-28', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '2006-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '2006-06-09', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '2007-12-09', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '2006-11-17', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '2006-09-08', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '2008-01-12', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '2006-12-03', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '2006-12-03', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '2007-01-23', 1300, NULL, 10);
with recursive cte as(
select 
date_add(min(hiredate) ,interval -dayofyear(min(hiredate))+1 day) as start_date,
date_add(max(hiredate) ,interval -dayofyear(max(hiredate))+1 day) as end_date
from emp_table
union all
select date_add(start_date,interval 1 month) as s, 
end_date
from cte
where date_add(start_date,interval 1 month)< end_date
)
select c.start_date as date, count(e.hiredate) num_hired
from cte c left join emp_table e
on (extract(year_month from start_date)=extract(year_month from e.hiredate))
group by c.start_date
order by 1;


-- to get values at different level weekwise daywise
-- date_add(start_date,interval 1 month) interval is going to be changed and also values are set to particular week starting point
-- in case of week
with recursive cte as(
select 
date_add(min(hiredate) ,interval -weekofyear(min(hiredate))+1 day) as start_date,
date_add(max(hiredate) ,interval -weekofyear(max(hiredate))+1 day) as end_date,
1 as wk_no -- week 1 as when hiring started  
from emp_table
union all
select date_add(start_date,interval 1 week) as s,
end_date,
wk_no+1
from cte
where date_add(start_date,interval 1 week)< end_date
)
select c.start_date as date,c.wk_no, count(e.hiredate) num_hired
from cte c left join emp_table e
on (extract(year_month from start_date)=extract(year_month from e.hiredate))
group by c.start_date,2
order by 1;
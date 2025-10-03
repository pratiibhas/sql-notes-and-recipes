use practice;

/* 4.12 DELETE ALL RECORDS FROM A TABLE*/

delete from emp;
-- Alternate TRUNCATE and it cannot be undone hence, use with caution
-- check documentation for  detailed view of the performance and rollback differences between
-- TRUNCATE and DELETE in your specific RDBMS.

/*  4.13 DELETING SPECIFIC RECORDS */
delete from emp where deptno = 10;

/* 4.14 DELETING A SINGLE RECORD*/
 delete FROM employee WHERE EMPNO = 7782;
 -- In such a case using primary key in identification is rather a great choice since our RDBMS doesn't allow 
 -- two records to have same primary key
 
/* 4.15 Deleting Referential Integrity Violations*/
-- You want to delete records from a table when those records refer to nonexistent
-- records in some other table. For example, some employees are assigned to departments
--  that do not exist. You want to delete those employees.
delete from emp
where empno not in (select empno from deptno);

-- OR
delete from emp
where not exists (
select * from dept
where dept.deptno = emp.deptno
);
/* 4.16 Deleting Duplicate Records */
create table dupes (id integer, name varchar(10));
insert into dupes values (1, 'NAPOLEON');
insert into dupes values (2, 'DYNAMITE');
insert into dupes values (3, 'DYNAMITE');
insert into dupes values (4, 'SHE SELLS');
insert into dupes values (5, 'SEA SHELLS');
insert into dupes values (6, 'SEA SHELLS');
insert into dupes values (7, 'SEA SHELLS');
select * from dupes order by 1;

delete from dupes  -- For MySQL users you will need slightly different syntax because you cannot reference
                   -- the same table twice in a delete
where id not in (select min(id) from (select id,name from dupes) tmp group by name);
select * from dupes;
-- The first thing to do when deleting duplicates is to define exactly what it means for
-- two rows to be considered “duplicates” of each other.

-- second look for a discrimating column(primarynkey column in most cases).
-- group by duplicated column and take a aggregated function to pick only one record

/*4.17 Deleting Records Referenced from Another Table*/
create table dept_accidents
( deptno integer,
accident_name varchar(20) );
insert into dept_accidents values (10,'BROKEN FOOT'),
(10,'FLESH WOUND'),
(20,'FIRE'),
(20,'FIRE'),
(20,'FLOOD'),
 (30,'BRUISED GLUTE');
select * from dept_accidents;
/*You want to delete from EMP the records for those employees working at a depart‐
ment that has three or more accidents.*/

delete from emp_table
where 
deptno in (
select deptno 
from (select deptno,count(accident_name) as cnt 
from dept_accidents group by deptno) a
where cnt>=3);
-- ------- OR ---------
delete from emp_tb
where deptno in ( 
select deptno
from dept_accidents
group by deptno
having count(*) >= 3);
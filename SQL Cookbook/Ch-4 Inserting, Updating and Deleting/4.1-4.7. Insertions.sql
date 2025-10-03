
/*4.1 SIMPLE INSERTION */
insert into dept (deptno,dname,loc)
values (1,'A','B'),
(2,'B','C');
/*A table can be defined to take default values for specific columns. You want to insert a
row of default values without having to specify those values.*/

insert into D (id) values (default);

/*4.2 INSERTING DEFAULT VALUES */
/* The DEFAULT keyword in the values list will insert the value that was specified as the
default for a particular column during table creation. The keyword is available for all
DBMSs.*/
Create table D (id integer default 0);

/*4.3 OVERRIDING A DEFAULT VALUES */

/*MySQL, PostgreSQL, and SQL Server users have another option available if all col‐
umns in the table are defined with a default value (as table D is in this case). You may
use an empty VALUES list (MySQL) or specify the DEFAULT VALUES clause (Post‐
greSQL and SQL Server) to create a new row with all default values; otherwise, you
need to specify DEFAULT for each column in the table.*/

create table D (id integer default 0, foo varchar(10));

INSERT INTO D (id) VALUES (1);
select * from D;

/*4.4 INSERTING DEFAULT VALUES */
/* You are inserting into a column having a default value, and you want to override that
default value by setting the column to NULL.*/

insert into d (id, foo) values (null, 'Brighten');
select * from d;

/*4.5  COPYING ROWS FROM ONE TABLE TO ANOTHER*/
create table dept_east(deptno int, dname varchar(10),loc varchar(20));
insert into dept_east (deptno,dname,loc)
select deptno,dname,loc from dept 
where loc in ('Boston', 'DC');

/* 4.5 COPYING A TABLE DEFINITION */


create table emp_2 
as
select * from emp
where 1 = 0;

select * from emp;
select * from emp_2; -- returns empty table with same definition as emp

/* When using Create Table As Select (CTAS), all rows from your query will be used to
populate the new table you are creating unless you specify a false condition in the
WHERE clause. In the solution provided, the expression “1 = 0” in the WHERE
clause of the query causes no rows to be returned. Thus, the result of the CTAS state‐
ment is an empty table based on the columns in the SELECT clause of the query.*/

/*4.6 INSERT IN MULTIPLE TABLES*/
/* You want to take rows returned by a query and insert those rows into multiple target
tables. For example, you want to insert rows from DEPT into tables DEPT_EAST,
DEPT_WEST, and DEPT_MID. All three tables have the same structure (same col‐
umns and data types) as DEPT and are currently empty */

-- one by one you can (not at once)
INSERT INTO DEPT_EAST SELECT * FROM DEPT WHERE region = 'EAST';

INSERT INTO DEPT_WEST SELECT * FROM DEPT WHERE region = 'WEST';

INSERT INTO DEPT_MID SELECT * FROM DEPT WHERE region = 'MID';

/* 4.7 BLOCKING INSERTS TO CERTAIN COLUMNS*/

/*You want to prevent users, or an errant software application, from inserting values
into certain table columns. For example, you want to allow a program to insert into
EMP, but only into the EMPNO, ENAME, and JOB columns.*/

-- making views exposing only those columns anf forcing insert to go through that view 
use practice;
create view new_emps as
select empno, ename, job
from emp_table;

insert into emp_table
(empno ,ename, job)
values (1, 'Jonathan', 'Editor');

--  Inline View in SQL  is a subquery (a SELECT statement) that appears in the FROM clause of another SQL query. 
-- It acts as a temporary table that only exists during query execution.
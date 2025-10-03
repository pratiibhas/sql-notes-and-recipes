use practice;

-- 4.11 MERGING RECORDS
/*
You want to conditionally insert, update, or delete records in a table depending on
whether corresponding records exist. (If a record exists, then update; if not, then
insert; if after updating a row fails to meet a certain condition, delete it.) For example,
you want to modify table EMP_COMMISSION such that:

• If any employee in EMP_COMMISSION also exists in table EMP, then update
their commission (COMM) to 1000.

• For all employees who will potentially have their COMM updated to 1000, if their
SAL is less than 2000, delete them (they should not be exist in EMP_[.keep-
together] COMMISSION).

• Otherwise, insert the EMPNO, ENAME, and DEPTNO values from table EMP
into table EMP_COMMISSION.

Essentially, you want to execute either an UPDATE or an INSERT depending on
whether a given row from EMP has a match in EMP_COMMISSION. Then you want
to execute a DELETE if the result of an UPDATE causes a commission that’s too high.*/

select deptno,empno,ename,comm,sal from emp_table ;


select eptno,empno,ename,comm
from emp_comm
order by 1;
/* 	NOT SUPPORTED IN MYSQL
merge into emp_comm ec
using (select * from emp) emp
on (ec.empno=emp.empno)
when matched then
update set ec.comm = 1000
delete where (sal < 2000)
when not matched then
insert (ec.empno,ec.ename,ec.deptno,ec.comm)
values (emp.empno,emp.ename,emp.deptno,emp.comm)*/

INSERT INTO emp_comm (EMPNO, ENAME, EPTNO, COMM)
SELECT EMPNO, ENAME, DEPTNO, 1000 
FROM emp_TABLE
ON DUPLICATE KEY UPDATE 
    COMM = 1000;

DELETE FROM emp_comm 
WHERE EMPNO IN (SELECT EMPNO FROM emp_TABLE WHERE sal < 2000);
SELECT * FROM emp_comm;


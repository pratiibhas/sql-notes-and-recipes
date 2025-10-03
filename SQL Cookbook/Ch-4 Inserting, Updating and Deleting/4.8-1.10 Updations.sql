-- 4.8 MODIFYING RECORDS IN A TABLE
use practice;
/*You want to modify values for some or all rows in a table. For example, you might
want to increase the salaries of everyone in department 20 by 10%. The following
result set shows the DEPTNO, ENAME, and SAL for employees in that department:*/

select d.deptno,ename,round(e.sal*1.10,2) as incremented_sal from emp_table e 
inner join dept d
on e.deptno=d.deptno
where d.deptno=20;
-- or 
SET SQL_SAFE_UPDATES = 0;

update emp_table
set sal = sal*1.10
where deptno = 20;
select * from emp_table; -- updated table
/*When preparing for a mass update, you may want to preview the results. You can do
that by issuing a SELECT statement that includes the expressions you plan to put into
your SET clauses. The following SELECT shows the result of a 10% salary increase:*/
select deptno,
ename,
sal as orig_sal,
sal*.10 as amt_to_add,
sal*1.10 as new_sal
from emp
where deptno=20
order by 1,5;

-- 4.9 UPDATING WHEN CORRESPONDING RECORDS EXIST

/*You want to update rows in one table when corresponding rows exist in another. For
example, if an employee appears in table EMP_BONUS, you want to increase that
employee’s salary (in table EMP) by 20%. The following result set represents the data
currently in table EMP_BONUS:*/
set set_safe_updates=0;
update emp_table
set sal=sal*1.20
where empno in(select empno from emp_bonus);

update emp
set sal = sal*1.20
where exists (select null
from emp_bonus
where emp.empno=emp_bonus.empno );

-- 4.10 UPDATING WITH VALUES FROM ANOTHER TABLE
/* Column DEPTNO is the primary key of table NEW_SAL. You want to update the salaries 
and commission of certain employees in table EMP using values table
NEW_SAL if there is a match between EMP.DEPTNO and NEW_SAL.DEPTNO,
update EMP.SAL to NEW_SAL.SAL, and update EMP.COMM to 50% of
NEW_SAL.SAL.*/

/*DEPTNO   SAL.  -- table new_salary
------ ----------
    10    4000*/
select deptno,ename,sal,comm
from emp_table
order by 1;

update emp_table et, new_salary ns
set sal=ns.sal -- ns.sal 40000 is the new salary
and comm=ns.sal*0.5
where et.deptno=ns.deptno; -- these values 10 nd 40000 are from another table 

/*If you look at the UPDATE statement in the “Problem” section, the join on
DEPTNO between EMP and NEW_SAL is done and returns rows to the SET clause
of the UPDATE statement. For employees in DEPTNO 10, valid values are returned
because there is a matching DEPTNO in table NEW_SAL. But what about employees
in the other departments? NEW_SAL does not have any other departments, so the
SAL and COMM for employees in DEPTNOs 20 and 30 are set to NULL*/




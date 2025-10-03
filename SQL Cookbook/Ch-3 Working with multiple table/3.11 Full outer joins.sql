-- 3.11 Returning Missing Data from Multiple Tables

/*You want to return missing data from multiple tables simultaneously. Returning rows
from table DEPT that do not exist in table EMP (any departments that have no
employees) requires an outer join. Consider the following query, which returns all
DEPTNOs and DNAMEs from DEPT along with the names of all the employees in
each department */

select d.deptno,d.dname,e.ename
from dept d left outer join emp_table e
on (d.deptno=e.deptno);
/*The last row, the OPERATIONS department, is returned despite that department not
having any employees, because table EMP was outer joined to table DEPT. Now, sup‐
pose there was an employee without a department. How would you return the previ‐
ous result set along with a row for the employee having no department?*/
select d.deptno,d.dname,e.ename
from dept d left outer join emp_table e
on (d.deptno=e.deptno) 
union all
select d.deptno,d.dname,e.ename
from dept d right outer join emp_table e
on (d.deptno=e.deptno);
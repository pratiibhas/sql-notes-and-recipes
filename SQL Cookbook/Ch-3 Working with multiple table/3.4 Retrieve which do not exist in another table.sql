-- 3.4 Retrieving Values from One Table That Do Not Exist in Another
-- SET DIFFERENCE

/*Be mindful of NULLs when using NOT IN. Consider the following table,
NEW_DEPT:
create table new_dept(deptno integer)
insert into new_deptvalues (10)
insert into new_dept values (50)
insert into new_dept values (null)
If you try to find the DEPTNOs in table DEPT that do not exist in table NEW_DEPT
and use a subquery with NOT IN, you’ll find that the query returns no rows:*/

/*
In SQL, “TRUE or NULL” is TRUE, but “FALSE or NULL” is NULL! You must keep
this in mind when using IN predicates, and when performing logical OR evaluations
and NULL values are involved.
*/

-- To avoid the problem with NOT IN and NULLs, use a correlated subquery in con‐
-- junction with NOT EXISTS. The term correlated subquery is used because rows from
-- the outer query are referenced in the subquery. 
select d.deptno
from dept d
where not exists (
select 1
from emp e
where d.deptno = e.deptno
/*Conceptually, the outer query in this solution considers each row in the DEPT table.
For each DEPT row, the following happens:

1. The subquery is executed to see whether the department number exists in the
EMP table. Note the condition D.DEPTNO = E.DEPTNO, which brings together
the department numbers from the two tables.

2. If the subquery returns results, then EXISTS (…) evaluates to true and NOT
EXISTS (…) thus evaluates to FALSE, and the row being considered by the outer
query is discarded.

3. If the subquery returns no results, then NOT EXISTS (…) evaluates to TRUE,
and the row being considered by the outer query is returned (because it is for a
department not represented in the EMP table).
The items in the SELECT list of the subquery are unimportant when using a correla‐
ted subquery with EXISTS/NOT EXISTS, which is why we chose to select NULL, to
force you to focus on the join in the subquery rather than the items in the SELECT
list.*/
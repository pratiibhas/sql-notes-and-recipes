-- 12.7 Create buckets of fixed size
/*You want to organize data into evenly sized buckets, with a predetermined number of
elements in each bucket. The total number of buckets may be unknown, but you want
to ensure that each bucket has five elements.*/
-- NUMBER OF ELEMENT IN A BUCKET IS SPECIFIED.
select ceil(row_number()over(order by empno)/5.0) grp,
empno
from emp_table;

select ceil(row_number()over(order by empno)/5.0) cc,row_number()over(order by empno)/5.0  grp ,
row_number()over(order by empno) rn ,empno from emp_table;

-- 12.8 Creating a Predefined Number of Buckets
-- NUMBER OF BUCKETS ARE SPECIFIED , NOT HOW MANY ELEMENT SHOULD BE IN EACH BUCKET
/* You want to organize your data into a fixed number of buckets. For example, you
want to organize the employees in table EMP into four buckets.

This is a common way to organize categorical data as dividing a set into a number of
smaller equal sized sets is an important first step for many kinds of analysis.*/
-- NTILE function 
select ntile(4)over(order by empno) grp,
empno,ename 
from emp_table;
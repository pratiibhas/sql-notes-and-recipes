-- 6.6 Determining Whether a String Is Alphanumeric
with v as (
select ename as data
from emp_table
where deptno=10
union all
select concat(ename,', $', cast(sal as char(4)) ,'.00' )as data
from emp_table
where deptno=20
union all
select concat(ename, cast(deptno as char(4))) as data
from emp_table
where deptno=30)

-- select * from v; -- ur task is to extract only which  contains no characters other than numbers and letters.
/*DATA
-------------
CLARK
KING
MILLER
ALLEN30
WARD30
MARTIN30
BLAKE30
TURNER30
JAMES30 */
select data
from V
where data regexp '[^0-9a-zA-Z]' = 0;
-- In DB such as PostgreSQL and oracle we first replace all numeric , alphabets to some character then we see if it's length is equal to as
-- the length of the original string it is the required data.
/*
1 select data
2 from V
3 where translate(lower(data),
4 '0123456789abcdefghijklmnopqrstuvwxyz',
5 rpad('a',36,'a')) = rpad('a',length(data),'a')*/
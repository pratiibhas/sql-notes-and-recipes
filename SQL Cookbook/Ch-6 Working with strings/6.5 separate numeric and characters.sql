use practice;
-- 6.5 Separating Numeric and Character Data
/*Problem
You have numeric data stored with character data together in one column. This could
easily happen if you inherit data where units of measurement or currency have been
stored with their quantity (e.g., a column with 100 km, AUD$200, or 40 pounds,
rather than either the column making the units clear or a separate column showing
the units where necessary)*/

/*select replace(
2 translate(data,'0123456789','0000000000'),'0','') as ename,
3 cast(
4 replace(
5 translate(lower(data),
6 'abcdefghijklmnopqrstuvwxyz',
7 rpad('z',26,'z')),'z','') as integer) as sal
8 from (
9 select ename||sal as data
10 from emp
11 ) x*/

-- using , REPLACE AND TRANSLATE functions -- mysql doesn;t have trnaslate function

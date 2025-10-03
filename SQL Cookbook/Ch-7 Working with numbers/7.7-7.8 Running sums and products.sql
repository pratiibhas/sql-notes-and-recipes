use practice;
-- 7.6 Generating a Running Total
select * from emp_table;

select ename,sal,
sum(sal) over(order by sal,empno) as running_sum -- using empno to avoid using duplicate salaries
from emp_table;

-- 7.7 Generating a Running Product
select ename,sal,
round(exp(sum(ln(sal))over(order by sal,empno)),1) as running_prod
from emp_table where deptno=10;
/* It is not valid in SQL (or, formally speaking, in mathematics) to compute logarithms
of values less than or equal to zero. If you have such values in your tables, you need to
avoid passing those invalid values to SQL’s LN function. 


The solution takes advantage of the fact that you can multiply two numbers by:
1. Computing their respective natural logarithms
2. Summing those logarithms
3. Raising the result to the power of the mathematical constant e (using the EXP
function)*/


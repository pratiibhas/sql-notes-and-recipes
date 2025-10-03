-- 3.8 Identifying and Avoiding Cartesian Products
select e.ename, d.loc
from emp e, dept d
where e.deptno = 10
and e.deptno=d.deptno;
/*Generally, to avoid a Cartesian product, you would apply the n–1 rule where n
represents the number of tables in the FROM clause and n–1 represents the mini‐
mum number of joins necessary to avoid a Cartesian product.

Depending on what
the keys and join columns in your tables are, you may very well need more than n–1
joins, but n–1 is a good place to start when writing queries.*/
SELECT row_number() OVER () AS n
FROM (SELECT 1 FROM generate_series(1,5) a CROSS JOIN generate_series(1,2) b) t;

-- generate _series is not supported in mysql
SELECT ROW_NUMBER() OVER () AS n
FROM (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) a
CROSS JOIN (SELECT 1 UNION ALL SELECT 2) b; -- 5x2 outputs will be given by the loop, hence row_number 1 to 10 generated.




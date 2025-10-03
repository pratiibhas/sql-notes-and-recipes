use practice;
-- 7.9 Calculating a Mode
select * from emp_table;


select sal from(
select sal,dense_rank() over(order by cnt desc) as rn from(
select sal,count(*) as cnt 
from emp_table
group by sal)x)y
where rn =1;

-- 7.10 Calculating a Median
/* MySQL doesn’t have the PERCENTILE_CONT function, so a workaround is
required. One way is to use the CUME_DIST function in conjunction with a CTE,
effectively re-creating the PERCENTILE_CONT function:*/

with rank_tab (sal, rank_sal) as
(
select sal, cume_dist() over (order by sal)
from emp_table
where deptno=20
),
inter as
(
select sal, rank_sal from rank_tab
where rank_sal>=0.5
union
select sal, rank_sal from rank_tab
where rank_sal<=0.5
)

select avg(sal) as MedianSal
from inter;
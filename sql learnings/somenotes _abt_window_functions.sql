-- Advanced Window functions

-- Alternate to lag function 
 select emp_id, order_number,amount,
 sum(amount) over(order by order_date rows between 1 preceding and 1 preceding) as prev -- works as the lag function
 from tbl;
 
 -- Alternate to lead function 
 select emp_id, order_number,amount,
 sum(amount) over(order by order_date rows between 1 following and 1 following) as prev -- works as the lag function
 from tbl;
 
 -- OTHER POSSIBLE OPTIONS:
 
 -- rows between 1 preceding and 2 preceding 
 -- rows between 1 preceding and 1 following 
 -- rows between 2 preceding and current row
 
 
 -- PROBLEMS WITH RUNNING SUM IN SQL
 use practice;
 select * from products;
  
select product_id,
sum(cost) over(order by cost) as running_cost 
from products; -- will return incorrect answer since there exists a duplicate value in cost column


-- SOLUTION:
-- Introduce another column 
  
select product_id,
sum(cost) over(order by cost asc, product_id) as running_cost 
from products; 

-- Alternate solution
select product_id,
sum(cost) over(order by cost asc rows between unbounded preceding and current row) as running_cost 
from products; 
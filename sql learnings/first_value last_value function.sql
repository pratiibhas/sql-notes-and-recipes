use practice;
select * from emp;

-- first_value function
select *,first_value(emp_name) over(order by salary) as lowest_sal_emp from emp;

select *,first_value(salary) over(order by salary) as lowest_sal_emp from emp;

select *,first_value(emp_name) over(order by emp_age) as lowest_sal_emp_age from emp;

select *,first_value(emp_name) over(partition by department_id order by emp_age) as det_wiselowest_sal_emp_age from emp;


-- last_value function
select *,last_value(emp_name) over(order by salary rows between current row  and unbounded following) as highest_sal_emp from emp;

select *,last_value(salary) over(order by salary rows between current row  and unbounded following) as lowest_sal_emp_age from emp;

select *,
last_value(emp_name) over(partition by department_id order by emp_age rows between current row  and unbounded following)
as det_wiselowest_sal_emp_age 
from emp;
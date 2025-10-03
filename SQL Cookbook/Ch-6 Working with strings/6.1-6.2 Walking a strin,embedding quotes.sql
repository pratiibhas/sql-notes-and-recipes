use practice;
create table t10(
id int
);
INSERT INTO t10 (id) 
VALUES 
    (1), (2), (3), (4), (5), 
    (6), (7), (8), (9), (10);
select * from t10;


-- 6.1 	Walking a string

/*You want to traverse a string to return each character as a row, but SQL lacks a loop
operation.*/
select substr(e.ename,iter.pos,1) as C
from (select ename from emp_table where ename = 'KING') e,
(select id as pos from t10) iter
where iter.pos <= length(e.ename);

-- 6.2 Embedding Quotes Within String Literals

/*Problem
You want to embed quote marks within string literals. You would like to produce
results such as the following with SQL:
QMARKS
--------------
g'day mate
beavers' teeth*/

select 'g''day mate' qmarks from t1 union all
select 'beavers'' teeth' from t1 union all
select '''' from t1;

select 'apples core', 'apple''s core',
case when '' is null then 0 else 1 end
from t1;
select * from t1; 

select '''' as quote from t1; -- be sure to remember that a string literal comprising two
-- quotes alone, with no intervening characters, is NULL.


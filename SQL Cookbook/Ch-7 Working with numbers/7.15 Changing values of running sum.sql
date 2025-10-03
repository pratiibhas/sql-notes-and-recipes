use practice;
-- 7.15 Changing Values in a Running Total
/*You want to modify the values in a running total depending on the values in another
column. Consider a scenario where you want to display the transaction history of a
credit card account along with the current balance after each transaction. The following view, 
V, will be used in this example:*/

with  V (id,amt,trx) as
(
select 1, 100, 'PR' from t1 union all
select 2, 100, 'PR' from t1 union all
select 3, 50, 'PY' from t1 union all
select 4, 100, 'PR' from t1 union all
select 5, 200, 'PY' from t1 union all
select 6, 50, 'PY' from t1)

select * from V;

/*if the value for TRX is PR, you want the current value for AMT
added to the running total. Ultimately you want to return the following result set:*/

/*ed to the running total. Ultimately you want to return the following result set:
TRX_TYPE.  AMT         BALANCE
-------- ---------- ----------
PURCHASE  100         100.           add 100
PURCHASE  100         200
PAYMENT   50          150            subtract 50
PURCHASE  100         250
PAYMENT   200         50
PAYMENT   50          0*/

with  V (id,amt,trx) as
(
select 1, 100, 'PR' from t1 union all
select 2, 100, 'PR' from t1 union all
select 3, 50, 'PY' from t1 union all
select 4, 100, 'PR' from t1 union all
select 5, 200, 'PY' from t1 union all
select 6, 50, 'PY' from t1)

-- select trx,amt,sum(amt) over(order by id,amt) as summ from V; -- running sum

select trx,amt,sum(case when trx='PR' then amt else -amt end)  over(order by id,amt)
 as summ from V;

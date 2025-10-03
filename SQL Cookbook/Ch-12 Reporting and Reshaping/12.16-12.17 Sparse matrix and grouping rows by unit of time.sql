-- 12.16 Creating a Sparse Matrix
/*You want to create a sparse matrix, such as the following one transposing the
DEPTNO and JOB columns of table EMP*/
use practice;
select rn,max(case deptno when 10 then ename end) d10,
max(case deptno when 20 then ename end) d20,
max(case deptno when 30 then ename end) d30,
max(case job when 'CLERK' then ename end) clerks,
max(case job when 'MANAGER' then ename end) mgrs,
max(case job when 'PRESIDENT' then ename end) prez,
max(case job when 'ANALYST' then ename end) anals,
max(case job when 'SALESMAN' then ename end) sales
from (
select deptno, job, ename,
row_number()over(partition by deptno order by empno) rn
from emp_table
) x
group by rn;
-- 12.17 Grouping Rows by Units of Time
/* You want to summarize data by some interval of time. For example, you have a trans‐
action log and want to summarize transactions by five-second intervals. The rows in
table TRX_LOG are shown here */
CREATE TABLE Transx (
    TRX_ID INT PRIMARY KEY,
    TRX_DATE DATETIME,
    TRX_CNT INT
);

INSERT INTO Transx (TRX_ID, TRX_DATE, TRX_CNT) VALUES
(1, '2020-07-28 19:03:07', 44),
(2, '2020-07-28 19:03:08', 18),
(3, '2020-07-28 19:03:09', 23),
(4, '2020-07-28 19:03:10', 29),
(5, '2020-07-28 19:03:11', 27),
(6, '2020-07-28 19:03:12', 45),
(7, '2020-07-28 19:03:13', 45),
(8, '2020-07-28 19:03:14', 32),
(9, '2020-07-28 19:03:15', 41),
(10, '2020-07-28 19:03:16', 15),
(11, '2020-07-28 19:03:17', 24),
(12, '2020-07-28 19:03:18', 47),
(13, '2020-07-28 19:03:19', 37),
(14, '2020-07-28 19:03:20', 48),
(15, '2020-07-28 19:03:21', 46),
(16, '2020-07-28 19:03:22', 44),
(17, '2020-07-28 19:03:23', 36),
(18, '2020-07-28 19:03:24', 41),
(19, '2020-07-28 19:03:25', 33),
(20, '2020-07-28 19:03:26', 19);
select * from Transx;
select ceil(trx_id/5.0) as grp,
min(trx_date) as trx_start, max(trx_date)as trx_end,
sum(trx_cnt) as cnt from Transx
group by 1;

use practice;
-- 7.16 Finding Outliers Using the Median Absolute Deviation
/*Problem
You want to identify values in your data that may be suspect. There are various rea‐
sons why values could be suspect—there could be a data collection issue, such as an
error with the meter that records the value. There could be a data entry error such as
a typo or similar. There could also be unusual circumstances when the data was gen‐
erated that mean the data point is correct, but they still require you to use caution in
any conclusion you make from the data. Therefore, you want to detect outliers */

WITH rank_tab AS (
    SELECT sal, CUME_DIST() OVER (ORDER BY sal) AS rank_sal
    FROM emp_table
),
inter AS (
    SELECT sal FROM rank_tab WHERE rank_sal >= 0.5
    UNION
    SELECT sal FROM rank_tab WHERE rank_sal <= 0.5
),
medianSal AS (
    SELECT (MAX(sal) + MIN(sal)) / 2 AS medianSal
    FROM inter
),
deviationSal AS (
    SELECT e.sal, ABS(e.sal - m.medianSal) AS deviationSal
    FROM emp_table e
    JOIN medianSal m ON 1=1
),
distDevSal AS (
    SELECT sal, deviationSal, CUME_DIST() OVER (ORDER BY deviationSal) AS distDeviationSal
    FROM deviationSal
),
DevInter AS (
    SELECT MIN(deviationSal) AS DevInter FROM distDevSal WHERE distDeviationSal >= 0.5
    UNION
    SELECT MAX(deviationSal) FROM distDevSal WHERE distDeviationSal <= 0.5
),
MAD AS (
    SELECT (MIN(DevInter) + MAX(DevInter)) / 2 AS MedianAbsoluteDeviation
    FROM DevInter
)
SELECT e.sal, m.MedianAbsoluteDeviation, 
       (e.sal - d.deviationSal) / m.MedianAbsoluteDeviation AS NormalizedDeviation
FROM emp_table e
JOIN MAD m ON 1=1
JOIN deviationSal d ON e.sal = d.sal;

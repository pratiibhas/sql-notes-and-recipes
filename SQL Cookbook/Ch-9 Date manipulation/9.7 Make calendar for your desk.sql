/*You want to create a calendar for the current month. The calendar should be format‐
ted like a calendar you might have on your desk: seven columns across and (usually)
five rows down.*/
use practice;

WITH RECURSIVE x (dy, dm, mth, dw, wk) AS (
    -- Step 1: Generate the first day of the current month
    SELECT -- curdate() = current_date
        DATE_SUB(CURDATE(), INTERVAL DAY(CURDATE()) - 1 DAY) AS dy, -- first day of current month
        DAY(DATE_SUB(CURDATE(), INTERVAL DAY(CURDATE()) - 1 DAY)) AS dm,-- current month'd first day date 
        MONTH(curdate()) AS mth,-- current_month
        DAYOFWEEK(DATE_SUB(CURDATE(), INTERVAL DAY(CURDATE()) - 1 DAY)) AS dw,-- first_date's weekday
        CASE 
            WHEN DAYOFWEEK(DATE_SUB(CURDATE(), INTERVAL DAY(CURDATE()) - 1 DAY)) = 1 
            THEN WEEK(DATE_SUB(CURDATE(), INTERVAL DAY(CURDATE()) - 1 DAY)) - 1
            ELSE WEEK(DATE_SUB(CURDATE(), INTERVAL DAY(CURDATE()) - 1 DAY))
        END AS wk -- without his condition our alignement will mess up sunce 5 sunday was part of first week but will appear after second week 
        -- i.e. 6 7 8 9 10 11  5 which is incorrect

    UNION ALL

    -- Step 2: Recursively generate dates for the month
    SELECT 
        DATE_ADD(dy, INTERVAL 1 DAY) AS dy,
        DAY(DATE_ADD(dy, INTERVAL 1 DAY)) AS dm,
        mth,
        DAYOFWEEK(DATE_ADD(dy, INTERVAL 1 DAY)) AS dw,
        CASE 
            WHEN DAYOFWEEK(DATE_ADD(dy, INTERVAL 1 DAY)) = 1 
            THEN WEEK(DATE_ADD(dy, INTERVAL 1 DAY)) - 1
            ELSE WEEK(DATE_ADD(dy, INTERVAL 1 DAY))
        END AS wk
    FROM x
    WHERE MONTH(DATE_ADD(dy, INTERVAL 1 DAY)) = mth
)
-- Step 3: Pivot the data into a calendar-like format
SELECT 
    MAX(CASE WHEN dw = 2 THEN dm END) AS Mo,
    MAX(CASE WHEN dw = 3 THEN dm END) AS Tu,
    MAX(CASE WHEN dw = 4 THEN dm END) AS We,
    MAX(CASE WHEN dw = 5 THEN dm END) AS Th,
    MAX(CASE WHEN dw = 6 THEN dm END) AS Fr,
    MAX(CASE WHEN dw = 7 THEN dm END) AS Sa,
    MAX(CASE WHEN dw = 1 THEN dm END) AS Su
FROM x
GROUP BY wk
ORDER BY wk;


   



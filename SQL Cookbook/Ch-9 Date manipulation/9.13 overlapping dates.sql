use practice;

-- Create the EMP_PROJECT table
CREATE TABLE EMP_PROJECT (
    EMPNO INT,
    ENAME VARCHAR(50),
    PROJ_ID INT,
    PROJ_START DATE,
    PROJ_END DATE
);

-- Insert data into the EMP_PROJECT table
INSERT INTO EMP_PROJECT (EMPNO, ENAME, PROJ_ID, PROJ_START, PROJ_END) VALUES
(7782, 'CLARK', 1, '2005-06-16', '2005-06-18'),
(7782, 'CLARK', 4, '2005-06-19', '2005-06-24'),
(7782, 'CLARK', 7, '2005-06-22', '2005-06-25'),
(7782, 'CLARK', 10, '2005-06-25', '2005-06-28'),
(7782, 'CLARK', 13, '2005-06-28', '2005-07-02'),
(7839, 'KING', 2, '2005-06-17', '2005-06-21'),
(7839, 'KING', 8, '2005-06-23', '2005-06-25'),
(7839, 'KING', 14, '2005-06-29', '2005-06-30'),
(7839, 'KING', 11, '2005-06-26', '2005-06-27'),
(7839, 'KING', 5, '2005-06-20', '2005-06-24'),
(7934, 'MILLER' ,6, '2005-06-21', '2005-06-23');

select * from emp_project;
/*You want to find all instances of an employee starting a new project before ending an
existing project. Consider table EMP_PROJECT:*/

select empno,ename,concat('project ', proj_id, ' overlaps with ','project ',prev_project_id) as msg
 from(
select *,lag(proj_end) over(partition by empno order by  proj_start) as prev_project_endDate,
lag(proj_id) over(partition by empno order by  proj_start) as prev_project_id
from emp_project
) a
where proj_start <=prev_project_endDate;

-- another version
SELECT a.empno, a.ename,
       CONCAT('Project ', b.proj_id, ' overlaps project ', a.proj_id) AS msg
FROM emp_project a
JOIN emp_project b 
    ON a.empno = b.empno 
   AND a.proj_id < b.proj_id  -- Prevents duplicate pairs
   AND (b.proj_start BETWEEN a.proj_start AND a.proj_end 
        OR b.proj_end BETWEEN a.proj_start AND a.proj_end) -- Accounts for all overlaps
ORDER BY a.empno, a.proj_id;


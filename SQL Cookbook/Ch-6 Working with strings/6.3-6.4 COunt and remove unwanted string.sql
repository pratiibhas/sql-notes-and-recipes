-- 6.3 Counting the Occurrences of a Character in a String
/*You want to count the number of times a character or substring occurs within a given
string. Consider the following string:
10,CLARK,MANAGER
You want to determine how many commas are in the string.*/

select (length('10,CLARK,MANAGER')-
length(replace('10,CLARK,MANAGER',',','')))/length(',') -- this division is important if length of string is more than 1
-- getting total length of the string ,then subtracting the length of string which has removed commas
as cnt
from t1;

select length(replace('10,CLARK,MANAGER',',','')) as c,length(',') as v
from t1;

-- 6.4 Removing Unwanted Characters from a String
/*You want to remove specific characters from your data. A scenario where this may
occur is in dealing with badly formatted numeric data, especially currency data,
where commas have been used to separate zeros, and currency markers are mixed in
the column with the quantity.*/

-- You want to remove all zeros and vowels as shown by the following values in columns
-- STRIPPED1 and STRIPPED2:
select replace(ename,'A','') as ename, sal from emp_table; -- using to remove Character 'A'

select ename,
replace(
replace(
 replace(
replace(
replace(ename,'A',''),'E',''),'I',''),'O',''),'U','')
as stripped1,
sal,
replace(sal,0,'') stripped2
from emp_table
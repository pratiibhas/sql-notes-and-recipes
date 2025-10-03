use practice;
-- 7.17 Finding Anomalies Using Benford’s Law
/*Problem
Although outliers, as shown in the previous recipe, are a readily identifiable form of
anomalous data, some other data is less easy to identify as problematic. 
One way to detect situations where there are anomalous data but no obvious outliers is to look at
the frequency of digits, which is usually expected to follow Benford’s law. 

Although using Benford’s law is most often associated with detecting fraud in situations where
humans have added fake numbers to a data set, it can be used more generally to 
detect data that doesn’t follow expected patterns. For example, it can detect errors
such as duplicated data points, which won’t necessarily stand out as outliers.*/

/*Solution
To use Benford’s law, you need to calculate the expected distribution of digits and
then the actual distribution to compare. Although the most sophisticated uses look at
first, second, and combinations of digits, in this example we will stick to just the first
digits. 
BENFORD LAW - states that in naturally occurring datasets, the first digit of numbers (1-9) follows a logarithmic distribution, 
meaning:

The number 1 appears as the first digit ~30.1% of the time.
The number 2 appears as the first digit ~17.6% of the time.
The number 9 appears the least, ~4.6% of the time.

*/
with
FirstDigits (FirstDigit) as  --  Extract the First Digit
(select left(cast(SAL as CHAR),1) as FirstDigit
from emp_table),
TotalCount (Total)
as
(select count(*)     -- Total rows of table
from emp_table),
ExpectedBenford (Digit,Expected)-- Compute the Expected Benford’s Distribution
as
(select value,(log10(value + 1) - log10(value)) as expected
from t10
where value < 10)
select count(FirstDigit),Digit -- Counts occurrences of each first digit from FirstDigits
,coalesce(count(*)/Total,0) as ActualProportion, Expected
From FirstDigits
Join TotalCount
Right Join ExpectedBenford
on FirstDigits.FirstDigit=ExpectedBenford.Digit
group by Digit
order by Digit;
-- If the actual proportions are far from expected, it may indicate fraud or anomalies in the dataset.
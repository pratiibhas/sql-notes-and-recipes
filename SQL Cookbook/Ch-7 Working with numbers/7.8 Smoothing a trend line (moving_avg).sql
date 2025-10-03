use practice;
-- 7.8 Smoothing a Series of Values
/*You have a series of values that appear over time, such as monthly sales figures. As is
common, the data shows a lot of variation from point to point, but you are interested
in the overall trend. Therefore, you want to implement a simple smoother, such as
weighted running average to better identify the trend.*/




/*However, you know that there is volatility to the sales data that makes it difficult to
discern an underlying trend. Possibly different days of the week or month are known
to have especially high or low sales. Alternatively, maybe you are aware that due to
the way the data is collected, sometimes sales for one day are moved into the next day,
creating a trough followed by a peak, but there is no practical way to allocate the sales
to their correct day. Therefore, you need to smooth the data over a number of days to
achieve a proper view of what’s happening.*/

-- moving avarage
select date1, sales,
lag(sales,1) over(order by date1) as salesLagOne,
lag(sales,2) over(order by date1) as salesLagTwo,
(sales
+ (lag(sales,1) over(order by date1))
+ lag(sales,2) over(order by date1))/3 as MovingAverage
from sales;

-- Weighted moving average
select date1, sales,lag(sales,1) over(order by date1),
lag(sales,2) over(order by date1),
((3*sales)
+ (2*(lag(sales,1) over(order by date1)))
+ (lag(sales,2) over(order by date1)))/6 as SalesMA
from sales;
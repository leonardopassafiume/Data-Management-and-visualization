# exercise 1 

select phoneRateType, t.DateYear, sum(price)
from facts f, timedim t, phonerate p
where f.ID_time  = t.ID_time and p.ID_PhoneRate = f.ID_PhoneRate
group by phoneRateType, t.DateYear

select phoneRateType, t.DateYear, sum(price),
    sum(sum(price)) over(partition by phoneRateType) as sum_per_rate,
    sum(sum(price)) over(partition by t.DateYear) as sum_per_year,
    sum(sum(price)) over() as total_income
from facts f, timedim t, phonerate p
where f.ID_time  = t.ID_time and p.ID_PhoneRate = f.ID_PhoneRate
group by phoneRateType, t.DateYear
order by phoneRateType

# exercise 2

select DateMonth, sum(NumberOfCalls) as Calls_Per_Month, sum(price) as income,
    rank() over(order by sum(price) DESC) as ranking
from facts f, timedim t
where f.ID_time = t.ID_time
group by DateMonth

#exercise 3

select DateMonth, sum(NumberOfCalls) as Calls_per_month, 
    rank() over(order by sum(numberofcalls) desc) as ranking
from facts f, timedim t
where DateYear = '2003' and f.ID_time = t.ID_time
group by DateMonth

#exercise 4

select DateMonth, daydate, sum(price) as total_income, 
    avg(sum(price)) over(order by daydate
    					range between interval '2' day preceding and current row) as avglast3days
from facts f, timedim t
where DateMonth = '07-2003' and f.ID_time = t.ID_time
group by daydate, datemonth
order by daydate

#exercise 5

select DateYear, DateMonth, sum(price) as monthly_income, 
    sum(sum(price)) over(partition by dateyear
    					 order by datemonth
    					 rows unbounded preceding) as cumsum
from facts f, timedim t
where f.ID_time = t.ID_time
group by datemonth, dateyear
order by dateyear

# exercise 6

SELECT DATEMONTH, PHONERATETYPE, SUM(PRICE)/COUNT(DISTINCT DAYDATE),
    SUM(PRICE)/SUM(NUMBEROFCALLS)
FROM FACTS F, TIMEDIM T, PHONERATE P
WHERE F.ID_TIME = T.ID_TIME AND P.ID_PHONERATE = F.ID_PHONERATE AND DATEYEAR = '2003'
GROUP BY PHONERATETYPE, DATEMONTH

#EXERCISE 7


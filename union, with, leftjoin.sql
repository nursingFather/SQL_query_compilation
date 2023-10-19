-- Join the table from the three years

use Project;

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$']
) 
select * from hotels
left join dbo.market_segment$ ms
on hotels.market_segment = ms.market_segment
left join dbo.meal_cost$ mc
on mc.meal = hotels.meal


select * from dbo.market_segment$
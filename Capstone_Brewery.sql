--- loading the data into pgadmin

create table brew (
 	SALES_ID
	,SALES_REP
	,EMAILS
	,BRANDS
	,PLANT_COST
	,UNIT_PRICE
	,QUANTITY
	,COST
	,PROFIT
	,COUNTRIES
	,REGION 
	,MONTHS
	,YEARS
)

copy brew from "C:\Program Files\PostgreSQL\13\scripts\International_Breweries.csv" with (Format csv, header);


---------- PROFIT ANALYSIS-----------

select 
	sum(profit) as Total_Profit -- Total Profit
from brew

select territory, sum(profit) as Total_profit
from
	(select	
		*,case 
			when countries in ('Nigeria', 'Ghana') then 'Anglophone'
			when countries in ('Senegal', 'Togo', 'Benin') then 'Francophone'
	 	end as Territory
	from brew
	) a
group by territory ------- comparing territory profit

select countries, sum(profit) as Total_profit from brew
--where profit = (select max(profit) from brew)-- countries with highest profit in 2019
where years = '2019'
group by countries
order by Total_profit desc
limit 1

select years, sum(profit) from brew -- year with the highest profit
group by years
order by sum(profit)
limit 1

select months, sum(profit) from brew------ month with lowest profit
group by months
order by sum(profit) 
limit 1

select min(profit) from brew   --lowest profit in dec 2018
where months = 'December'
and years = '2018'

select months
	   --,sum(profit)
	   ,round ((sum(profit)/ (select 
					   		sum(profit) 
					   from brew 
					   where years = '2019') 
		) * 100, 2) as percent_profit
from brew
where years = '2019'
group by months

select brands, sum(profit) from brew
where countries = 'Senegal'
group by brands
order by sum(profit) desc
limit 1


----- BRAND ANALYSIS------------------------

select brands, sum(profit) as Total_profit
from
	(select	
		*,case 
			when countries in ('Nigeria', 'Ghana') then 'Anglophone'
			when countries in ('Senegal', 'Togo', 'Benin') then 'Francophone'
	 	end as Territory
	from brew
	) a
where territory = 'Francophone'
and years in ('2018', '2019')
group by brands ------- comparing brand profit
order by total_profit desc
limit 1

select brands
	   ,sum(quantity) from brew  ---- top brand in Ghana
where countries = 'Ghana'
group by brands
order by sum(quantity) desc
limit 2

select brands 
	  ,sum(plant_cost) plant_cost
	  ,unit_price, sum(quantity) quantity, sum(cost) total_cost , sum(profit) profit
from brew
where countries = 'Nigeria'
group by brands, unit_price

select brands, sum(Quantity) as Quantity --- favorite malt in anglophone
from
	(select	
		*,case 
			when countries in ('Nigeria', 'Ghana') then 'Anglophone'
			when countries in ('Senegal', 'Togo', 'Benin') then 'Francophone'
	 	end as Territory
	from brew
	) a
where territory = 'Anglophone'
and years in ('2018', '2019')
and brands like '%malt%'
group by brands
order by sum(Quantity) desc
limit 1


select brands---- top 3 brands in NIgeria
	  , sum(quantity) quantity 
from brew
where countries = 'Nigeria'
and years = '2019'
group by brands
order by sum(quantity) desc
limit 3

select brands---- top brand in south_south NIgeria
	  , sum(quantity) quantity 
from brew
where countries = 'Nigeria'
and region = 'southsouth'
group by brands
order by sum(quantity) desc
limit 1

select              --------beer consumption in NIgeria
	  sum(quantity) as  ng_Beer_consumpt
from brew
where countries = 'Nigeria'
and brands not like '%malt%'

select Region             --------budweiser consumption in NIgeria
	 , sum(quantity) as  Budweiser_consumpt
from brew
where countries = 'Nigeria'
and brands = 'budweiser'
group by region

select Region             -------2019 budwweiser consumption in NIgeria
	 , sum(quantity) as  Budweiser_consumpt
from brew
where countries = 'Nigeria'
and brands = 'budweiser'
and years = '2019'
group by region


------------COUNTRIES Analysis---------------
select countries, sum(quantity) beer_consumpt ---- Country with the highest consumption of beer.
from brew
where brands not like '%malt%'
group by countries
order by sum(quantity) desc
limit 1

select sales_rep,  sum(quantity) qty_sold ----Highest sales personnel of Budweiser in Senegal
from brew
where countries = 'Senegal'
and brands = 'budweiser'
group by sales_rep
order by sum(quantity)
limit 1

select countries, sum(profit) total_profit    ---Country with the highest profit of the fourth quarter in 2019
from brew
where months in ('October', 'November', 'December')
and years = '2019'
group by countries
order by total_profit
limit 1

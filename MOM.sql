
With extracted as (
SELECT  [ProductKey]
     /* ,[OrderDateKey]
      ,[DueDateKey]
      ,[ShipDateKey]
      ,[CustomerKey]
      ,[PromotionKey]
      ,[CurrencyKey]
      ,[SalesTerritoryKey]
      ,[SalesOrderNumber]
      ,[SalesOrderLineNumber]
      ,[RevisionNumber] */
      ,[OrderQuantity]
      ,[UnitPrice]
      --,[ExtendedAmount]
      --,[UnitPriceDiscountPct]
      --,[DiscountAmount]
      --,[ProductStandardCost]
      ,[TotalProductCost]
      ,[SalesAmount]
      --,[TaxAmt]
      --,[Freight]
      --,[CarrierTrackingNumber]
      --,[CustomerPONumber]
      ,[OrderDate]
      --,[DueDate]
      --,[ShipDate]
  FROM [AdventureWorksDW2022].[dbo].[FactInternetSales]
),
-- Calculate the monthly sales for each product
	 /*  1. Extract and group the column by yearmonth
		 2. Create a column for previous month using LAG
		 3. Total sales - previoussales / total sale-- usiing lag */
MonthlySales as (
	select
			--[Productkey],
			--count(ProductKey) as salesQ,
			format(OrderDate, 'yyyy-MM') as YearMonth,
			SUM(SalesAmount) AS TotalSales
	from extracted
	group by 
		--ProductKey, 
		FORMAT(OrderDate, 'yyyy-MM')
)
select
	YearMonth,
	TotalSales,
	LAG(TotalSales)over (order by YearMonth) PrevMonth,
	case
		when LAG(TotalSales)over (order by YearMonth) is null
		then 0
		Else ((TotalSales - LAG(TotalSales)over ( order by YearMonth))
		/LAG(TotalSales)over (order by YearMonth)) *100	
		End as MOM_salesGrowth
From MonthlySales
Order by YearMonth










/* RankedSales as (
	select
		ProductKey,
		SalesQ,
		YearMonth, 
		TotalSales,
		ROW_NUMBER() over (partition by YearMonth Order by SalesQ desc) as RK
	FROM  MonthlySales
)
Select
	ProductKey,
	SalesQ,
	YearMonth,
	TotalSales
from RankedSales
where RK <= 5
order by YearMonth, Rk */
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  p.[ProductKey]
      ,p.[ProductAlternateKey] as ProductItemCode
      --,[ProductSubcategoryKey]
      --,[WeightUnitMeasureCode]
      --,[SizeUnitMeasureCode]
      ,p.[EnglishProductName]
	  ,ps.EnglishProductSubcategoryName as [Sub Category]
	  ,pc.EnglishProductCategoryName as [Product Category]
      --,[SpanishProductName]
      --,[FrenchProductName]
      --,[StandardCost]
      --,[FinishedGoodsFlag]
      ,p.[Color]
      --,[SafetyStockLevel]
      --,[ReorderPoint]
      --,[ListPrice]
      ,p.[Size]
      --,[SizeRange]
      --,[Weight]
      --,[DaysToManufacture]
      ,p.[ProductLine]
      --,[DealerPrice]
      --,[Class]
      --,[Style]
      ,p.[ModelName]
      --,[LargePhoto]
      ,p.[EnglishDescription]
      --,[FrenchDescription]
      --,[ChineseDescription]
      --,[ArabicDescription]
      --,[HebrewDescription]
      --,[ThaiDescription]
      --,[GermanDescription]
      --,[JapaneseDescription]
      --,[TurkishDescription]
      --,[StartDate]
      --,[EndDate]
      ,isnull([Status], 'Outdated') as [Product Status]
  FROM [AdventureWorksDW2019].[dbo].[DimProduct] as p
  left join [AdventureWorksDW2019].[dbo].[DimProductSubcategory] ps on p.ProductSubcategoryKey = ps.ProductSubcategoryKey
  left join [AdventureWorksDW2019].[dbo].[DimProductCategory] pc on ps.ProductCategoryKey = ps.ProductCategoryKey
  where [ProductKey] in (select ([ProductKey])
						from [AdventureWorksDW2019].[dbo].[FactInternetSales]
						where left(OrderDateKey, 4) >= YEAR(GETDATE()) -2
						)
  order by ProductKey         
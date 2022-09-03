/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  dc.CustomerKey as  [CustomerKey]
      --,[GeographyKey]
      --,[CustomerAlternateKey]
      --,[Title]
      ,dc.[FirstName] as [FirstName]
      --,[MiddleName]
      ,dc.[LastName] as [LastName]
	  ,FirstName + ' ' + LastName as [Full Name]
      --,[NameStyle]
      --,year([BirthDate])
      --,[MaritalStatus]
      --,[Suffix]
      ,case dc.[Gender] When 'M' then 'Male' when 'F' then 'Female' end as Gender
      --,[EmailAddress]
      --,[YearlyIncome]
      --,[TotalChildren]
      --,[NumberChildrenAtHome]
      --,[EnglishEducation]
      --,[SpanishEducation]
      --,[FrenchEducation]
      --,[EnglishOccupation]
      --,[SpanishOccupation]
      --,[FrenchOccupation]
      --,[HouseOwnerFlag]
      --,[NumberCarsOwned]
      --,[AddressLine1]
      --,[AddressLine2]
      --,[Phone]
        ,dc.[DateFirstPurchase] as DateFirstPurchase
      --,[CommuteDistance]
	  , dg.city as [Customer City]
  FROM [AdventureWorksDW2019].[dbo].[DimCustomer] dc
  left join [AdventureWorksDW2019].[dbo].[DimGeography] dg
  on dg.GeographyKey = dc.GeographyKey
  order by CustomerKey 
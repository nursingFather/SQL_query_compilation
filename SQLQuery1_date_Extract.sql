/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [SNo]
      ,[Name]
      ,[Symbol]
      --,[Date]
	  ,LEFT([Date], 11) as [Date]	  
	  ,day([Date]) as Day
	  ,datename(weekday, [Date]) as Weekday
	  ,datename(month, [Date]) as Month
	  ,year([Date]) as Year
      ,[High]
      ,[Low]
      ,[Open]
      ,[Close]
      ,[Volume]
      ,[Marketcap]
  FROM [Clean_play].[dbo].[Coin_Polkadot$]
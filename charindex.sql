/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [ID]
      ,[Name] as 'competitor Name'
      ,case when [Sex] = 'M' then 'Male' else 'Female' end as [Sex] 
      ,[Age]
	  ,case when [Age] < 18 then 'under 18'
			when [Age] between 18 and 25 then '18-25'
			when [Age] between 25 and 30 then '25-30'
			when [Age] > 30 then 'Over 30' End as [Age group]
      ,[Height]
      ,[Weight]
      ,A1.[NOC] as [country code]
	  ,CHARINDEX(' ', Games)-1 as 'ex1'
	  ,charindex(' ', reverse(Games))-1 as 'ex2'
	  ,left(Games, CHARINDEX(' ', Games)-1) as 'Year'
	  ,right(Games, charindex(' ', reverse(Games))-1) as 'Season'
      ,[Games]
     -- ,[City]
      ,[Sport]
      ,[Event]
	  ,Team as [Country]
	  ,Case when Medal = 'NA' Then 'Not Registered' else Medal end as Medal
     -- ,[Medal]
  FROM [olympic_games].[dbo].[athletes_event_results] a1
  inner join [olympic_games].[dbo].[team_info] a2
  on a1.NOC = a2.NOC
  where right(Games, charindex(' ', reverse(Games))-1) = 'Summer'
 
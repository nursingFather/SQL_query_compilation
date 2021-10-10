/****** Script for SelectTopNRows command from SSMS  ******/
Select  
		Name
		,Department
		,Gender
		,Salary
		,Location
		,Rating
		,[Bonus Rate]
		,(Salary * [Bonus Rate]) as [Bonus Pay]
from 
( select
		Name
	  ,Case when [Gender] = 'Male' then 'Male'
			when [Gender] = 'Female' then 'Female'
			when [Gender] is NULL then 'PNS' end as [Gender]
      ,d.[Department]
      ,[Salary]
      ,[Location]
      ,[Rating]
	  ,[Very Poor] as [Bonus Rate]
FROM [EDNA_challlenge].[dbo].['emp-data$'] d join[EDNA_challlenge].[dbo].['Bonus Rules$'] b
  on d.Department = b.Department
  Where d.Department is not NULL
  And Salary is not NULL
  and Rating = 'Very Poor'
  Union
  SELECT  Name
,Case when [Gender] = 'Male' then 'Male'
			when [Gender] = 'Female' then 'Female'
			when [Gender] is NULL then 'PNS' end as [Gender]
      ,d.[Department]
      ,[Salary]
      ,[Location]
      ,[Rating]
,[Poor] as [Bonus Rate]
FROM [EDNA_challlenge].[dbo].['emp-data$'] d join[EDNA_challlenge].[dbo].['Bonus Rules$'] b
  on d.Department = b.Department
  Where d.Department is not NULL
  And Salary is not NULL
  and Rating = 'Poor'
  union
  SELECT  Name
,Case when [Gender] = 'Male' then 'Male'
			when [Gender] = 'Female' then 'Female'
			when [Gender] is NULL then 'PNS' end as [Gender]
      ,d.[Department]
      ,[Salary]
      ,[Location]
      ,[Rating]
,[Average] as [Bonus Rate]
FROM [EDNA_challlenge].[dbo].['emp-data$'] d join[EDNA_challlenge].[dbo].['Bonus Rules$'] b
  on d.Department = b.Department
  Where d.Department is not NULL
  And Salary is not NULL
  and Rating = 'Average'
  union
  SELECT  Name
,Case when [Gender] = 'Male' then 'Male'
			when [Gender] = 'Female' then 'Female'
			when [Gender] is NULL then 'PNS' end as [Gender]
      ,d.[Department]
      ,[Salary]
      ,[Location]
      ,[Rating]
,[Good] as [Bonus Rate]
FROM [EDNA_challlenge].[dbo].['emp-data$'] d join[EDNA_challlenge].[dbo].['Bonus Rules$'] b
  on d.Department = b.Department
  Where d.Department is not NULL
  And Salary is not NULL
  and Rating = 'Good'
  union
  SELECT  Name
,Case when [Gender] = 'Male' then 'Male'
			when [Gender] = 'Female' then 'Female'
			when [Gender] is NULL then 'PNS' end as [Gender]
      ,d.[Department]
      ,[Salary]
      ,[Location]
      ,[Rating]
,[Very Good] as [Bonus Rate]
FROM [EDNA_challlenge].[dbo].['emp-data$'] d join[EDNA_challlenge].[dbo].['Bonus Rules$'] b
  on d.Department = b.Department
  Where d.Department is not NULL
  And Salary is not NULL
  and Rating = 'Very Good') a
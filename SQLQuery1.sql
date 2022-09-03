/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [id]
      ,[name]
      ,[county]
      ,[state_code]
      ,[state]
      ,[type]
      ,[latitude]
      ,[longitude]
      ,[area_code]
      ,[population]
      ,[households]
      ,[median_income]
      --,[land_area]
      --,[water_area]
      --,[time_zone]
	  ,CASE when [median_income] BETWEEN 0 and 36000 then 'Low income' 	
			when [median_income] BETWEEN 70001 and 200000 then 'Rich Folks'
			Else 'Middle Class'
		END Salary_Range
  FROM [EDNA_challlenge].[dbo].['Store Locations$']
  
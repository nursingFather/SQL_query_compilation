/****** Script for SelectTopNRows command from SSMS  ******/

SELECT  
	 [InvoiceNo]
      ,[StockCode]
      ,[Description]
      ,[Quantity]
      ,[InvoiceDate]
	  --,[InvoiceDate]
	  ,[Time Ordered]
      ,[UnitPrice]
      ,[CustomerID]
      ,[Country]
      ,[Total Sales]
      ,[Status]
      ,[Sales Status]
	,case when [Time Ordered] between cast('6:00' as time) and cast('14:00' as time) then 'Early Shift'
		  when [Time Ordered] between cast('14:01' as time) and cast('22:00' as time) then 'Late Shift'
	 end as [Work Shift]
  FROM (SELECT [InvoiceNo]
      ,[StockCode]
      ,[Description]
      ,[Quantity]
      ,left([InvoiceDate], 11) as [InvoiceDate]
	  --,[InvoiceDate]
	  ,left(CAST([InvoiceDate] as time), 5) [Time Ordered]
      ,[UnitPrice]
      ,[CustomerID]
      ,[Country]
      ,[Total Sales]
      ,[Status]
      ,[Sales Status]
  FROM [Clean_play].[dbo].[OnlineRetail$]) a
  
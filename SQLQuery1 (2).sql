
SELECT distinct([country])
		,[AHT_per_country]
FROM

(SELECT  --a.[ticket_id]
      --,[handling_time_in_sec]
	  --,[handling_time_min] /*Converting sec to min in 2decimal places*/
	  (Round((AVG([handling_time_min]) OVER(PARTITION BY [country])), 3)) as [AHT_per_country] 
      ,([country])
      --,[level]
      --,[ticket_type]

FROM(SELECT  a.[ticket_id]
      ,round([handling_time_in_sec], 2) as [handling_time_in_sec]
	  ,round(([handling_time_in_sec]/60), 2) as [handling_time_min] /*Converting sec to min in 2decimal places*/
	  ,[created_date]
      ,[country_name] as country
      ,[level]
      ,[ticket_type]
  FROM [Trade Republic].[dbo].['2022-03-11_Junior-Data-Analyst_$'] a /*Joining both tables*/
	inner join  [Quantum_int].[dbo].['2022-03-11_Junior-Data-Analyst_$'] b
	ON a.ticket_id = b.ticket_id
	WHERE [handling_time_in_sec] is not NULL)a)z

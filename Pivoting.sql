

 SELECT [Player]
      ,[Nationality]
      ,[Appearances]
      ,[Assists]
	  ,[Big Chances Missed]
	  ,[Clearances]
	  ,[Clearances Off Line]
	  ,[Dispossessed]
	  ,[Fouls]
	  ,[Goals]
	  ,[High Claim]
	  ,[Hit Woodwork]
	  ,[Minutes Played]
	  ,[Offsides]
	  ,[Passes]
	  ,[Punches]
	  ,[Red Cards]
	  ,[Saves]
	  ,[Shots], [Tackles], [Touches], [Yellow Cards]
  FROM
		( 
		SELECT Player, Nationality, Metric, Stat
			FROM [Clean_play].[dbo].['Arsenal Player Stats 2018-19$']
			 ) AS Source_Table
 PIVOT
 (  SUM(Stat)
	FOR Metric
	IN ([Appearances],[Assists], [Big Chances Missed], [Clearances], [Clearances Off Line], [Dispossessed], [Fouls], [Goals], [High Claim], 
	[Hit Woodwork], [Minutes Played], [Offsides], [Passes], [Punches], [Red Cards], [Saves], [Shots], [Tackles], [Touches], [Yellow Cards])
)
AS Pivot_Table
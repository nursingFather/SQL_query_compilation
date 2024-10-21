with possible_route as (
	select 
		t.city_to,
		CAST(t.city_from + ' --> ' + t.city_to AS NVARCHAR(MAX)) AS routee,
		t.distance

	from [dbo].[travel_distances] t
	where t.city_from = 'Groningen'

	union all
	
	select 
		t.city_to,
		CAST(pr.routee + ' --> ' + t.city_to AS NVARCHAR(MAX)) AS routee,
		cast(t.distance + pr.distance as  float) as distance
	
	from possible_route pr
	inner join [dbo].[travel_distances] t
	on t.city_from = pr.city_to
)

select * from possible_route pr
where pr.city_to = 'Haarlem'
order by pr.distance
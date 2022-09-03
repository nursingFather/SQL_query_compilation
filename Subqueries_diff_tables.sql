/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [student_no]
      ,[student_name]
      ,[age]
  FROM [master].[dbo].[students]

  SELECT *
  FROM [master].[dbo].[student_enrollment]

  SELECT *
  FROM [master].[dbo].[teach]

   SELECT *
  FROM [master].[dbo].[courses]



  SELECT
      [student_name]
     -- ,[age]
  FROM [master].[dbo].[students]
  where student_no in (select student_no
							
					  from [master].[dbo].[student_enrollment]
					  where course_no in (select course_no 
										from [master].[dbo].[courses]
                                         where course_title = 'physics' or course_title = 'US History')	
		             )
  SELECT
      [student_name]
     -- ,[age]
  FROM [master].[dbo].[students]
  where student_no in (
					SELECT top 2
						student_no
						--,count(course_no) as [# of courses]
					FROM [master].[dbo].[student_enrollment]
					group by student_no
					order by count(course_no) desc
					)
  SELECT
	  [student_no]
      ,[student_name]
      ,[age]
  FROM [master].[dbo].[students]
  where age = (select max(age) 
				from [master].[dbo].[students]
				)
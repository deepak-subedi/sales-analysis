/****** Cleaning Calendar table  ******/
SELECT 
	[DateKey] AS DateKey
      ,[FullDateAlternateKey] AS Date
      ,[EnglishDayNameOfWeek] AS Day
      ,[WeekNumberOfYear] AS WeekNo
      ,[EnglishMonthName] AS Month,
	  LEFT([EnglishMonthName], 3) AS MonthShort
      ,[MonthNumberOfYear] AS MonthNo
      ,[CalendarQuarter] AS Quarter
      ,[CalendarYear] AS Year
FROM 
	dbo.DimDate
WHERE
	CalendarYear >= 2019
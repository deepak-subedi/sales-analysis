/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	c.CustomerKey AS CustomerKey,
	c.FirstName AS FirstName,
	c.LastName AS LastName,
	c.FirstName + ' ' + c.LastName AS FullName,
	CASE c.gender
		WHEN 'M' then 'Male'
		WHEN 'F' then 'Female'
	END AS Gender,
	c.DateFirstPurchase as DateFirstPurchase,
	g.City as  CustomerCity
FROM 
	dbo.DimCustomer AS c
LEFT JOIN 
	dbo.DimGeography As g
ON c.GeographyKey = g.GeographyKey
ORDER BY
	c.CustomerKey ASC
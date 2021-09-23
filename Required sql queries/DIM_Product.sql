/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	p.[ProductKey],
	p.[ProductAlternateKey] AS ProductItemCode,
	p.[EnglishProductName] AS [ProductName],
	ps.[EnglishProductSubcategoryName] AS ProductSubCategory,
	pc.[EnglishProductCategoryName] AS ProductCategory,
	p.[Color] AS ProductColor,
	p.[Size] AS ProductSize,
	p.[ProductLine] AS ProductLine,
	p.[ModelName] AS ProductModelName,
	p.[EnglishDescription] AS ProductDescription,
	ISNULL (p.[Status], 'Outdated') AS ProductStatus
FROM dbo.DimProduct AS p
LEFT JOIN dbo.DimProductSubcategory AS ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
ORDER BY
	p.ProductKey ASC
	
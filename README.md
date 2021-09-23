# Data Analyst Portfolio Project – Sales Analysis

## Business Request & User Stories

The business request for this data analyst project was an executive sales report for sales managers. Based on the request that was made from the business we following user stories were defined to fulfill delivery and ensure that acceptance criteria’s were maintained throughout the project.

|#|As a (role)|I want (request / demand)|So that I (user value)|Acceptance Criteria|
|---|---|---|---|---|
|1|Sales Manager|To get a dashboard overview of internet sales|Can follow better which customers and products sells the best|A Power BI dashboard which updates data once a day.|
|2|Sales Representative|A detailed overview of Internet Sales per Customers|Can follow up my customers that buys the most and who we can sell more to|A Power BI dashboard which allows me to filter data for each customer.|
|3|Sales Representative|A detailed overview of Internet Sales per Products|Can follow up my Products that sells the most|A Power BI dashboard which allows me to filter data for each product.|
|4|Sales Manager|To get a dashboard overview of internet sales|Follow sales over time against budget|A Power Bi dashboard with graphs and KPIs comparing against budget.|

## Data Cleansing & Transformation (SQL)
To create the necessary data model for doing analysis and fulfilling the business needs defined in the user stories the following tables were extracted using SQL.

One data source (sales budgets) were provided in Excel format and were connected in the data model in a later step of the process.

Below are the SQL statements for cleansing and transforming necessary data.

### DIM_Calendar

SELECT <br />
	[DateKey] AS DateKey <br />
      ,[FullDateAlternateKey] AS Date <br />
      ,[EnglishDayNameOfWeek] AS Day <br />
      ,[WeekNumberOfYear] AS WeekNo <br />
      ,[EnglishMonthName] AS Month, <br />
	  LEFT([EnglishMonthName], 3) AS MonthShort <br />
      ,[MonthNumberOfYear] AS MonthNo <br />
      ,[CalendarQuarter] AS Quarter <br />
      ,[CalendarYear] AS Year <br />
FROM <br />
	dbo.DimDate <br />
WHERE <br />
	CalendarYear >= 2019 <br />

### DIM_Customer

SELECT <br />
	c.CustomerKey AS CustomerKey, <br />
	c.FirstName AS FirstName, <br />
	c.LastName AS LastName, <br />
	c.FirstName + ' ' + c.LastName AS FullName, <br />
	CASE c.gender <br />
		WHEN 'M' then 'Male' <br />
		WHEN 'F' then 'Female' <br />
	END AS Gender, <br />
	c.DateFirstPurchase as DateFirstPurchase, <br />
	g.City as  CustomerCity <br />
FROM <br />
	dbo.DimCustomer AS c <br />
LEFT JOIN <br />
	dbo.DimGeography As g <br />
ON c.GeographyKey = g.GeographyKey <br />
ORDER BY <br />
	c.CustomerKey ASC <br />
    
### DIM_Activity

SELECT <br />
	p.[ProductKey], <br />
	p.[ProductAlternateKey] AS ProductItemCode, <br />
	p.[EnglishProductName] AS [ProductName], <br />
	ps.[EnglishProductSubcategoryName] AS ProductSubCategory, <br />
	pc.[EnglishProductCategoryName] AS ProductCategory, <br />
	p.[Color] AS ProductColor, <br />
	p.[Size] AS ProductSize, <br />
	p.[ProductLine] AS ProductLine, <br />
	p.[ModelName] AS ProductModelName, <br />
	p.[EnglishDescription] AS ProductDescription, <br />
	ISNULL (p.[Status], 'Outdated') AS ProductStatus <br />
FROM dbo.DimProduct AS p <br />
LEFT JOIN dbo.DimProductSubcategory AS ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey <br />
LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey <br />
ORDER BY <br />
	p.ProductKey ASC <br />
	

### FACT_InternetSales 

SELECT <br />
  [ProductKey], <br />
  [OrderDateKey], <br />
  [DueDateKey], <br />
  [ShipDateKey], <br />
  [CustomerKey], <br />
  [SalesOrderNumber], <br />
  [SalesAmount] <br />
FROM <br />
  dbo.FactInternetSales <br />
WHERE <br />
  LEFT (OrderDateKey, 4) >= YEAR(GETDATE()) - 2 -- Ensures we always only bring two years of date from extraction. <br />
ORDER BY <br />
  OrderDateKey ASC <br />
  
    
## Data Model

Below is a screenshot of the data model after cleansed and prepared tables were read into Power BI.

This data model shows how Fact tables **FACT_Budget** and **FACT_InternetSales** are connected to other necessary DIM tables.

![GitHub Sales_Data_Model](/images/Data_Model.PNG)

## Calculations

The following calculations were created in the Power BI reports using DAX (Data Analysis Expressions). To lessen the extent of coding, the re-use of measures (measure branching) was emphasized:

**Budget Amount** = SUM(FACT_Budgets[Budget])

**Total Sales** = SUM(FACT_InternetSales[SalesAmount])

**Sales - Budgets** = [Total Sales] - [Budget Amount]

**Sales per Budget** = DIVIDE([Sales], [Budget Amount])


## Exercise Analysis Dashboard

The finished sales analysis dashboard with one page which works as a dashboard and overview, with other page focused on combining tables for necessary details and visualizations to show sales over time, per customers and per products. 

### Sales Overview Analysis

![GitHub Sales_overview](/images/Sales_Overview.PNG)

### Customer Detail Analysis

![GitHub Customer_overview](/images/Customer_Details.PNG)

USE [del]
GO
Drop view v_Bill_Print
go
Drop view v_Not_Paid_Property
go
Drop view v_Paid_Property
go
DROP view v_Request_Paid_Properties
GO
Drop view v_Boundary
go
Drop view v_Sum_Divisions
go
Drop view v_Served_Properties
go
Drop view v_Bill_Roll
go
Drop view v_To_Be_Served_Waninge_Notice
go
Drop view v_To_Be_Served_Final_Warning_Notice
go
Drop view v_To_Be_Served_Court_Summon
go
Drop view v_Bill_Print_Email_List
go

CREATE VIEW v_Bill_Print AS 
SELECT top 9999999999999999 [dbo].[BILLINGROLL].[Account]
      ,[Address]
      ,[OwnerName]
      ,[Suburb]
      ,FORMAT([RateableV], 'N', 'en-us') AS RateableV
      ,[Zone]
      ,[Use_]
      ,FORMAT([Rate], '0.######', 'en-us') as [Rate]
      ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)) AS CurrentTax
      ,COALESCE([Arrears],0) AS [Arrears]
	    ,COALESCE([del].[dbo].[v_Payment].[Payments],0) AS [Payment]
   	  ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100))+COALESCE([Arrears],0)-(COALESCE([del].[dbo].[v_Payment].[Payments],0)) AS Balance
      ,FORMAT([Telephone], '0##-###-####') as [Telephone]
      ,[Email]
      ,DATEPART(year,GETDATE()) AS [BillingDate]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],9) AS [BLOCKIMAGES]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],4) AS [COMM]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],5,2) AS [DIV]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],7,3) [BLOCK]
      ,RIGHT([del].[dbo].[BILLINGROLL].[Account],3) AS [PARCEL]
      ,FORMAT((COALESCE([dbo].[DISCOUNT].[Discount],0)/100), '##.######## %', 'en-us') as [Discount]
	    ,[Served]
	    ,[Date_Served]
	    ,[Warning_Notice]
  	  ,[Final_Warning_Notice]
	    ,[Court_Summon]
      ,[PictureID]
      ,[PictureURL]
      ,[SumBuiding]
      ,[SHAPE]
  FROM [del].[dbo].[BILLINGROLL]
     LEFT OUTER JOIN [del].[dbo].[DISCOUNT] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[DISCOUNT].[Account]
     LEFT OUTER JOIN [del].[dbo].[v_Payment] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[v_Payment].[Account]
     LEFT OUTER JOIN [del].[dbo].[Served] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Served].[Account]
     LEFT OUTER JOIN [del].[dbo].[Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Final_Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Final_Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Court_Summon] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Court_Summon].[Account]
	where [Use_] != 'VACANT OR UNCOMPLETED PROPERTY' AND [Use_] != 'DILAPIDATED' AND [Use_] != 'DIPLOMATIC MISSION (MISSION OWNED)' AND [Use_] != 'DIPLOMATIC MISSION (GOVT OWNED)' AND [Use_] != 'DIPLOMATIC MISSION (PRIVATE OWN)' AND [Use_] != 'NOT ASSES' AND [Use_] != 'MILITARY INSTALLATIONS' AND [Use_] != 'DERELICT' AND [Use_] != 'CEMETERY'
  order by [dbo].[BILLINGROLL].[Account]
GO
CREATE VIEW v_Not_Paid_Property AS 
SELECT top 9999999999999999 [dbo].[BILLINGROLL].[Account]
      ,[Address]
      ,[OwnerName]
      ,[Suburb]
      ,FORMAT([RateableV], 'N', 'en-us') AS RateableV
      ,[Zone]
      ,[Use_]
      ,FORMAT([Rate], '0.######', 'en-us') as [Rate]
      ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)) AS CurrentTax
      ,COALESCE([Arrears],0) AS [Arrears]
	    ,COALESCE([del].[dbo].[v_Payment].[Payments],0) AS [Payment]
	    ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100))+COALESCE([Arrears],0)-(COALESCE([del].[dbo].[v_Payment].[Payments],0)) AS Balance
      ,FORMAT([Telephone], '0##-###-####') as [Telephone]
      ,[Email]
      ,DATEPART(year,GETDATE()) AS [BillingDate]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],9) AS [BLOCKIMAGES]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],4) AS [COMM]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],5,2) AS [DIV]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],7,3) [BLOCK]
      ,RIGHT([del].[dbo].[BILLINGROLL].[Account],3) AS [PARCEL]
      ,FORMAT((COALESCE([dbo].[DISCOUNT].[Discount],0)/100), '##.######## %', 'en-us') as [Discount]
	    ,[Served]
	    ,[Date_Served]
	    ,[Warning_Notice]
	    ,[Final_Warning_Notice]
	    ,[Court_Summon]
      ,[PictureID]
      ,[PictureURL]
      ,[SumBuiding]
      ,[SHAPE]
  FROM [del].[dbo].[BILLINGROLL]
     LEFT OUTER JOIN [del].[dbo].[DISCOUNT] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[DISCOUNT].[Account]
     LEFT OUTER JOIN [del].[dbo].[v_Payment] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[v_Payment].[Account]
     LEFT OUTER JOIN [del].[dbo].[Served] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Served].[Account]
     LEFT OUTER JOIN [del].[dbo].[Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Final_Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Final_Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Court_Summon] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Court_Summon].[Account]
  Where [Served] = 'Yes' and COALESCE([del].[dbo].[v_Payment].[Payments],0) < 5 
 order by [Account]
GO
CREATE VIEW v_Paid_Property AS 
SELECT top 9999999999999999 [GCR_No] AS GCR_No
      ,[dbo].[BILLINGROLL].[Account]
      ,[Address]
      ,[OwnerName]
      ,[Suburb]
      ,FORMAT([RateableV], 'N', 'en-us') AS RateableV
      ,[Zone]
      ,[Use_]
      ,FORMAT([Rate], '0.######', 'en-us') as [Rate]
      ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)) AS CurrentTax
      ,COALESCE([Arrears],0) AS [Arrears]
	    ,COALESCE([del].[dbo].[v_Payment].[Payments],0) AS [Payment]
	    ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100))+COALESCE([Arrears],0)-(COALESCE([del].[dbo].[v_Payment].[Payments],0)) AS Balance
      ,(COALESCE([del].[dbo].[v_Payment].[Payments],0)/(([CurrentTax]+[Arrears])-(([CurrentTax]+[Arrears])*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)))*100) AS Percent_Paid
      ,FORMAT([Telephone], '0##-###-####') as [Telephone]
      ,[Email]
      ,DATEPART(year,GETDATE()) AS [BillingDate]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],9) AS [BLOCKIMAGES]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],4) AS [COMM]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],5,2) AS [DIV]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],7,3) [BLOCK]
      ,RIGHT([del].[dbo].[BILLINGROLL].[Account],3) AS [PARCEL]
      ,FORMAT((COALESCE([dbo].[DISCOUNT].[Discount],0)/100), '##.######## %', 'en-us') as [Discount]
	    ,[Served]
	    ,[Date_Served]
	    ,[Warning_Notice]
	    ,[Final_Warning_Notice]
	    ,[Court_Summon]
      ,[PictureID]
      ,[PictureURL]
      ,[SumBuiding]
      ,[SHAPE]
  FROM [del].[dbo].[BILLINGROLL]
     LEFT OUTER JOIN [del].[dbo].[DISCOUNT] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[DISCOUNT].[Account]
     LEFT OUTER JOIN [del].[dbo].[v_Payment] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[v_Payment].[Account]
     LEFT OUTER JOIN [del].[dbo].[Served] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Served].[Account]
     LEFT OUTER JOIN [del].[dbo].[Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Final_Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Final_Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Court_Summon] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Court_Summon].[Account]
  Where COALESCE([del].[dbo].[v_Payment].[Payments],0) > 0.001
order by [GCR_No]
GO
CREATE VIEW  v_Request_Paid_Properties AS 
SELECT top 999999999999 [GCR_No] AS GCR_Number
      ,[dbo].[BILLINGROLL].[Account]
      ,[OwnerName]
      ,[Suburb]
      ,[RateableV] AS Rateable_Value
      ,[CurrentTax]-(([CurrentTax]+[Arrears])*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)) AS CurrentTax
	    ,[Arrears]
      ,([Payments]) AS Payments
      ,(([CurrentTax]-(([CurrentTax]+[Arrears])*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100))+[Arrears])-([Payments])) AS Balance
      ,FORMAT([Telephone], '0##-###-####') as [Telephone]
      ,FORMAT([DatePaid], 'dd-MM-yyyy', 'en-us') as [DatePaid]
      ,FORMAT((COALESCE([dbo].[DISCOUNT].[Discount],0)/100), '##.######## %', 'en-us') as [Discount]
	    ,[SHAPE]
  FROM [del].[dbo].[BILLINGROLL]
     LEFT OUTER JOIN [del].[dbo].[DISCOUNT] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[DISCOUNT].[Account]
     LEFT OUTER JOIN [del].[dbo].[Payment] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Payment].[Account]
     LEFT OUTER JOIN [del].[dbo].[Served] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Served].[Account]
     LEFT OUTER JOIN [del].[dbo].[Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Final_Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Final_Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Court_Summon] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Court_Summon].[Account]
  Where [Payments] > 0.001 and [Date_request] is NULL
  order by [GCR_No]
GO
CREATE VIEW v_Boundary AS 
SELECT top 999999999999 LEFT([dbo].[BILLINGROLL].[Account],4) as Municipality
	    ,Sum(COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100))) AS CurrentTax
      ,Sum([Arrears]) AS Arrears
      ,Sum([Payments]) AS Payments
      ,Sum((([CurrentTax]-(([CurrentTax]+[Arrears])*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)))+[Arrears])-([Payments])) AS Balance
  FROM [del].[dbo].[BILLINGROLL]
     LEFT OUTER JOIN [del].[dbo].[DISCOUNT] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[DISCOUNT].[Account]
     LEFT OUTER JOIN [del].[dbo].[v_Payment] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[v_Payment].[Account]
     LEFT OUTER JOIN [del].[dbo].[Served] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Served].[Account]
     LEFT OUTER JOIN [del].[dbo].[Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Final_Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Final_Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Court_Summon] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Court_Summon].[Account]
	where [Use_] != 'VACANT OR UNCOMPLETED PROPERTY' AND [Use_] != 'DILAPIDATED' AND [Use_] != 'DIPLOMATIC MISSION (MISSION OWNED)' AND [Use_] != 'DIPLOMATIC MISSION (GOVT OWNED)' AND [Use_] != 'DIPLOMATIC MISSION (PRIVATE OWN)' AND [Use_] != 'NOT ASSES' AND [Use_] != 'MILITARY INSTALLATIONS' AND [Use_] != 'DERELICT' AND [Use_] != 'CEMETERY'
	Group By LEFT([dbo].[BILLINGROLL].[Account],4)
GO
CREATE VIEW v_Sum_Divisions AS 
SELECT top 999999999999 Sum([CurrentTax]-(([CurrentTax]+[Arrears])*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100))) AS CurrentTax
      ,Sum([Arrears]) AS Arrears
      ,Sum([Payments]) AS Payments
      ,Sum((([CurrentTax]-(([CurrentTax]+[Arrears])*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)))+[Arrears])-([Payments])) AS Balance
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],5,2) AS [Division]
      ,count([Served]) AS Properties_served
      ,COUNT('Yes') AS Properties_to_be_served
  FROM [del].[dbo].[BILLINGROLL]
     LEFT OUTER JOIN [del].[dbo].[DISCOUNT] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[DISCOUNT].[Account]
     LEFT OUTER JOIN [del].[dbo].[v_Payment] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[v_Payment].[Account]
     LEFT OUTER JOIN [del].[dbo].[Served] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Served].[Account]
     LEFT OUTER JOIN [del].[dbo].[Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Final_Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Final_Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Court_Summon] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Court_Summon].[Account]
  where [Use_] != 'VACANT OR UNCOMPLETED PROPERTY' AND [Use_] != 'DILAPIDATED' AND [Use_] != 'DIPLOMATIC MISSION (MISSION OWNED)' AND [Use_] != 'DIPLOMATIC MISSION (GOVT OWNED)' AND [Use_] != 'DIPLOMATIC MISSION (PRIVATE OWN)' AND [Use_] != 'NOT ASSES' AND [Use_] != 'MILITARY INSTALLATIONS' AND [Use_] != 'DERELICT' AND [Use_] != 'CEMETERY'
  Group By SUBSTRING([dbo].[BILLINGROLL].[Account],5,2)
  ORDER BY SUBSTRING([dbo].[BILLINGROLL].[Account],5,2)
GO
CREATE VIEW  v_Served_Properties AS 
SELECT top 999999999999 [GCR_No] AS GCR_No1
      ,[dbo].[BILLINGROLL].[Account]
      ,[OwnerName]
      ,[Suburb]
	    ,[RateableV]
      ,[CurrentTax]-(([CurrentTax]+[Arrears])*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)) AS CurrentTax
      ,([Payments]) AS Payments
      ,(([CurrentTax]-(([CurrentTax]+[Arrears])*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100))+[Arrears])-([Payments])) AS Balance
      ,FORMAT([Telephone], '0##-###-####') as [Telephone]
	    ,[Served]
      ,FORMAT([Date_Served], 'dd-MM-yyyy', 'en-us') as [Date_Served]
      ,FORMAT((COALESCE([dbo].[DISCOUNT].[Discount],0)/100), '##.######## %', 'en-us') as [Discount]
      ,[SHAPE]
  FROM [del].[dbo].[BILLINGROLL]
     LEFT OUTER JOIN [del].[dbo].[DISCOUNT] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[DISCOUNT].[Account]
     LEFT OUTER JOIN [del].[dbo].[v_Payment] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[v_Payment].[Account]
     LEFT OUTER JOIN [del].[dbo].[Served] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Served].[Account]
     LEFT OUTER JOIN [del].[dbo].[Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Final_Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Final_Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Court_Summon] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Court_Summon].[Account]
  Where [Served] = 'Yes' AND [Use_] != 'VACANT OR UNCOMPLETED PROPERTY' AND [Use_] != 'DILAPIDATED' AND [Use_] != 'DIPLOMATIC MISSION (MISSION OWNED)' AND [Use_] != 'DIPLOMATIC MISSION (GOVT OWNED)' AND [Use_] != 'DIPLOMATIC MISSION (PRIVATE OWN)' AND [Use_] != 'NOT ASSES' AND [Use_] != 'MILITARY INSTALLATIONS' AND [Use_] != 'DERELICT' AND [Use_] != 'CEMETERY' 
  order by [Account]
GO
CREATE VIEW v_Bill_Roll AS 
SELECT top 9999999999999999 [dbo].[BILLINGROLL].[Account]
      ,[Address]
      ,[OwnerName]
      ,[Suburb]
      ,[RateableV] AS RateableV
      ,[Zone]
      ,[Use_]
      ,FORMAT([Rate], '0.######', 'en-us') as [Rate]
      ,[CurrentTax]-(([CurrentTax]+[Arrears])*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)) AS CurrentTax
      ,[Arrears] AS Arrears
      ,([Payments]) AS Payments
      ,(([CurrentTax]-(([CurrentTax]+[Arrears])*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100))+[Arrears])-([Payments])) AS Balance
      ,FORMAT([Telephone], '0##-###-####') as [Telephone]
      ,[Email]
      ,DATEPART(year,GETDATE()) AS [BillingDate]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],9) AS [BLOCKIMAGES]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],4) AS [COMM]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],5,2) AS [DIV]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],7,3) [BLOCK]
      ,RIGHT([del].[dbo].[BILLINGROLL].[Account],3) AS [PARCEL]
      ,FORMAT((COALESCE([dbo].[DISCOUNT].[Discount],0)/100), '##.######## %', 'en-us') as [Discount]
	    ,[PictureURL]
      ,[dbo].[BILLINGROLL].[Shape]
  FROM [del].[dbo].[BILLINGROLL]
     LEFT OUTER JOIN [del].[dbo].[DISCOUNT] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[DISCOUNT].[Account]
     LEFT OUTER JOIN [del].[dbo].[v_Payment] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[v_Payment].[Account]
     LEFT OUTER JOIN [del].[dbo].[Served] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Served].[Account]
     LEFT OUTER JOIN [del].[dbo].[Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Final_Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Final_Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Court_Summon] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Court_Summon].[Account]
    order by [dbo].[BILLINGROLL].[Account]
GO
CREATE VIEW v_To_Be_Served_Waninge_Notice AS 
SELECT top 9999999999999999 [dbo].[BILLINGROLL].[Account]
      ,[Address]
      ,[OwnerName]
      ,[Suburb]
      ,FORMAT([RateableV], 'N', 'en-us') AS RateableV
      ,[Zone]
      ,[Use_]
      ,FORMAT([Rate], '0.######', 'en-us') as [Rate]
      ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)) AS CurrentTax
      ,COALESCE([Arrears],0) AS [Arrears]
	    ,COALESCE([del].[dbo].[v_Payment].[Payments],0) AS [Payment]
	    ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100))+COALESCE([Arrears],0)-(COALESCE([del].[dbo].[v_Payment].[Payments],0)) AS Balance
      ,FORMAT([Telephone], '0##-###-####') as [Telephone]
      ,[Email]
      ,DATEPART(year,GETDATE()) AS [BillingDate]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],9) AS [BLOCKIMAGES]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],4) AS [COMM]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],5,2) AS [DIV]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],7,3) [BLOCK]
      ,RIGHT([del].[dbo].[BILLINGROLL].[Account],3) AS [PARCEL]
      ,FORMAT((COALESCE([dbo].[DISCOUNT].[Discount],0)/100), '##.######## %', 'en-us') as [Discount]
      ,[Served]
	    ,[Date_Served]
	    ,[Warning_Notice]
	    ,[Final_Warning_Notice]
      ,[Court_Summon]
      ,[PictureID]
      ,[PictureURL]
      ,[SumBuiding]
      ,[SHAPE]
  FROM [del].[dbo].[BILLINGROLL]
     LEFT OUTER JOIN [del].[dbo].[DISCOUNT] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[DISCOUNT].[Account]
     LEFT OUTER JOIN [del].[dbo].[v_Payment] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[v_Payment].[Account]
     LEFT OUTER JOIN [del].[dbo].[Served] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Served].[Account]
     LEFT OUTER JOIN [del].[dbo].[Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Final_Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Final_Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Court_Summon] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Court_Summon].[Account]
  where [Date_Served] < DATEADD(month, -1, GETDATE()) and 
  [Payments] < 1 and 
  [Served]='Yes' and 
  [Use_] != 'VACANT OR UNCOMPLETED PROPERTY' AND 
  [Use_] != 'DILAPIDATED' AND 
  [Use_] != 'DIPLOMATIC MISSION (MISSION OWNED)' AND 
  [Use_] != 'DIPLOMATIC MISSION (GOVT OWNED)' AND 
  [Use_] != 'DIPLOMATIC MISSION (PRIVATE OWN)' AND 
  [Use_] != 'NOT ASSES' AND 
  [Use_] != 'MILITARY INSTALLATIONS' AND 
  [Use_] != 'DERELICT' AND 
  [Use_] != 'CEMETERY'
  order by [dbo].[BILLINGROLL].[Account]
GO
CREATE VIEW v_To_Be_Served_Final_Warning_Notice AS 
SELECT top 9999999999999999 [dbo].[BILLINGROLL].[Account]
      ,[Address]
      ,[OwnerName]
      ,[Suburb]
      ,FORMAT([RateableV], 'N', 'en-us') AS RateableV
      ,[Zone]
      ,[Use_]
      ,FORMAT([Rate], '0.######', 'en-us') as [Rate]
      ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)) AS CurrentTax
      ,COALESCE([Arrears],0) AS [Arrears]
	    ,COALESCE([del].[dbo].[v_Payment].[Payments],0) AS [Payment]
  	  ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100))+COALESCE([Arrears],0)-(COALESCE([del].[dbo].[v_Payment].[Payments],0)) AS Balance
      ,FORMAT([Telephone], '0##-###-####') as [Telephone]
      ,[Email]
      ,DATEPART(year,GETDATE()) AS [BillingDate]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],9) AS [BLOCKIMAGES]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],4) AS [COMM]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],5,2) AS [DIV]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],7,3) [BLOCK]
      ,RIGHT([del].[dbo].[BILLINGROLL].[Account],3) AS [PARCEL]
      ,FORMAT((COALESCE([dbo].[DISCOUNT].[Discount],0)/100), '##.######## %', 'en-us') as [Discount]
	    ,[Served]
	    ,[Date_Served]
	    ,[Warning_Notice]
	    ,[Final_Warning_Notice]
	    ,[Court_Summon]
      ,[PictureID]
      ,[PictureURL]
      ,[SumBuiding]
      ,[SHAPE]
  FROM [del].[dbo].[BILLINGROLL]
     LEFT OUTER JOIN [del].[dbo].[DISCOUNT] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[DISCOUNT].[Account]
     LEFT OUTER JOIN [del].[dbo].[v_Payment] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[v_Payment].[Account]
     LEFT OUTER JOIN [del].[dbo].[Served] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Served].[Account]
     LEFT OUTER JOIN [del].[dbo].[Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Final_Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Final_Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Court_Summon] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Court_Summon].[Account]
  where [Date_Warning_Notice] < DATEADD(month, -0.4, GETDATE()) and 
  [Payments] < 1 and 
  [Served]='Yes' and 
  [Use_] != 'VACANT OR UNCOMPLETED PROPERTY' AND 
  [Use_] != 'DILAPIDATED' AND 
  [Use_] != 'DIPLOMATIC MISSION (MISSION OWNED)' AND 
  [Use_] != 'DIPLOMATIC MISSION (GOVT OWNED)' AND 
  [Use_] != 'DIPLOMATIC MISSION (PRIVATE OWN)' AND 
  [Use_] != 'NOT ASSES' AND 
  [Use_] != 'MILITARY INSTALLATIONS' AND 
  [Use_] != 'DERELICT' AND 
  [Use_] != 'CEMETERY'
  order by [dbo].[BILLINGROLL].[Account]
GO
CREATE VIEW v_To_Be_Served_Court_Summon AS 
SELECT top 9999999999999999 [dbo].[BILLINGROLL].[Account]
      ,[Address]
      ,[OwnerName]
      ,[Suburb]
      ,FORMAT([RateableV], 'N', 'en-us') AS RateableV
      ,[Zone]
      ,[Use_]
      ,FORMAT([Rate], '0.######', 'en-us') as [Rate]
      ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)) AS CurrentTax
      ,COALESCE([Arrears],0) AS [Arrears]
	    ,COALESCE([del].[dbo].[v_Payment].[Payments],0) AS [Payment]
	    ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100))+COALESCE([Arrears],0)-(COALESCE([del].[dbo].[v_Payment].[Payments],0)) AS Balance
      ,FORMAT([Telephone], '0##-###-####') as [Telephone]
      ,[Email]
      ,DATEPART(year,GETDATE()) AS [BillingDate]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],9) AS [BLOCKIMAGES]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],4) AS [COMM]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],5,2) AS [DIV]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],7,3) [BLOCK]
      ,RIGHT([del].[dbo].[BILLINGROLL].[Account],3) AS [PARCEL]
      ,FORMAT((COALESCE([dbo].[DISCOUNT].[Discount],0)/100), '##.######## %', 'en-us') as [Discount]
	    ,[Served]
	    ,[Date_Served]
	    ,[Warning_Notice]
	    ,[Final_Warning_Notice]
	    ,[Court_Summon]
      ,[PictureID]
      ,[PictureURL]
      ,[SumBuiding]
      ,[SHAPE]
  FROM [del].[dbo].[BILLINGROLL]
     LEFT OUTER JOIN [del].[dbo].[DISCOUNT] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[DISCOUNT].[Account]
     LEFT OUTER JOIN [del].[dbo].[v_Payment] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[v_Payment].[Account]
     LEFT OUTER JOIN [del].[dbo].[Served] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Served].[Account]
     LEFT OUTER JOIN [del].[dbo].[Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Final_Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Final_Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Court_Summon] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Court_Summon].[Account]
  where [Date_Final_Warning_Notice] < DATEADD(month, -0.4, GETDATE()) and 
  [Payments] < 1 and 
  [Served]='Yes' and 
  [Use_] != 'VACANT OR UNCOMPLETED PROPERTY' AND 
  [Use_] != 'DILAPIDATED' AND 
  [Use_] != 'DIPLOMATIC MISSION (MISSION OWNED)' AND 
  [Use_] != 'DIPLOMATIC MISSION (GOVT OWNED)' AND 
  [Use_] != 'DIPLOMATIC MISSION (PRIVATE OWN)' AND 
  [Use_] != 'NOT ASSES' AND 
  [Use_] != 'MILITARY INSTALLATIONS' AND 
  [Use_] != 'DERELICT' AND 
  [Use_] != 'CEMETERY'
  order by [dbo].[BILLINGROLL].[Account]
GO
CREATE VIEW v_Bill_Print_Email_List AS 
SELECT top 9999999999999999 [dbo].[BILLINGROLL].[Account]
      ,[Address]
      ,[OwnerName]
      ,[Suburb]
      ,FORMAT([RateableV], 'N', 'en-us') AS RateableV
      ,[Zone]
      ,[Use_]
      ,FORMAT([Rate], '0.######', 'en-us') as [Rate]
      ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100)) AS CurrentTax
      ,COALESCE([Arrears],0) AS [Arrears]
	    ,COALESCE([del].[dbo].[v_Payment].[Payments],0) AS [Payment]
	    ,COALESCE([CurrentTax],0)-((COALESCE([CurrentTax],0)+COALESCE([Arrears],0))*(COALESCE([dbo].[DISCOUNT].[Discount],0)/100))+COALESCE([Arrears],0)-(COALESCE([del].[dbo].[v_Payment].[Payments],0)) AS Balance
      ,FORMAT([Telephone], '0##-###-####') as [Telephone]
      ,[Email]
      ,DATEPART(year,GETDATE()) AS [BillingDate]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],9) AS [BLOCKIMAGES]
      ,LEFT([del].[dbo].[BILLINGROLL].[Account],4) AS [COMM]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],5,2) AS [DIV]
      ,SUBSTRING([del].[dbo].[BILLINGROLL].[Account],7,3) [BLOCK]
      ,RIGHT([del].[dbo].[BILLINGROLL].[Account],3) AS [PARCEL]
      ,FORMAT((COALESCE([dbo].[DISCOUNT].[Discount],0)/100), '##.######## %', 'en-us') as [Discount]
	    ,[Served]
  	  ,[Date_Served]
	    ,[Warning_Notice]
	    ,[Final_Warning_Notice]
	    ,[Court_Summon]
      ,[PictureID]
      ,[PictureURL]
      ,[SumBuiding]
      ,[SHAPE]
  FROM [del].[dbo].[BILLINGROLL]
     LEFT OUTER JOIN [del].[dbo].[DISCOUNT] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[DISCOUNT].[Account]
     LEFT OUTER JOIN [del].[dbo].[v_Payment] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[v_Payment].[Account]
     LEFT OUTER JOIN [del].[dbo].[Served] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Served].[Account]
     LEFT OUTER JOIN [del].[dbo].[Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Final_Warning_Notice] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Final_Warning_Notice].[Account]
     LEFT OUTER JOIN [del].[dbo].[Court_Summon] on [del].[dbo].[BILLINGROLL].[Account]= [del].[dbo].[Court_Summon].[Account]
  where LEN([Email]) > 3 AND [Email] is not null AND [Use_] != 'VACANT OR UNCOMPLETED PROPERTY' AND [Use_] != 'DILAPIDATED' AND [Use_] != 'DIPLOMATIC MISSION (MISSION OWNED)' AND [Use_] != 'DIPLOMATIC MISSION (GOVT OWNED)' AND [Use_] != 'DIPLOMATIC MISSION (PRIVATE OWN)' AND [Use_] != 'NOT ASSES' AND [Use_] != 'MILITARY INSTALLATIONS' AND [Use_] != 'DERELICT' AND [Use_] != 'CEMETERY'
  order by [dbo].[BILLINGROLL].[Account]
GO

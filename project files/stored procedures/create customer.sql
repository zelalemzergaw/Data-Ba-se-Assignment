/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [customerID]
      ,[fName]
      ,[lName]
      ,[telephoneNO]
      ,[serviceNo]
      ,[street]
      ,[city]
      ,[state]
      ,[zipcode]
      ,[country]
      ,[commissionRate]
	  ,[salesId]
  FROM [Telephone Companey].[dbo].[Customer]
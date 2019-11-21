USE [TelephoneCompany]
GO
/****** Object:  StoredProcedure [dbo].[monthlySalesRepCommission] Script Date: 11/20/2019 3:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[monthlySalesRepCommission]
(@startDate DATE,
@endDate DATE)

AS
BEGIN

    SELECT S.salesRepID, S.fName, S.lNmae, SUM(commissionRate) AS totalCommission
	FROM Sales_Representative S, Customer C, calls cl
	WHERE C.salesRepID = S.salesRepID AND cl.fromTel = C.telephoneNo AND Cl.callDate between @startDate AND @endDate
	group by  S.salesRepID, S.fName, S.lNmae;

END 
GO

exec monthlySalesRepCommission '11-05-2007','12-30-2007'

USE [TelephoneCompany]
GO

/****** Object:  StoredProcedure [dbo].[MonthlyAllCustomerTotalBalance]   ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[MonthlyAllCustomerTotalBalance]
	@month int,
	@year int
AS
BEGIN
	SELECT cust.telephoneNo, cust.fName, cust.lName, c.toTel, c.duration,c.callDate ,c.callTime, s.name, cc.countryName,
	((case when c.callTime between  s.peakStart and s.peakEnd then r.peak ELSE r.offPeak END)*c.duration/60) as rate
		
	FROM Customer cust, Calls c, CallingCode cc, Service s, Rate r
	WHERE
		cust.telephoneNo = c.fromTel and
		s.ServiceNo = cust.serviceNo and
		c.fromTel = cust.telephoneNo and
		cc.code = c.toCode and
		month(c.callDate) = @month and 
		year(c.callDate) = @year and
		r.serviceNo = s.ServiceNo and
		r.code = cc.code and
		r.effectiveDate = (select max(effectiveDate) from Rate)

	ORDER BY cust.fName, cc.countryName
END
GO

EXEC MonthlyAllCustomerTotalBalance '01','2008'

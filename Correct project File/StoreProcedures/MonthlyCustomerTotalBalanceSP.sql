USE [TelephoneCompany]
GO

/****** Object:  StoredProcedure [dbo].[MonthlyCustomerTotalBalance]  ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[MonthlyCustomerTotalBalance]
	@telephoneNo varchar(50),
	@month int,
	@year int
AS
BEGIN
	SELECT cust.telephoneNo, cust.fName, cust.lName, cust.street, cust.city, cust.zipCode, cust.state, cust.country as fromCountry, 
	c.toTel, c.duration, c.callDate ,c.callTime, s.name, cc.countryName,
	CEILING(((case when s.peakStart< c.callTime AND c.callTime > s.peakEnd then r.peak ELSE r.offPeak END)*c.duration/60) * 100)/100 as rate


	FROM Customer cust, Calls c, CallingCode cc, Service s, Rate r
	WHERE
		cust.telephoneNo = @telephoneNo and
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

exec MonthlyCustomerTotalBalance '2158144236','01','2008'
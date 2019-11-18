/****** Object:  Table [dbo].[Sales_Representative] ******/
CREATE TABLE [dbo].[Sales_Representative](
  [salesRepID] [int] NOT NULL,
  [fName] [varchar](50) NOT NULL,
  [lNmae] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Sales_Representative] PRIMARY KEY CLUSTERED 
(
  [salesRepID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service] ******/
CREATE TABLE [dbo].[Service](
  [serviceNo] [varchar](50) NOT NULL,
  [name] [varchar](50) NOT NULL,
  [country] [varchar](50) NOT NULL,
  [peakStart] [datetime] NOT NULL,
  [peakEnd] [datetime] NOT NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
  [serviceNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rate] ******/

CREATE TABLE [dbo].[Rate](
  [code] [int] NOT NULL,
  [peakRate] [real] NOT NULL,
  [offPeakRate] [real] NOT NULL,
  [effectiveDate] [date] NOT NULL,
  [serviceNo] [int] NOT NULL,
  CONSTRAINT [PK_Rate] PRIMARY KEY CLUSTERED 
(
  [code] ASC,
  [serviceNo] ASC,
  [effectiveDate] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Calls] ******/

CREATE TABLE [dbo].[Calls]([callsId][int] NOT NULL,
  [fromCode] [int] NOT NULL,
  [toCode] [int] NOT NULL,
  [fromTel] [int] NOT NULL,
  [toTel][date] NOT NULL,
  [duration] [int] NOT NULL,
  [callDate] [date] NOT NULL,
  [callTime] [int] NOT NULL,
  [customerId] [int] NOT NULL,
 CONSTRAINT [PK_Calls] PRIMARY KEY CLUSTERED 
(
  [callsId] ASC
  
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Calling_Code]  ******/

CREATE TABLE [dbo].[CallingCode](
  [countryName] [varchar](50) NOT NULL,
  [code] [int] NOT NULL,
 CONSTRAINT [PK_CallingCode] PRIMARY KEY CLUSTERED 
(
  [code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[[Customer]]  ******/
CREATE TABLE [dbo].[Customer](
  [customerID] INT IDENTITY(1,1),
  [fName] [varchar](50) NOT NULL,
  [lName] [varchar](50) NOT NULL,
  [telephoneNO] [int] NOT NULL,
  [serviceNo] [int] NOT NULL,
  [street] [varchar](50) NOT NULL,
  [city] [varchar](50) NOT NULL,
  [state] [varchar](50),
  [zipcode] [int],
  [country] [varchar](50) NOT NULL,
  [salesRepId] [int] NOT NULL,
  [commissionRate] [int] NOT NULL,

 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
  [customerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
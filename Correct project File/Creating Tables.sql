/****** Object:  Table [dbo].[Sales_Representative] ******/
CREATE TABLE [dbo].[Sales_Representative](
  [salesRepID] INT IDENTITY(1,1),
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
  [serviceNo] INT IDENTITY(1,1),
  [name] [varchar](50) NOT NULL,
  [country] [varchar](50) NOT NULL,
  [peakStart] [time] NOT NULL,
  [peakEnd] [time] NOT NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
  [serviceNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rate] ******/

CREATE TABLE [dbo].[Rate](
  [rateID] [int] IDENTITY(1,1) NOT NULL,
  [effectiveDate] [date] NOT NULL,
  [code] [int] NOT NULL,
  [peak] [numeric](3, 2) NOT NULL,
  [offPeak] [numeric](3, 2) NOT NULL,
  [serviceNo] [int] NOT NULL,
 CONSTRAINT [PK_Rate] PRIMARY KEY CLUSTERED 
(
  [rateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Calls] ******/

CREATE TABLE [dbo].[Calls](
  [callsId]INT IDENTITY(1,1),
  [fromCode] [int] NOT NULL,
  [toCode] [int] NOT NULL,
  [fromTel] bigint NOT NULL,
  [toTel] bigint NULL,
  [duration] [int] NOT NULL,
  [callDate] [date] NOT NULL,
  [callTime] [TIME] NOT NULL,
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
  [fName] [varchar](50) NULL,
  [lName] [varchar](50) NULL,
  [telephoneNO] bigint NOT NULL,
  [serviceNo] int NULL,
  [street] [varchar](50) NULL,
  [city] [varchar](50) NULL,
  [state] [varchar](50),
  [zipcode] [int],
  [country] [varchar](50) NULL,
  [salesRepId] int  NULL,
  [commissionRate] [int] NULL,

 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
  [telephoneNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
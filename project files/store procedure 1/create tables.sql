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
  [rateID] INT IDENTITY(1,1),
  [effectiveDate] [date] NOT NULL,
  [code] [int] NOT NULL,
  [peak] [numeric](3,2) NOT NULL,
  [offPeak] [numeric](3,2) NOT NULL,
  [serviceNo] INT NOT NULL ,
  CONSTRAINT [PK_Rate] PRIMARY KEY CLUSTERED 
(
  [rateID] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Calls] ******/

CREATE TABLE [dbo].[Calls](
  [callsId]INT IDENTITY(1,1),
  [from_code] [bigint] NOT NULL,
  [to_code] [bigint] NOT NULL,
  [from_tel] [bigint] NOT NULL,
  [to_tel][bigint] NOT NULL,
  [duration] [int] NOT NULL,
  [call_date] [date] NOT NULL,
  [call_time] [float] NOT NULL,

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
  [telephoneNO] varchar(50) NOT NULL,
  [serviceNo]  [varchar](50) NOT NULL,
  [street] [varchar](50) NOT NULL,
  [city] [varchar](50) NOT NULL,
  [state] [varchar](50),
  [zipcode] [int],
  [country] [varchar](50) NOT NULL,
  [salesRepId] INT NOT NULL,
  [commissionRate] [int] NOT NULL,

 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
  [customerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
select * from service
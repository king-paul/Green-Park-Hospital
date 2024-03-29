USE [Assignment 2 - Hospital]
GO
/****** Object:  Table [dbo].[Bed]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bed](
	[BedID] [int] IDENTITY(1,1) NOT NULL,
	[Ward Type] [varchar](50) NOT NULL,
	[Bed Number] [int] NOT NULL,
	[Rate Per Day] [numeric](8, 2) NOT NULL,
	[Occupied] [bit] NOT NULL,
	[OccupiedID] [int] NULL,
	[Date Of Admission] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Doctor](
	[DoctorID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Doctor Type] [varchar](50) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[Home Phone] [varchar](11) NOT NULL,
	[Mobile] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Patient](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Date Of Birth] [date] NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[Phone (Home_Work)] [varchar](20) NOT NULL,
	[Phone(Mobile)] [varchar](20) NULL,
	[Emerg Contact (Name)] [varchar](50) NULL,
	[Emerg Contact (Number)] [varchar](20) NULL,
	[Date Of Registration] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](25) NOT NULL,
	[Password] [varchar](40) NOT NULL,
	[Email Address] [varchar](50) NOT NULL,
	[isAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Visit]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Visit](
	[VisitID] [int] IDENTITY(1,1) NOT NULL,
	[DoctorID] [int] NOT NULL,
	[PatientID] [int] NOT NULL,
	[In Patient] [bit] NOT NULL,
	[BedID] [int] NULL,
	[Date Of Visit] [date] NOT NULL,
	[Date Of Discharge] [date] NULL,
	[Symptoms] [varchar](1000) NULL,
	[Disease] [varchar](1000) NULL,
	[Treatment] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[VisitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[BedView]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BedView]
AS
SELECT        dbo.Bed.[Ward Type], dbo.Bed.[Bed Number] AS Number, dbo.Bed.[Rate Per Day], NULL AS [Occupied By]
FROM            dbo.Bed
WHERE        dbo.Bed.OccupiedID IS NULL
UNION
SELECT        dbo.Bed.[Ward Type], dbo.Bed.[Bed Number] AS Number, dbo.Bed.[Rate Per Day], dbo.Patient.Name AS [Occupied By]
FROM            dbo.Bed INNER JOIN
                         dbo.Patient ON dbo.Patient.PatientID = dbo.Bed.OccupiedID

GO
/****** Object:  View [dbo].[InBedView]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[InBedView]
AS
SELECT        dbo.Patient.Name, dbo.Bed.[Ward Type], dbo.Bed.[Bed Number], dbo.Bed.[Rate Per Day], dbo.Bed.[Date Of Admission], DATEDIFF(day, dbo.Bed.[Date Of Admission], 
                         { fn CURDATE() }) AS [Days In], dbo.Bed.[Rate Per Day] * DATEDIFF(day, dbo.Bed.[Date Of Admission], { fn CURDATE() }) AS [Amount Payable]
FROM            dbo.Patient INNER JOIN
                         dbo.Bed ON dbo.Patient.PatientID = dbo.Bed.OccupiedID

GO
/****** Object:  View [dbo].[VisitsView]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VisitsView]
AS
SELECT        dbo.Patient.Name AS [Patient Name], dbo.Doctor.Name AS [Doctor Name], dbo.Visit.[In Patient], dbo.Visit.[Date Of Visit], dbo.Visit.[Date Of Discharge], 
                         dbo.Visit.Symptoms, dbo.Visit.Disease, dbo.Visit.Treatment
FROM            dbo.Visit INNER JOIN
                         dbo.Patient ON dbo.Patient.Name = dbo.Patient.Name AND dbo.Visit.PatientID = dbo.Patient.PatientID INNER JOIN
                         dbo.Doctor ON dbo.Doctor.Name = dbo.Doctor.Name AND dbo.Visit.DoctorID = dbo.Doctor.DoctorID

GO
SET IDENTITY_INSERT [dbo].[Bed] ON 

INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (1, N'Maternity', 1, CAST(650.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (2, N'Maternity', 2, CAST(650.00 AS Numeric(8, 2)), 1, 31, CAST(N'2014-08-19 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (3, N'Maternity', 3, CAST(650.00 AS Numeric(8, 2)), 1, 35, CAST(N'2014-08-20 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (4, N'Maternity', 4, CAST(650.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (5, N'Pediatrics', 1, CAST(550.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (6, N'Pediatrics', 2, CAST(550.00 AS Numeric(8, 2)), 1, 15, CAST(N'2014-08-21 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (7, N'Pediatrics', 3, CAST(550.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (8, N'Pediatrics', 4, CAST(550.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (9, N'Cardiology', 1, CAST(700.00 AS Numeric(8, 2)), 1, 50, CAST(N'2014-08-18 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (10, N'Cardiology', 2, CAST(700.00 AS Numeric(8, 2)), 1, 41, CAST(N'2014-08-19 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (11, N'Cardiology', 3, CAST(700.00 AS Numeric(8, 2)), 1, 45, CAST(N'2014-08-20 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (12, N'Cardiology', 4, CAST(700.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (13, N'Oncology', 1, CAST(700.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (14, N'Oncology', 2, CAST(700.00 AS Numeric(8, 2)), 1, 10, CAST(N'2014-08-19 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (15, N'Oncology', 3, CAST(700.00 AS Numeric(8, 2)), 1, 47, CAST(N'2014-08-19 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (16, N'Oncology', 4, CAST(700.00 AS Numeric(8, 2)), 1, 7, CAST(N'2014-08-22 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (17, N'Rehabilitation', 1, CAST(500.00 AS Numeric(8, 2)), 1, 34, CAST(N'2014-08-18 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (18, N'Rehabilitation', 2, CAST(500.00 AS Numeric(8, 2)), 1, 20, CAST(N'2014-08-19 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (19, N'Rehabilitation', 3, CAST(500.00 AS Numeric(8, 2)), 1, 4, CAST(N'2014-08-21 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (20, N'Rehabilitation', 4, CAST(500.00 AS Numeric(8, 2)), 1, 26, CAST(N'2014-08-22 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (21, N'Intensive Care', 1, CAST(800.00 AS Numeric(8, 2)), 1, 48, CAST(N'2014-08-19 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (22, N'Intensive Care', 2, CAST(800.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (23, N'Intensive Care', 3, CAST(800.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (24, N'Intensive Care', 4, CAST(800.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (25, N'General', 1, CAST(600.00 AS Numeric(8, 2)), 1, 3, CAST(N'2014-08-19 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (26, N'General', 2, CAST(600.00 AS Numeric(8, 2)), 1, 42, CAST(N'2014-08-19 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (27, N'General', 3, CAST(600.00 AS Numeric(8, 2)), 1, 30, CAST(N'2014-08-20 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (28, N'General', 4, CAST(600.00 AS Numeric(8, 2)), 1, 36, CAST(N'2014-08-20 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (29, N'General', 5, CAST(600.00 AS Numeric(8, 2)), 1, 38, CAST(N'2014-08-21 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (30, N'General', 6, CAST(600.00 AS Numeric(8, 2)), 1, 27, CAST(N'2014-08-21 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (31, N'General', 7, CAST(600.00 AS Numeric(8, 2)), 1, 16, CAST(N'2014-08-22 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (32, N'General', 8, CAST(600.00 AS Numeric(8, 2)), 1, 46, CAST(N'2014-08-22 00:00:00.000' AS DateTime))
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (33, N'General', 9, CAST(600.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (34, N'General', 10, CAST(600.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (35, N'General', 11, CAST(600.00 AS Numeric(8, 2)), 0, NULL, NULL)
INSERT [dbo].[Bed] ([BedID], [Ward Type], [Bed Number], [Rate Per Day], [Occupied], [OccupiedID], [Date Of Admission]) VALUES (36, N'General', 12, CAST(600.00 AS Numeric(8, 2)), 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Bed] OFF
SET IDENTITY_INSERT [dbo].[Doctor] ON 

INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (1, N'Vaughn, Quentin', N'Pediatrician', N'73 Stanley St, Frankston, 3199', N'03 98236992', N'0480851855')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (2, N'Campos, Vivien', N'Pediatrician', N'6 Bambra Crt, Noble Park, 3174', N'03 90563756', N'0458529296')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (3, N'Hutchinson, Mariko', N'Obstetrician', N'55 Aylmer St, Balwyn North, 3104', N'03 90433121', N'0435900380')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (4, N'Myers, Gregory', N'Obstetrician', N'31 Burnett St, St Kilda, 3140', N'03 95693482', N'0467684493')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (5, N'Bowers, Abel', N'Obstetrician', N'1 Jaycee Crt, Koblenz, 3850', N'03 95404424', N'0470440673')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (6, N'Silva, Geoffrey', N'Cardiologist', N'2 Albert Av, Oakleigh, 3166', N'03 92281152', N'0434506054')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (7, N'Vance, Ray', N'Cardiologist', N'18 Amery Ave, Blackbur, 3130', N'03 94120242', N'0429253768')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (8, N'Simpson, May', N'Ocologist', N'U6/ 45 Bowmore Rd, Noble Park, 3008', N'03 91109964', N'0425584950')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (9, N'Warren, Neil', N'Ocologist', N'120 Sutton Park Rd, Newly, 3364', N'03 97549138', N'0459688594')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (10, N'Salazar, Graide', N'Anaesthetist', N'15 Bergamot Drv, Point Cook, 3030', N'03 92986250', N'0433134477')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (11, N'Rhodes, Laura', N'Anaesthetist', N'6 Kingdom Crt, Roxburgh Park, 3064', N'03 93484462', N'0492195938')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (12, N'Knapp, Nehru', N'Physiotherapist', N'153 Evans St, Sunbury, 3429', N'03 91412976', N'0405207760')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (13, N'Wilson, Kieran', N'Physiotherapist', N'7 Cowan Pkwy, Point Cook, 3030', N'03 91936565', N'0488050150')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (14, N'Donaldson, Kimberly', N'Physiotherapist', N'15 Second Ave, Brunswick, 3056', N'03 92797760', N'0485684843')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (15, N'Chapman, Evangeline', N'Surgeon', N'22 Mingana Rd, Wantirna, 3152', N'03 98179098', N'0420958056')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (16, N'Nichols, Sasha', N'Resident', N'9 Bateman Crt, Coburg East, 3058', N'03 98219987', N'0440938672')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (17, N'Vazquez, Gannon', N'Consultant', N'8 Headingley Rd, Mt Waverley, 3149', N'03 91150575', N'0455706088')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (18, N'Stanley, Althea', N'Resident', N'176 Walsh St, South Yarra, 314', N'03 91811434', N'0494065219')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (19, N'Lang, Josiah', N'Surgeon', N'4 Bell Ave, Altona, 3018', N'03 95127545', N'0425654954')
INSERT [dbo].[Doctor] ([DoctorID], [Name], [Doctor Type], [Address], [Home Phone], [Mobile]) VALUES (20, N'Becker, Elijah', N'Surgeon', N'45 Bastings St, Northcote, 3070', N'03 93068260', N'0422505923')
SET IDENTITY_INSERT [dbo].[Doctor] OFF
SET IDENTITY_INSERT [dbo].[Patient] ON 

INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (1, N'Hanson, Kelly', CAST(N'2013-01-18' AS Date), N'36 Rose St, Horsham VIC 3400', N'(03) 5382 5270', N'0409 504 553', N'Hanson, Alyssa', N'0428 721 921', CAST(N'2013-08-26' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (2, N'Cooley, Mira', CAST(N'1941-11-30' AS Date), N'1 Strathnaver Av, Strathmore VIC 3041', N'(03) 9077 0441', N'0429 589 122', N'Cooley, Derek', N'0452 913 038', CAST(N'2013-08-31' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (3, N'Walker, Lewis', CAST(N'1940-01-01' AS Date), N'P.O. Box 742, 8030 Ante. Rd, Watson Lake  Yukon, Y1Z 8Y2,  Canada ', N'(204) 854-5835', N'', N'Walker, Reuben', N'(581) 398-5508 ', CAST(N'2013-10-03' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (4, N'Armstrong, Skyler', CAST(N'1991-02-28' AS Date), N'Ap #449-8115 Eget Ave, Laramie, Wyoming, 24521, United States', N'(681) 719-7949  ', N'', N'Armstrong, Aubrey', N'(681) 719-7949  ', CAST(N'2013-10-09' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (5, N'Owen, Quin', CAST(N'1984-04-18' AS Date), N'4989 Velit. Av, Porirua North Island  5004 ,New Zealand  ', N'(355) 349-4953', N'', N'Owen, Taylor', N'(886) 370-6848', CAST(N'2013-11-07' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (6, N'Mason, Alfonso', CAST(N'1948-12-23' AS Date), N'19 Bradley St, Warrnambool VIC 3280', N'(03) 5561 0935', N'0415 437 446', N'Mason, Rachel', N'0456 239 754', CAST(N'2013-11-14' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (7, N'Spencer, Moses', CAST(N'1979-03-07' AS Date), N'9 Tarella Drv, Mt Waverley VIC 3149', N'(03) 9888 7161', N'0412 466 721', N'Spencer, Lareina', N'0446 335 623', CAST(N'2013-12-02' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (8, N'Wong, Rhiannon', CAST(N'1942-05-06' AS Date), N'50 Settler St, Eight Mile Plains QLD 4113', N'(07) 3219 0136', N'0458 074 158', N'Wong, Ahmed', N'0430 817 518', CAST(N'2013-12-21' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (9, N'Lynch, Robin', CAST(N'1967-05-29' AS Date), N'44 Flinders St, Moorabbin Airport VIC 3194', N'(03) 9584 9518', N'0428 148 345', N'Lynch, Virginia', N'0477 450 266', CAST(N'2014-01-05' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (10, N'Velez, Hayden', CAST(N'1965-11-15' AS Date), N'58 Water St, Caringbah South NSW 2229', N'(02) 8521 7001', N'0455 209 682', N'Velez, Rooney', N'0415 318 537', CAST(N'2014-01-05' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (11, N'Christian, Pascale', CAST(N'1942-12-04' AS Date), N'480 St Kilda Rd, Melbourne VIC 3004', N'(03) 9867 5071', N'0429 945 314', N'Christian, Summer', N'0491 616 727', CAST(N'2014-01-14' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (12, N'Sosa, Ainsley', CAST(N'1994-03-15' AS Date), N'1013 Wanneroo Rd, Wanneroo WA 6065', N'(08) 9405 2529', N'0433 802 800', N'Sosa, Mallory', N'0467 947 732', CAST(N'2014-01-21' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (13, N'Esposito, Michela', CAST(N'1972-05-02' AS Date), N'898 Dictum Ave, Trentino-Alto Adige 55649,  Italy ', N'(634) 287-2879', N'', N'Esposito, Giacomo', N'(634) 287-2879 ', CAST(N'2014-01-23' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (14, N'Montgomery, Deanna', CAST(N'1997-05-21' AS Date), N'Braemore, Finley NSW 2713', N'(03) 5883 1047', N'0434 791 699', N'Montgomery, Sylvia', N'0406 860 042', CAST(N'2014-02-01' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (15, N'Wade, Kimberly', CAST(N'2004-01-19' AS Date), N'10 Denbos Crs, Lismore NSW 2480', N'(02) 6621 4334', N'0432 207 732', N'Wade, Alea', N'0409 771 199', CAST(N'2014-03-11' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (16, N'Mays, Anastasia', CAST(N'1974-08-15' AS Date), N'437 Dorset Rd, Croydon VIC 3136', N'(03) 9723 5894', N'0455 063 430', N'Mays, India', N'0468 655 295', CAST(N'2014-03-23' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (17, N'Trujillo, Christen', CAST(N'1975-10-24' AS Date), N'7 Gilbert St, Dover Heights NSW 2030', N'(02) 9371 3046', N'0472 869 680', N'Trujillo, Paki', N'0471 793 023', CAST(N'2014-03-29' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (18, N'Pittman, Miriam', CAST(N'1968-12-14' AS Date), N'65 Bree Rd, Hamilton VIC 3300', N'(03) 5572 1689', N'0462 158 161', N'Pittman, Naomi', N'0453 001 460', CAST(N'2014-04-20' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (19, N'Navarro, Rina', CAST(N'1988-08-22' AS Date), N'1 Rosella Ave, Glenalta SA 5052', N'(08) 8370 0510', N'0434 299 118', N'Navarro, Ocean', N'0496 771 603', CAST(N'2014-04-24' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (20, N'Harris, Madison', CAST(N'1971-08-25' AS Date), N' 718 Quisque Road, Gignod  India', N'91 5394609418', N'', N'Harris, Rooney', N'91 3847898053', CAST(N'2014-05-12' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (21, N'Mccall, Victor', CAST(N'1968-12-03' AS Date), N'Ap #981-5496 Adipiscing Rd, Shimla Pradesh 848864, India', N'91 7033409044', N'', N'Mccall, Bruno', N'91 6427101747', CAST(N'2014-05-12' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (22, N'Hebert, Mikayla', CAST(N'1974-05-28' AS Date), N'18 Evans St, Moonee Ponds VIC 3039', N'(03) 9370 9378', N'0461 023 200', N'Hebert, Tyler', N'0482 303 617', CAST(N'2014-05-13' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (23, N'Miles, Nicole', CAST(N'1945-11-22' AS Date), N'5610 Adipiscing Road, Baie-d''Urf, Quebec J6A 2T6, Canada', N'(807) 197-8147', N'', N'Miles, Naida ', N'(705) 307-2432 ', CAST(N'2014-06-09' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (24, N'Castelli, Erika', CAST(N'1969-01-05' AS Date), N'469 Sed Av., Siculiana Sicilia, 88513, Italy', N'(679) 227-0405', N'', N'Castelli, Greta', N'(291) 916-9313 ', CAST(N'2014-06-12' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (25, N'Watson, Blossom', CAST(N'1955-04-19' AS Date), N'29 Rudds Rd, Korumburra VIC 3950', N'(03) 5658 1395', N'0400 366 920', N'Watson, Noah', N'0450 782 354', CAST(N'2014-06-14' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (26, N'Oliver, Mark', CAST(N'1967-04-09' AS Date), N'P.O. Box 860, 2873 Sed St, Dannevirke North Island 5004, New Zealand', N'(452) 953-5749', N'', N'Oliver, Orlando', N'(990) 516-5062 ', CAST(N'2014-08-16' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (27, N'Cardenas, Kato', CAST(N'1997-12-19' AS Date), N'2 Spencer Crt, Berwick VIC 3806', N'(03) 9702 0381', N'0424 973 254', N'Cardenas, Joan', N'0479 686 085', CAST(N'2014-08-24' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (28, N'Castro, Leandra', CAST(N'1996-01-23' AS Date), N'175 Newry St, Carlton North VIC 3054', N'(03) 9349 5320', N'0476 117 406', N'Castro, Quinlan', N'0403 210 424', CAST(N'2014-08-26' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (29, N'Petersen, Beck', CAST(N'1998-01-19' AS Date), N'144 A Grand Prm, Doubleview WA 6018', N'(08) 9446 5194', N'0400 712 345', N'Petersen, Aladdin', N'0481 751 158', CAST(N'2014-08-31' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (30, N'Clements, Jade', CAST(N'1995-02-14' AS Date), N'68 Manningtree Rd, Hawthorn VIC 3122', N'(03) 9818 612', N'0469 783 120', N'Clements, Byron', N'0478 333 441', CAST(N'2014-09-09' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (31, N'Bryan, Carol', CAST(N'1982-12-03' AS Date), N'Fountains Rd, Mellool NSW 2734', N'(03) 5034 5244', N'0499 605 761', N'Bryan, Zane', N'0498 870 930', CAST(N'2014-12-13' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (32, N'Durham, Joseph', CAST(N'1962-10-17' AS Date), N'123 Edinburgh St, Flemington VIC 3031', N'(03) 9376 4616', N'0416 679 316', N'Durham, Eleanor', N'0421 496 341', CAST(N'2014-12-15' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (33, N'Mercado, Driscoll', CAST(N'1983-11-28' AS Date), N'3 Tonelli Crs, Mill Park VIC 3082', N'(03) 9404 4619', N'0443 704 828', N'Mercado, Paula', N'0467 176 674', CAST(N'2015-01-04' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (34, N'Petty, Callum', CAST(N'1973-10-07' AS Date), N'Heath Rd, Wudinna SA 5652', N'(08) 8680 2456', N'0497 593 524', N'Petty, Josiah', N'0414 035 708', CAST(N'2015-01-04' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (35, N'Bowers, Ina', CAST(N'1993-08-25' AS Date), N'1 Jaycee Crt, Sale VIC 3850', N'(03) 5144 6412', N'0496 617 588', N'Bowers, Ferris', N'0436 264 386', CAST(N'2015-02-07' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (36, N'Gonzalez, Luke', CAST(N'1970-08-20' AS Date), N'93 Scenic Drv, Beaconsfield VIC 3807', N'(03) 9769 7348', N'0408 623 840', N'Gonzalez, Peter', N'0464 986 338', CAST(N'2015-02-15' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (37, N'Stanley, Gwendolyn', CAST(N'1990-07-14' AS Date), N'3 School La, Ferny Creek VIC 3786', N'(03) 9755 2473', N'0441 481 476', N'Stanley, David', N'0475 398 799', CAST(N'2015-02-19' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (38, N'Mcneil, Nichole', CAST(N'1946-02-01' AS Date), N'12 Margaret St, Cohuna VIC 3568', N'(03) 5456 4677', N'0462 092 456', N'Mcneil, Felix', N'0454 940 958', CAST(N'2015-02-23' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (39, N'Morse, Rina', CAST(N'1977-05-14' AS Date), N'9 Tarella Crt, Ormeau QLD 4208', N'(07) 5549 3635', N'0455 950 734', N'Morse, Cairo', N'0447 620 341', CAST(N'2015-03-02' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (40, N'Mccray, Ezra', CAST(N'1968-05-14' AS Date), N'37 Somers Ave, McCrae VIC 3938', N'(03) 5986 3507', N'0474 126 318', N'Mccray, Jennifer', N'0407 319 415', CAST(N'2015-03-18' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (41, N'Woods, Susan', CAST(N'1937-12-25' AS Date), N'7 Batten Pl, Aspendale Gardens VIC 3195', N'(03) 9587 4018', N'0495 465 284', N'Woods, Pearl', N'0444 001 785', CAST(N'2015-03-20' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (42, N'Lee, Shana', CAST(N'1996-07-16' AS Date), N'25 Windsor Ave, Oakleigh South VIC 3167', N'(03) 9579 0409', N'0484 154 866', N'Lee, Hector', N'0420 853 541', CAST(N'2015-03-21' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (43, N'Armstrong, Astra', CAST(N'1955-09-27' AS Date), N'71 Dobson St, Ferntree Gully VIC 3156', N'(03) 9753 6873', N'0472 543 113', N'Armstrong, Amos', N'0417 924 399', CAST(N'2015-03-21' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (44, N'Eaton, Ethan', CAST(N'2006-01-19' AS Date), N'17 Fulcher St, Daylesford VIC 346', N'(03) 5348 1645', N'0470 740 032', N'Eaton, Aiko', N'0445 319 208', CAST(N'2015-03-29' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (45, N'French, Blythe', CAST(N'1939-03-24' AS Date), N'Doogallook Goulburn Valley Hwy, Homewood VIC 3717', N'(03) 5797 0217', N'0436 822 702', N'French, Malachi', N'0466 993 561', CAST(N'2015-05-02' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (46, N'Harrell, Justin', CAST(N'1950-12-04' AS Date), N'6 Haigh Rd, Canning Vale WA 6155', N'(08) 6254 2919', N'0455 853 333', N'Harrell, Ray', N'0434 869 425', CAST(N'2015-05-07' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (47, N'Pittman, Lee', CAST(N'1943-02-22' AS Date), N'35 Wilkinson Crs, Bellfield VIC 3081', N'(03) 9455 0007', N'0404 342 660', N'Pittman, Dakota', N'0429 530 447', CAST(N'2015-05-11' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (48, N'Gentry, Lee', CAST(N'1998-01-19' AS Date), N'23 Mountain View Pde, Rosanna VIC 3084', N'(03) 9457 7770', N'0467 582 557', N'Lee, Malik', N'0484 608 605', CAST(N'2015-05-26' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (49, N'Mcdowell, Gannon', CAST(N'1994-04-08' AS Date), N'85 Gordon St, Newport VIC 3015', N'(03) 9399 5914', N'0457 717 650', N'Mcdowell, Thaddeus', N'0454 890 182', CAST(N'2015-06-07' AS Date))
INSERT [dbo].[Patient] ([PatientID], [Name], [Date Of Birth], [Address], [Phone (Home_Work)], [Phone(Mobile)], [Emerg Contact (Name)], [Emerg Contact (Number)], [Date Of Registration]) VALUES (50, N'Bruno, Alessandro', CAST(N'1935-02-06' AS Date), N'154 Tincidunt. Ave, Gignod  Valle d''Aosta, Italy', N'(308) 310-7632', N'', N'Bruno,Roberto', N'(308) 310-7632', CAST(N'2015-07-08' AS Date))
SET IDENTITY_INSERT [dbo].[Patient] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email Address], [isAdmin]) VALUES (1, N'Paul', N'6367c48dd193d56ea7b0baad25b19455e529f5ee', N'PaulKing09@bigpond.com', 1)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email Address], [isAdmin]) VALUES (3, N'Billy', N'4be30d9814c6d4e9800e0d2ea9ec9fb00efa887b', N'aaa@bbb.com', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[Visit] ON 

INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (19, 1, 1, 0, 5, CAST(N'2014-08-19' AS Date), CAST(N'2014-08-24' AS Date), N'Sore throat and infected tonsils.', N'Diagnosed with Tonsillitis.', N'Removal of tonsils needed.')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (20, 1, 15, 1, 6, CAST(N'2014-08-22' AS Date), NULL, N'Difficulty breathing.', N'Accute Asthma', N'Need of oxygen medication.')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (21, 3, 19, 0, 1, CAST(N'2014-08-19' AS Date), CAST(N'2014-08-24' AS Date), N'Labour Pains', N'None found', N'Examination of baby')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (22, 4, 31, 1, 2, CAST(N'2014-08-19' AS Date), NULL, N'Labour Pains', N'None found', N'Examination of baby')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (23, 5, 35, 1, 3, CAST(N'2014-08-20' AS Date), NULL, N'Labour Pains', N'None found', N'Examination of baby')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (24, 6, 50, 1, 9, CAST(N'2014-08-19' AS Date), NULL, N'Pains in chest', N'Heart problems', N'Heart surgery')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (25, 6, 41, 1, 10, CAST(N'2014-08-19' AS Date), NULL, N'Pains in chest', N'Heart problems', N'Heart Surgery')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (26, 7, 45, 1, 11, CAST(N'2014-08-21' AS Date), NULL, N'Pains in chest', N'Heart problems', N'Heart Surgery')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (27, 8, 2, 0, 13, CAST(N'2014-08-17' AS Date), CAST(N'2014-08-24' AS Date), N'Coughing, shortness of breath', N'Lung Cancer', N'Removal of diseased part of lung')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (28, 8, 10, 1, 14, CAST(N'2014-08-19' AS Date), NULL, N'Headaches, blurry vision', N'Brain tumour', N'Surgery. Removal of Tumour.')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (29, 9, 47, 1, 15, CAST(N'2014-08-20' AS Date), NULL, N'Swollen lymph nodes, fevers and night sweats.', N'Diagnosis of acute leukaemia', N'Chemotherapy medication')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (30, 9, 7, 1, 16, CAST(N'2014-08-23' AS Date), NULL, N'Moles found', N'Melanoma ', N'Surgery to remove moles from body')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (33, 18, 3, 1, 25, CAST(N'2014-08-19' AS Date), NULL, N'Cough, Shortness of Breath', N'Pneumonia', N'Use of antibiotics')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (34, 18, 42, 1, 26, CAST(N'2014-08-19' AS Date), NULL, N'Coughing, Shortness of Breath', N'Pneumonia', N'Use of antibiotics')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (36, 15, 38, 1, 29, CAST(N'2014-08-21' AS Date), NULL, N'Experiencing severe pain from leg injury', N'Leg bone broken', N'Leg set in plaster')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (37, 15, 27, 1, 30, CAST(N'2014-08-22' AS Date), NULL, N'Experiencing severe pain in arm from arm injury', N'Bone in arm broken', N'Arm set in plaster')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (38, 16, 30, 1, 27, CAST(N'2014-08-20' AS Date), NULL, N'Pain in lower abdomen', N'Appendicitis', N'Operation to remove appendix')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (39, 15, 36, 1, 28, CAST(N'2014-08-20' AS Date), NULL, N'Pain in lower abdomen', N'Appendicitis', N'Operation to remove appendix')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (40, 19, 16, 1, 31, CAST(N'2014-08-22' AS Date), NULL, N'Bumps and lumps found on skin', N'Cyst Lumps', N'Surgery - Removal of Cyst')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (41, 19, 46, 1, 32, CAST(N'2014-08-22' AS Date), NULL, N'Bumps and lumps found on skin', N'Cyst Lumps', N'Surgery - Removal of Cyst')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (42, 17, 48, 1, 21, CAST(N'2014-08-19' AS Date), NULL, N'Multiple serious injuries found on body', N'Injured in car accident', N'Intensive care needed while in coma')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (43, 12, 34, 1, 17, CAST(N'2014-08-18' AS Date), NULL, N'Unable to move left arm', N'Recovering from a stroke', N'Physical rehabilitation')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (44, 12, 20, 1, 18, CAST(N'2014-08-19' AS Date), NULL, N'Unable to walk correctly', N'Recovering from stroke', N'Physical strengthening and rehabilitation')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (45, 13, 4, 1, 19, CAST(N'2014-08-21' AS Date), NULL, N'Pains in back', N'Back Injury', N'Massage and physical exercises')
INSERT [dbo].[Visit] ([VisitID], [DoctorID], [PatientID], [In Patient], [BedID], [Date Of Visit], [Date Of Discharge], [Symptoms], [Disease], [Treatment]) VALUES (46, 14, 26, 1, 20, CAST(N'2014-08-22' AS Date), NULL, N'Pains in leg, difficulty moving it', N'Recovery from broken leg', N'Massage and physical exercises')
SET IDENTITY_INSERT [dbo].[Visit] OFF
ALTER TABLE [dbo].[Bed]  WITH CHECK ADD  CONSTRAINT [FK_Bed_Patient] FOREIGN KEY([OccupiedID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[Bed] CHECK CONSTRAINT [FK_Bed_Patient]
GO
ALTER TABLE [dbo].[Visit]  WITH CHECK ADD  CONSTRAINT [FK_Visit_Bed] FOREIGN KEY([BedID])
REFERENCES [dbo].[Bed] ([BedID])
GO
ALTER TABLE [dbo].[Visit] CHECK CONSTRAINT [FK_Visit_Bed]
GO
ALTER TABLE [dbo].[Visit]  WITH CHECK ADD  CONSTRAINT [FK_Visit_Doctor] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Doctor] ([DoctorID])
GO
ALTER TABLE [dbo].[Visit] CHECK CONSTRAINT [FK_Visit_Doctor]
GO
ALTER TABLE [dbo].[Visit]  WITH CHECK ADD  CONSTRAINT [FK_Visit_Patient] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[Visit] CHECK CONSTRAINT [FK_Visit_Patient]
GO
ALTER TABLE [dbo].[Bed]  WITH CHECK ADD  CONSTRAINT [chkWardType] CHECK  (([Ward Type]='Maternity' OR [Ward Type]='Pediatrics' OR [Ward Type]='Cardiology' OR [Ward Type]='Oncology' OR [Ward Type]='Rehabilitation' OR [Ward Type]='Intensive Care' OR [Ward Type]='General'))
GO
ALTER TABLE [dbo].[Bed] CHECK CONSTRAINT [chkWardType]
GO
/****** Object:  StoredProcedure [dbo].[AddVisit]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddVisit]
(
	@DoctorID int,
	@PatientID int,
	@inPatient bit,
	@BedId int,
	@DateOfVisit datetime,
	@DateOfDischarge datetime,
	@Symptoms varchar(1000),
	@Disease varchar(1000),
	@Treatment varchar(1000)
)

AS

INSERT INTO Visit(DoctorID, PatientID, [in Patient], BedID, [Date Of Visit], [Date Of Discharge], Symptoms, Disease, Treatment)
VALUES (@DoctorID, @PatientID, @inPatient, @BedId, @DateOfVisit, @DateOfDischarge, @Symptoms, @Disease, @Treatment)
GO
/****** Object:  StoredProcedure [dbo].[AssignToBed]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AssignToBed]
(
	@BedID int,
	@OccupiedID int
)
AS UPDATE Bed
SET Occupied = 1, OccupiedID = @OccupiedID
WHERE BedID = @BedID
GO
/****** Object:  StoredProcedure [dbo].[CreateNewUser]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateNewUser]
(
	@username varchar(25),
	@password varchar(40),
	@EmailAddress varchar(50),
	@isAdmin bit
)
AS

INSERT INTO [Assignment 2 - Hospital].dbo.Users([Username], [Password], [Email Address], [IsAdmin]) 
VALUES(@username, @password, @EmailAddress, @isAdmin)

GO
/****** Object:  StoredProcedure [dbo].[DischargePatient]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DischargePatient]
(
	@BedID int,
	@DateOfDischarge datetime
)
AS UPDATE Bed
SET Occupied = 0, OccupiedID = NULL, [Date Of Admission] = NULL
WHERE BedID = @BedID
UPDATE Visit
SET [Date Of Discharge] = @DateOfdischarge, [In Patient] = 0
WHERE BedID = @BedID
GO
/****** Object:  StoredProcedure [dbo].[RegisterPatient]    Script Date: 25/08/2014 12:11:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegisterPatient]
(
	@Name VARCHAR(50),
	@DateOfBirth date,
	@Address VARCHAR(255),
	@NumberHome VARCHAR(20),
	@NumberMobile VARCHAR(20),
	@EmergContactName VARCHAR(50),
	@EmergContactNumber VARCHAR(11),
	@DateOfRegistration date
)

AS

INSERT dbo.Patient([Name], [Date Of Birth], [Address], [Phone (Home/Work)], [Phone(Mobile)], [Emerg. Contact (Name)], [Emerg. Contact (Number)], [Date Of Registration])
VALUES (@Name, @DateOfBirth, @Address, @NumberHome, @NumberMobile, @EmergContactName, @EmergContactNumber, @DateOfRegistration)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1560
         Width = 2010
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BedView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BedView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Patient"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 220
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Bed"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 198
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1620
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'InBedView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'InBedView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[31] 4[29] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Visit"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 173
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Patient"
            Begin Extent = 
               Top = 34
               Left = 286
               Bottom = 163
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doctor"
            Begin Extent = 
               Top = 6
               Left = 525
               Bottom = 135
               Right = 695
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1980
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2550
         Alias = 1470
         Table = 2070
         Output = 810
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VisitsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VisitsView'
GO

USE [Sym]
GO
/****** Object:  Table [dbo].[Channel]    Script Date: 2018/11/12 上午 11:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Channel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ChannelId] [varchar](128) NOT NULL,
	[Description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ChannelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Node]    Script Date: 2018/11/12 上午 11:14:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Node](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NodeGroupId] [int] NOT NULL,
	[DatabaseType] [int] NULL,
	[DatabaseHost] [varchar](16) NULL,
	[DatabaseName] [varchar](16) NULL,
	[DatabaseUser] [varchar](16) NULL,
	[DatabasePassword] [varchar](16) NULL,
	[SyncUrlPort] [varchar](4) NULL,
	[ExternalId] [varchar](8) NOT NULL,
	[JobPurgePeriodTimeMs] [int] NULL,
	[JobRoutingPeriodTimeMs] [int] NULL,
	[JobPushPeriodTimeMs] [int] NULL,
	[JobPullPeriodTimeMs] [int] NULL,
	[InitialLoadCreateFirst] [bit] NULL,
	[NodePassword] [varchar](50) NULL,
	[Version] [int] NOT NULL,
 CONSTRAINT [PK__Node__3214EC072C15CEDA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__Node__599A6201BA246948] UNIQUE NONCLUSTERED 
(
	[NodeGroupId] ASC,
	[ExternalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NodeGroup]    Script Date: 2018/11/12 上午 11:14:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NodeGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[Description] [varchar](255) NULL,
	[NodeGroupId] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NodeGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Project]    Script Date: 2018/11/12 上午 11:14:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Router]    Script Date: 2018/11/12 上午 11:14:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Router](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RouterId] [varchar](50) NOT NULL,
	[SourceNodeGroupId] [int] NULL,
	[TargetNodeGroupId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RouterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trigger]    Script Date: 2018/11/12 上午 11:14:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trigger](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ChannelId] [int] NOT NULL,
	[TriggerId] [varchar](128) NOT NULL,
	[SourceTableName] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ChannelId] ASC,
	[TriggerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TriggerRouter]    Script Date: 2018/11/12 上午 11:14:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TriggerRouter](
	[TriggerId] [int] NOT NULL,
	[RouterId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TriggerId] ASC,
	[RouterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF__Node__JobPurgePe__403A8C7D]  DEFAULT ((7200000)) FOR [JobPurgePeriodTimeMs]
GO
ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF__Node__JobRouting__412EB0B6]  DEFAULT ((5000)) FOR [JobRoutingPeriodTimeMs]
GO
ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF__Node__JobPushPer__4222D4EF]  DEFAULT ((10000)) FOR [JobPushPeriodTimeMs]
GO
ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF__Node__JobPullPer__4316F928]  DEFAULT ((10000)) FOR [JobPullPeriodTimeMs]
GO
ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF__Node__InitialLoa__440B1D61]  DEFAULT ((1)) FOR [InitialLoadCreateFirst]
GO
ALTER TABLE [dbo].[Node]  WITH CHECK ADD  CONSTRAINT [FK__Node__NodeGroupI__5629CD9C] FOREIGN KEY([NodeGroupId])
REFERENCES [dbo].[NodeGroup] ([Id])
GO
ALTER TABLE [dbo].[Node] CHECK CONSTRAINT [FK__Node__NodeGroupI__5629CD9C]
GO
ALTER TABLE [dbo].[NodeGroup]  WITH CHECK ADD FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([Id])
GO
ALTER TABLE [dbo].[Router]  WITH CHECK ADD FOREIGN KEY([SourceNodeGroupId])
REFERENCES [dbo].[NodeGroup] ([Id])
GO
ALTER TABLE [dbo].[Router]  WITH CHECK ADD FOREIGN KEY([TargetNodeGroupId])
REFERENCES [dbo].[NodeGroup] ([Id])
GO
ALTER TABLE [dbo].[Trigger]  WITH CHECK ADD FOREIGN KEY([ChannelId])
REFERENCES [dbo].[Channel] ([Id])
GO
ALTER TABLE [dbo].[TriggerRouter]  WITH CHECK ADD FOREIGN KEY([RouterId])
REFERENCES [dbo].[Router] ([Id])
GO
ALTER TABLE [dbo].[TriggerRouter]  WITH CHECK ADD FOREIGN KEY([TriggerId])
REFERENCES [dbo].[Trigger] ([Id])
GO

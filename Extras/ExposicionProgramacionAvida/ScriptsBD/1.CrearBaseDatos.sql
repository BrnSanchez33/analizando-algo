USE [master]
GO
/****** Object:  Database [RutAppBd]    Script Date: 11/10/2012 2:47:29 PM ******/
CREATE DATABASE [RutAppBd]
GO
ALTER DATABASE [RutAppBd] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RutAppBd].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RutAppBd] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RutAppBd] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RutAppBd] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RutAppBd] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RutAppBd] SET ARITHABORT OFF 
GO
ALTER DATABASE [RutAppBd] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RutAppBd] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [RutAppBd] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RutAppBd] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RutAppBd] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RutAppBd] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RutAppBd] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RutAppBd] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RutAppBd] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RutAppBd] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RutAppBd] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RutAppBd] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RutAppBd] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RutAppBd] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RutAppBd] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RutAppBd] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RutAppBd] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RutAppBd] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RutAppBd] SET RECOVERY FULL 
GO
ALTER DATABASE [RutAppBd] SET  MULTI_USER 
GO
ALTER DATABASE [RutAppBd] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RutAppBd] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RutAppBd] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RutAppBd] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'RutAppBd', N'ON'
GO
USE [RutAppBd]
GO
/****** Object:  UserDefinedTableType [dbo].[TablaServicios]    Script Date: 11/10/2012 2:47:29 PM ******/
CREATE TYPE [dbo].[TablaServicios] AS TABLE(
	[TipoServicio] [char](3) NOT NULL
)
GO
/****** Object:  StoredProcedure [dbo].[InsertaArcoDoble]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Los Unmaucios
-- Create date: 3/NOV/2012
-- Description:	Inserta un arco doble entre estaciones
-- =============================================
CREATE PROCEDURE [dbo].[InsertaArcoDoble]
	@estacion_inicio char(8),
	@estacion_final char(8),
	@longitud_interestacion decimal(6,2),
	@velocidad_promedio decimal(6,2)
AS
BEGIN

	DECLARE @RC int
	EXECUTE @RC = [InsertaArcoSencillo] 
	   @estacion_inicio
	  ,@estacion_final
	  ,@longitud_interestacion
	  ,@velocidad_promedio

	EXECUTE @RC = [InsertaArcoSencillo] 
	   @estacion_final
	  ,@estacion_inicio
	  ,@longitud_interestacion
	  ,@velocidad_promedio


	
END

GO
/****** Object:  StoredProcedure [dbo].[InsertaArcoDobleSinDistancias]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Los Unmaucios
-- Create date: 3/NOV/2012
-- Description:	Inserta un arco doble entre estaciones sin distancia
-- =============================================
CREATE PROCEDURE [dbo].[InsertaArcoDobleSinDistancias]
	@estacion_inicio char(8),
	@estacion_final char(8),
	@velocidad_promedio decimal(6,2)
AS
BEGIN

	DECLARE @RC int
	EXECUTE @RC = [InsertaArcoSencilloSinDistancias] 
	   @estacion_inicio
	  ,@estacion_final
	  ,@velocidad_promedio

	EXECUTE @RC = [InsertaArcoSencilloSinDIstancias] 
	   @estacion_final
	  ,@estacion_inicio
	  ,@velocidad_promedio


	
END

GO
/****** Object:  StoredProcedure [dbo].[InsertaArcoSencillo]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Los Unmaucios
-- Create date: 3/NOV/2012
-- Description:	Inserta un arco entre estaciones
-- =============================================
CREATE PROCEDURE [dbo].[InsertaArcoSencillo]
	@estacion_inicio char(8),
	@estacion_final char(8),
	@longitud_interestacion decimal(6,2),
	@velocidad_promedio decimal(6,2)
AS
BEGIN

	INSERT INTO [Tramos]
           ([id_estacion_origen]
           ,[id_estacion_destino]
           ,[distancia]
           ,[velocidad])
     VALUES
           (@estacion_inicio
           ,@estacion_final
           ,@longitud_interestacion
           ,@velocidad_promedio)
	
END

GO
/****** Object:  StoredProcedure [dbo].[InsertaArcoSencilloSinDistancias]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Los Unmaucios
-- Create date: 3/NOV/2012
-- Description:	Inserta un arco entre estaciones sin distancias
-- =============================================
CREATE PROCEDURE [dbo].[InsertaArcoSencilloSinDistancias]
	@estacion_inicio char(8),
	@estacion_final char(8),
	@velocidad_promedio decimal(6,2)
AS
BEGIN

	DECLARE @ubicacion_inicio geography
	DECLARE @ubicacion_final geography
	
	select @ubicacion_inicio = ubicacion from Ubicaciones where id_ubicacion = @estacion_inicio
	select @ubicacion_final = ubicacion from Ubicaciones where id_ubicacion = @estacion_final
	
	INSERT INTO [Tramos]
           ([id_estacion_origen]
           ,[id_estacion_destino]
           ,[distancia]
           ,[velocidad])
     VALUES
           (@estacion_inicio
           ,@estacion_final
           ,@ubicacion_inicio.STDistance(@ubicacion_final)
           ,@velocidad_promedio)
	
END

GO
/****** Object:  StoredProcedure [dbo].[InsertaEstacion]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Los Unmaucios
-- Create date: 3/NOV/2012
-- Description:	Inserta una estacion en la BD
-- =============================================
CREATE PROCEDURE [dbo].[InsertaEstacion]
	@idUbicacion char(8),
	@nombre varchar(45),
	@idTipo char(3),
	@linea varchar(5) =  NULL,
	@latitud float,
	@longitud float
AS
BEGIN
	
	DECLARE @ubicacion geography
	SELECT @ubicacion = Geography::STPointFromText('POINT(' +
		CAST(@longitud AS VARCHAR(20)) +
		' ' + CAST(@latitud AS VARCHAR(20)) + ')' , 4326)
	--SELECT @ubicacion = Geography::Point(@latitud,@longitud,4326)
	
	INSERT INTO [RutAppBd].[dbo].[Ubicaciones]
           ([id_ubicacion]
           ,[nombre]
           ,[ubicacion])
     VALUES
           (@idUbicacion
           ,@nombre
           ,@ubicacion)


	INSERT INTO [RutAppBd].[dbo].[Estaciones]
           ([id_estacion]
           ,[id_tipo]
           ,[linea])
     VALUES
           (@idUbicacion
           ,@idTipo
           ,@linea)

	
END

GO
/****** Object:  StoredProcedure [dbo].[InsertaLugar]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Los Unmaucios
-- Create date: 3/NOV/2012
-- Description:	Inserta una estacion en la BD
-- =============================================
CREATE PROCEDURE [dbo].[InsertaLugar]
	@idUbicacion char(8),
	@nombre varchar(45),
	@tipo varchar(5),
	@latitud float,
	@longitud float
AS
BEGIN
	
	DECLARE @ubicacion geography
	SELECT @ubicacion = Geography::STPointFromText('POINT(' +
		CAST(@longitud AS VARCHAR(20)) +
		' ' + CAST(@latitud AS VARCHAR(20)) + ')' , 4326)
	--SELECT @ubicacion = Geography::Point(@latitud,@longitud,4326)
	
	INSERT INTO [RutAppBd].[dbo].[Ubicaciones]
           ([id_ubicacion]
           ,[nombre]
           ,[ubicacion])
     VALUES
           (@idUbicacion
           ,@nombre
           ,@ubicacion)


	INSERT INTO [RutAppBd].[dbo].[Lugares]
           ([id_lugar]
           ,[tipo])
     VALUES
           (@idUbicacion
           ,@tipo)

	
END

GO
/****** Object:  StoredProcedure [dbo].[numest]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[numest]
as
begin
	select COUNT(*) as "cuenta" from Estaciones
end;
GO
/****** Object:  StoredProcedure [dbo].[ObtieneEstacionesCercanas]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Los Unmaucios
-- Create date: 3/NOV/2012
-- Description:	Obiene las estaciones cercanas 
--				a un punto dado, con un radio variable
--				rdefault = 1500m
-- =============================================
CREATE PROCEDURE [dbo].[ObtieneEstacionesCercanas]
	@latitud decimal(10,7),
	@longitud decimal(10,7),
	@radio int = null,
	@tabla_servicios AS [dbo].[TablaServicios] READONLY 
AS
BEGIN
	
	
	DECLARE @inicial GEOGRAPHY
	SELECT @inicial = Geography::STPointFromText('POINT(' +
		CAST(@longitud AS VARCHAR(20)) +
		' ' + CAST(@latitud AS VARCHAR(20)) + ')' , 4326)

	SELECT @radio = ISNULL(@radio,1500)

	DECLARE @params INT
	SELECT @params = COUNT(*) FROM @tabla_servicios

	SELECT TOP 1 U.id_ubicacion AS id
		,U.nombre AS nombre
		,E.linea AS linea
		,U.ubicacion.Long AS longitud
		,U.ubicacion.Lat AS latitud
		,E.id_tipo AS tipo_estacion
		,T.tarifa AS tarifa
		,U.Ubicacion.STDistance(@inicial) AS distancia
	FROM Ubicaciones U
	INNER JOIN Estaciones E
		ON U.id_ubicacion = E.id_estacion
	INNER JOIN Tarifas T
		ON T.id_tipo = E.id_tipo
	WHERE @inicial.STBuffer(@radio).STIntersects(U.ubicacion) = 1
		-- LIMITANTES
		AND ( (@params = 0 OR E.id_tipo in (SELECT TipoServicio FROM @tabla_servicios))) 
		--AND ((E.id_tipo IN ('MTR','FRR','TLI','SU1','TCE')) OR (E.id_tipo = 'MBS' AND linea in ('1','2','3')))
		AND E.estatus = 'A'
	ORDER BY U.Ubicacion.STDistance(@inicial) 
	
END

GO
/****** Object:  StoredProcedure [dbo].[ObtieneTodasEstaciones]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Los Unmaucios
-- Create date: 3/NOV/2012
-- Description:	Obtiene todas las estaciones de la base
-- =============================================
CREATE PROCEDURE [dbo].[ObtieneTodasEstaciones]
	@tabla_servicios AS [dbo].[TablaServicios] READONLY 
AS
BEGIN

	DECLARE @params INT
	SELECT @params = COUNT(*) FROM @tabla_servicios

	SELECT U.id_ubicacion AS id
		,U.nombre AS nombre
		,E.linea AS linea
		,CAST(U.ubicacion.Long AS DECIMAL) AS longitud
		,CAST(U.ubicacion.Lat AS DECIMAL) AS latitud
		,E.id_tipo AS tipo_estacion
		,T.tarifa AS tarifa
	FROM Ubicaciones U
	INNER JOIN Estaciones E
		ON U.id_ubicacion = E.id_estacion
	INNER JOIN Tarifas T
		ON T.id_tipo = E.id_tipo
	WHERE
		(@params = 0 OR (E.id_tipo  in (SELECT TipoServicio FROM @tabla_servicios))) 
		--((E.id_tipo IN ('MTR','FRR','TLI','SU1','TCE')) OR (E.id_tipo = 'MBS' AND linea in ('1','2','3')))
		AND E.estatus = 'A'

END

GO
/****** Object:  StoredProcedure [dbo].[RecuperaLugares]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Los Unmaucios
-- Create date: 9 de noviembre 2012
-- Description:	Recupera lugares de la base de datos
-- =============================================
CREATE PROCEDURE [dbo].[RecuperaLugares]
	@part_nombre varchar(40)
AS
BEGIN

	SELECT 
		[id_lugar] AS id
		,[U].ubicacion.Lat AS latitud
		,[U].ubicacion.Long AS longitud
		,[U].nombre AS nombre
		,[L].[tipo]
		,[L].[detalles]
	FROM [dbo].[Lugares] [L]
		INNER JOIN [dbo].[Ubicaciones] [U]
		ON [L].id_lugar = [U].id_ubicacion
	WHERE [U].nombre LIKE (@part_nombre + '%')

END

GO
/****** Object:  StoredProcedure [dbo].[RecuperaTramos]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Los Unmaucios
-- Create date: 3/NOV/2012
-- Description:	Recupera todos los tramos asociados con una estacion
-- =============================================
CREATE PROCEDURE [dbo].[RecuperaTramos]
	@estacion char(8),
	@tabla_servicios AS [dbo].[TablaServicios] READONLY 
AS
BEGIN

	DECLARE @params INT
	SELECT @params = COUNT(*) FROM @tabla_servicios

	SELECT [id_estacion_origen]
      ,[id_estacion_destino]
      ,[distancia]
      ,[velocidad]
	FROM [Tramos] T
		INNER JOIN [Estaciones] E
		ON T.id_estacion_destino = E.id_estacion
	WHERE [id_estacion_origen] = @estacion
		AND (@params = 0 OR (E.id_tipo in (SELECT TipoServicio FROM @tabla_servicios))) 
		AND E.estatus = 'A'




END

GO
/****** Object:  Table [dbo].[Estaciones]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estaciones](
	[id_estacion] [char](8) NOT NULL,
	[id_tipo] [char](3) NOT NULL,
	[linea] [varchar](5) NULL,
	[estatus] [char](1) NULL,
 CONSTRAINT [PK_Estaciones] PRIMARY KEY NONCLUSTERED 
(
	[id_estacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Lugares]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Lugares](
	[id_lugar] [char](8) NOT NULL,
	[tipo] [char](5) NOT NULL,
	[detalles] [varchar](45) NULL,
 CONSTRAINT [PK_Lugares] PRIMARY KEY NONCLUSTERED 
(
	[id_lugar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tarifas]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tarifas](
	[id_tipo] [char](3) NOT NULL,
	[tarifa] [decimal](6, 2) NOT NULL,
	[tipo] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Tarifas] PRIMARY KEY NONCLUSTERED 
(
	[id_tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tramos]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tramos](
	[id_estacion_origen] [char](8) NOT NULL,
	[id_estacion_destino] [char](8) NOT NULL,
	[distancia] [decimal](6, 2) NOT NULL,
	[velocidad] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK_Tramos] PRIMARY KEY NONCLUSTERED 
(
	[id_estacion_origen] ASC,
	[id_estacion_destino] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ubicaciones]    Script Date: 11/10/2012 2:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ubicaciones](
	[id_ubicacion] [char](8) NOT NULL,
	[nombre] [varchar](45) NOT NULL,
	[ubicacion] [geography] NOT NULL,
 CONSTRAINT [PK_Ubicaciones] PRIMARY KEY NONCLUSTERED 
(
	[id_ubicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Estaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Estaciones1] FOREIGN KEY([id_estacion])
REFERENCES [dbo].[Ubicaciones] ([id_ubicacion])
GO
ALTER TABLE [dbo].[Estaciones] CHECK CONSTRAINT [FK_Estaciones1]
GO
ALTER TABLE [dbo].[Estaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Estaciones2] FOREIGN KEY([id_tipo])
REFERENCES [dbo].[Tarifas] ([id_tipo])
GO
ALTER TABLE [dbo].[Estaciones] CHECK CONSTRAINT [FK_Estaciones2]
GO
ALTER TABLE [dbo].[Lugares]  WITH NOCHECK ADD  CONSTRAINT [FK_Lugares1] FOREIGN KEY([id_lugar])
REFERENCES [dbo].[Ubicaciones] ([id_ubicacion])
GO
ALTER TABLE [dbo].[Lugares] CHECK CONSTRAINT [FK_Lugares1]
GO
ALTER TABLE [dbo].[Tramos]  WITH NOCHECK ADD  CONSTRAINT [FK_Tramos1] FOREIGN KEY([id_estacion_origen])
REFERENCES [dbo].[Estaciones] ([id_estacion])
GO
ALTER TABLE [dbo].[Tramos] CHECK CONSTRAINT [FK_Tramos1]
GO
ALTER TABLE [dbo].[Tramos]  WITH NOCHECK ADD  CONSTRAINT [FK_Tramos2] FOREIGN KEY([id_estacion_destino])
REFERENCES [dbo].[Estaciones] ([id_estacion])
GO
ALTER TABLE [dbo].[Tramos] CHECK CONSTRAINT [FK_Tramos2]
GO
USE [master]
GO
ALTER DATABASE [RutAppBd] SET  READ_WRITE 
GO

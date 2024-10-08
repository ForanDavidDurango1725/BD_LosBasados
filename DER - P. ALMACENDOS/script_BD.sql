USE [master]
GO
/****** Object:  Database [Bienestar]    Script Date: 18/05/2024 4:04:42 p. m. ******/
CREATE DATABASE [Bienestar]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bienestar', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Bienestar.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Bienestar_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Bienestar_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Bienestar] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bienestar].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bienestar] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bienestar] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bienestar] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bienestar] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bienestar] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bienestar] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bienestar] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bienestar] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bienestar] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bienestar] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bienestar] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bienestar] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bienestar] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bienestar] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bienestar] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bienestar] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bienestar] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bienestar] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bienestar] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bienestar] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bienestar] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bienestar] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bienestar] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Bienestar] SET  MULTI_USER 
GO
ALTER DATABASE [Bienestar] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bienestar] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bienestar] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bienestar] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bienestar] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Bienestar] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Bienestar] SET QUERY_STORE = ON
GO
ALTER DATABASE [Bienestar] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Bienestar]
GO
/****** Object:  Table [dbo].[Actividades]    Script Date: 18/05/2024 4:04:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actividades](
	[ActividadID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
	[Horario] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ActividadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inscripciones]    Script Date: 18/05/2024 4:04:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inscripciones](
	[InscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NULL,
	[ActividadID] [int] NULL,
	[FechaInscripcion] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InscripcionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstructorActividad]    Script Date: 18/05/2024 4:04:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstructorActividad](
	[InstructorID] [int] NOT NULL,
	[ActividadID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC,
	[ActividadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructores]    Script Date: 18/05/2024 4:04:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructores](
	[InstructorID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[Identificacion] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LugarActividad]    Script Date: 18/05/2024 4:04:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LugarActividad](
	[LugarID] [int] NOT NULL,
	[ActividadID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LugarID] ASC,
	[ActividadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lugares]    Script Date: 18/05/2024 4:04:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lugares](
	[LugarID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Direccion] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LugarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 18/05/2024 4:04:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[UsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[Carnet] [varchar](20) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[TipoUsuario] [varchar](10) NOT NULL,
	[Correo] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Carnet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inscripciones] ADD  DEFAULT (getdate()) FOR [FechaInscripcion]
GO
ALTER TABLE [dbo].[Inscripciones]  WITH CHECK ADD FOREIGN KEY([ActividadID])
REFERENCES [dbo].[Actividades] ([ActividadID])
GO
ALTER TABLE [dbo].[Inscripciones]  WITH CHECK ADD FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[InstructorActividad]  WITH CHECK ADD FOREIGN KEY([ActividadID])
REFERENCES [dbo].[Actividades] ([ActividadID])
GO
ALTER TABLE [dbo].[InstructorActividad]  WITH CHECK ADD FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructores] ([InstructorID])
GO
ALTER TABLE [dbo].[LugarActividad]  WITH CHECK ADD FOREIGN KEY([ActividadID])
REFERENCES [dbo].[Actividades] ([ActividadID])
GO
ALTER TABLE [dbo].[LugarActividad]  WITH CHECK ADD FOREIGN KEY([LugarID])
REFERENCES [dbo].[Lugares] ([LugarID])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD CHECK  (([TipoUsuario]='Profesor' OR [TipoUsuario]='Estudiante'))
GO
/****** Object:  StoredProcedure [dbo].[ActualizarUsuario]    Script Date: 18/05/2024 4:04:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarUsuario]
    @UsuarioID INT,
    @Carnet VARCHAR(20),
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @TipoUsuario VARCHAR(10),
    @Correo VARCHAR(50)
AS
BEGIN
    UPDATE Usuarios
    SET Carnet = @Carnet, Nombre = @Nombre, Apellido = @Apellido, TipoUsuario = @TipoUsuario, Correo = @Correo
    WHERE UsuarioID = @UsuarioID
END
GO
/****** Object:  StoredProcedure [dbo].[CrearUsuario]    Script Date: 18/05/2024 4:04:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearUsuario]
    @Carnet VARCHAR(20),
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @TipoUsuario VARCHAR(10),
    @Correo VARCHAR(50)
AS
BEGIN
    INSERT INTO Usuarios (Carnet, Nombre, Apellido, TipoUsuario, Correo)
    VALUES (@Carnet, @Nombre, @Apellido, @TipoUsuario, @Correo)
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarUsuario]    Script Date: 18/05/2024 4:04:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarUsuario]
    @UsuarioID INT
AS
BEGIN
    DELETE FROM Usuarios WHERE UsuarioID = @UsuarioID
END
GO
/****** Object:  StoredProcedure [dbo].[LeerUsuarios]    Script Date: 18/05/2024 4:04:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LeerUsuarios]
AS
BEGIN
    SELECT * FROM Usuarios
END
GO
USE [master]
GO
ALTER DATABASE [Bienestar] SET  READ_WRITE 
GO

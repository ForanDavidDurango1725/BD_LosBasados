--Esta función toma dos parámetros y devuelve una cadena que es la concatenación de ambos, 
--separados por un espacio. Es una función escalar porque devuelve un único valor por cada llamada.

CREATE FUNCTION dbo.FnObtenerNombreCompleto
(
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50)
)
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN (@Nombre + ' ' + @Apellido)
END
GO

--Esta función devuelve una tabla virtual que contiene las columnas Carnet, Nombre, Apellido 
--y Correo de todos los usuarios que coinciden con el @TipoUsuario proporcionado
CREATE FUNCTION dbo.FnUsuariosPorTipo
(
    @TipoUsuario NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT Carnet, Nombre, Apellido, Correo
    FROM Usuarios
    WHERE TipoUsuario = @TipoUsuario
)
GO


--Esta vista selecciona las columnas Carnet, Nombre, Apellido y Correo 
--de la tabla Usuarios donde la columna Activo es igual a 1 (verdadero)
CREATE VIEW dbo.VistaUsuariosActivos
AS
SELECT Carnet, Nombre, Apellido, Correo
FROM Usuarios
WHERE Activo = 1
GO


--Este trigger se ejecuta después de que se inserta una nueva fila en la tabla Usuarios
CREATE TRIGGER TrgAfterInsertUsuario
ON Usuarios
AFTER INSERT
AS
BEGIN
    INSERT INTO LogCambios(UsuarioID, TipoCambio, FechaCambio)
    SELECT i.UsuarioID, 'INSERT', GETDATE()
    FROM inserted i
END
GO

--este se activa después de que una fila existente en la tabla Usuarios es actualizada
CREATE TRIGGER TrgAfterUpdateUsuario
ON Usuarios
AFTER UPDATE
AS
BEGIN
    INSERT INTO LogCambios(UsuarioID, TipoCambio, FechaCambio)
    SELECT i.UsuarioID, 'UPDATE', GETDATE()
    FROM inserted i
END
GO

--Este trigger se dispara después de que una fila es eliminada de la tabla Usuarios. 
--Añade un registro en LogCambios con el UsuarioID de la fila eliminada, el tipo de cambio ('DELETE') y la fecha
CREATE TRIGGER TrgAfterDeleteUsuario
ON Usuarios
AFTER DELETE
AS
BEGIN
    INSERT INTO LogCambios(UsuarioID, TipoCambio, FechaCambio)
    SELECT d.UsuarioID, 'DELETE', GETDATE()
    FROM deleted d
END
GO


CREATE PROCEDURE InscribirUsuarioActividad
    @UsuarioID INT,
    @ActividadID INT,
    @FechaInscripcion DATE
AS
BEGIN
    INSERT INTO Inscripciones (UsuarioID, ActividadID, FechaInscripcion)
    VALUES (@UsuarioID, @ActividadID, @FechaInscripcion)
END
GO


-- Crear una nueva actividad
CREATE PROCEDURE CrearActividad
    @Nombre VARCHAR(50),
    @FechaInicio DATE,
    @FechaFin DATE,
    @Horario VARCHAR(50)
AS
BEGIN
    INSERT INTO Actividades (Nombre, FechaInicio, FechaFin, Horario)
    VALUES (@Nombre, @FechaInicio, @FechaFin, @Horario)
END
GO

-- Actualizar una actividad existente
CREATE PROCEDURE ActualizarActividad
    @ActividadID INT,
    @Nombre VARCHAR(50),
    @FechaInicio DATE,
    @FechaFin DATE,
    @Horario VARCHAR(50)
AS
BEGIN
    UPDATE Actividades
    SET Nombre = @Nombre, FechaInicio = @FechaInicio, FechaFin = @FechaFin, Horario = @Horario
    WHERE ActividadID = @ActividadID
END
GO

-- Eliminar una actividad
CREATE PROCEDURE EliminarActividad
    @ActividadID INT
AS
BEGIN
    DELETE FROM Actividades WHERE ActividadID = @ActividadID
END
GO

-- Leer todas las actividades disponibles
CREATE PROCEDURE LeerActividades
AS
BEGIN
    SELECT * FROM Actividades
END
GO

-- Inscribir un usuario en una actividad
CREATE PROCEDURE InscribirUsuarioActividad
    @UsuarioID INT,
    @ActividadID INT
AS
BEGIN
    INSERT INTO Inscripciones (UsuarioID, ActividadID, FechaInscripcion)
    VALUES (@UsuarioID, @ActividadID, GETDATE())
END
GO

-- Cancelar la inscripción de un usuario en una actividad
CREATE PROCEDURE CancelarInscripcion
    @InscripcionID INT
AS
BEGIN
    DELETE FROM Inscripciones WHERE InscripcionID = @InscripcionID
END
GO

-- Crear un nuevo instructor
CREATE PROCEDURE CrearInstructor
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Identificacion VARCHAR(20)
AS
BEGIN
    INSERT INTO Instructores (Nombre, Apellido, Identificacion)
    VALUES (@Nombre, @Apellido, @Identificacion)
END
GO

-- Actualizar la información de un instructor
CREATE PROCEDURE ActualizarInstructor
    @InstructorID INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Identificacion VARCHAR(20)
AS
BEGIN
    UPDATE Instructores
    SET Nombre = @Nombre, Apellido = @Apellido, Identificacion = @Identificacion
    WHERE InstructorID = @InstructorID
END
GO

-- Eliminar un instructor
CREATE PROCEDURE EliminarInstructor
    @InstructorID INT
AS
BEGIN
    DELETE FROM Instructores WHERE InstructorID = @InstructorID
END
GO

-- Leer todos los instructores
CREATE PROCEDURE LeerInstructores
AS
BEGIN
    SELECT * FROM Instructores
END
GO

-- Crear un nuevo lugar
CREATE PROCEDURE CrearLugar
    @Nombre VARCHAR(50),
    @Direccion VARCHAR(100)
AS
BEGIN
    INSERT INTO Lugares (Nombre, Direccion)
    VALUES (@Nombre, @Direccion)
END
GO

-- Actualizar la información de un lugar
CREATE PROCEDURE ActualizarLugar
    @LugarID INT,
    @Nombre VARCHAR(50),
    @Direccion VARCHAR(100)
AS
BEGIN
    UPDATE Lugares
    SET Nombre = @Nombre, Direccion = @Direccion
    WHERE LugarID = @LugarID
END
GO

-- Eliminar un lugar
CREATE PROCEDURE EliminarLugar
    @LugarID INT
AS
BEGIN
    DELETE FROM Lugares WHERE LugarID = @LugarID
END
GO

-- Leer todos los lugares disponibles
CREATE PROCEDURE LeerLugares
AS
BEGIN
    SELECT * FROM Lugares
END
GO
USE DB_SISTEMA_VENTAS

/*--------------------Creación de las tablas */--------------------
CREATE TABLE ROL(
IdRol INT PRIMARY KEY IDENTITY,
Descripcion VARCHAR(50),
FechaRegistro DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE PERMISO(
IdPermiso INT PRIMARY KEY IDENTITY,
IdRol INT REFERENCES ROL(IdRol),
NombreMenu VARCHAR(100),
FechaRegistro DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE PROVEEDOR(
IdProveedor INT PRIMARY KEY IDENTITY,
Documento VARCHAR(50),
RazonSocial VARCHAR(50),
Correo VARCHAR(50),
Telefono VARCHAR(50),
Estado BIT,
FechaRegistro DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE CLIENTE(
IdCliente INT PRIMARY KEY IDENTITY,
Documento VARCHAR(50),
NombreCompleto VARCHAR(50),
Correo VARCHAR(50),
Telefono VARCHAR(50),
Estado BIT,
FechaRegistro DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE USUARIO(
IdUsuario INT PRIMARY KEY IDENTITY,
Documento VARCHAR(50),
NombreCompleto VARCHAR(50),
Correo VARCHAR(50),
Clave VARCHAR(50),
IdRol INT REFERENCES ROL(IdRol),
Estado BIT,
FechaRegistro DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE CATEGORIA(
IdCategoria INT PRIMARY KEY IDENTITY,
Descripcion VARCHAR(100),
Estado BIT,
FechaRegistro DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE PRODUCTO(
IdProducto INT PRIMARY KEY IDENTITY,
Codigo VARCHAR(50),
Nombre VARCHAR(50),
Descripcion VARCHAR(50),
IdCategoria INT REFERENCES CATEGORIA(IdCategoria),
Stock INT not null default 0,
Precio_Compra DECIMAL(10,2) DEFAULT 0,
Precio_Venta DECIMAL(10,2) DEFAULT 0,
Estado BIT,
FechaRegistro DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE COMPRA(
IdCompra INT PRIMARY KEY IDENTITY,
IdUsuario INT REFERENCES USUARIO(IdUsuario),
IdProveedor INT REFERENCES PROVEEDOR(IdProveedor),
TipoDocumento VARCHAR(50),
NumeroDocumento VARCHAR(50),
MontoTotal DECIMAL(10,2),
FechaRegistro DATETIME DEFAULT GETDATE()
)
GO


CREATE TABLE DETALLE_COMPRA(
IdDetalle_Compra INT PRIMARY KEY IDENTITY,
IdCompra INT REFERENCES COMPRA(IdCompra),
IdProducto INT REFERENCES PRODUCTO(IdProducto),
Precio_Compra DECIMAL(10,2) default 0,
Precio_Venta DECIMAL(10,2) default 0,
Cantidad INT,
MontoTotal DECIMAL(10,2),
FechaRegistro DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE VENTA(
IdVenta INT PRIMARY KEY IDENTITY,
IdUsuario INT REFERENCES USUARIO(IdUsuario),
TipoDocumento VARCHAR(50),
NumeroDocumento VARCHAR(50),
DocumentoCliente VARCHAR(50),
NombreCliente VARCHAR(100),
MontoPago DECIMAL(10,2),
MontoCambio DECIMAL(10,2),
MontoTotal DECIMAL(10,2),
FechaRegistro DATETIME DEFAULT GETDATE()
)
GO


CREATE TABLE DETALLE_VENTA(
IdDetalleVenta INT PRIMARY KEY IDENTITY,
IdVenta INT REFERENCES VENTA(IdVenta),
IdProducto INT REFERENCES PRODUCTO(IdProducto),
Precio_Venta DECIMAL(10,2),
Cantidad INT,
SubTotal DECIMAL(10,2),
FechaRegistro DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE NEGOCIO(
IdNegocio INT PRIMARY KEY,
Nombre VARCHAR(60),
RUC VARCHAR(60),
Direccion VARCHAR(60),
Logo VARBINARY(max) NULL
)
GO



/*--------------------Procedimientos almacenados para CRUD Usuarios */--------------------

GO
--Procedimientp para registrar un Usuario--
ALTER PROCEDURE USP_REGISTRAR_USUARIO
		@Documento VARCHAR (50),
		@NombreCompleto VARCHAR(100),
		@Correo VARCHAR (100),
		@Clave VARCHAR (100),
		@IdRol INT,
		@Estado BIT,
		@IdUsuarioResultado INT OUTPUT,
		@Mensaje VARCHAR(500) OUTPUT

AS
BEGIN 
	SET @IdUsuarioResultado = 0
	SET @Mensaje = ''

	IF NOT EXISTS (SELECT * FROM USUARIO WHERE Documento = @Documento)
	BEGIN
		INSERT INTO USUARIO (Documento,NombreCompleto, Correo, Clave, IdRol, Estado)
		VALUES (@Documento, @NombreCompleto, @Correo, @Clave, @IdRol, @Estado)

		SET @IdUsuarioResultado = SCOPE_IDENTITY()
	END
	ELSE 
		SET @Mensaje = 'No se puede repetir el documento para mas de un usuario'
END
GO

---Procedimiento almacenado para actualizar un Usuario
ALTER PROCEDURE USP_ACTUALIZAR_USUARIO
		@IdUsuario INT,
		@Documento VARCHAR (50),
		@NombreCompleto VARCHAR(100),
		@Correo VARCHAR (100),
		@Clave VARCHAR (100),
		@IdRol INT,
		@Estado BIT,
		@Respuesta BIT OUTPUT,
		@Mensaje VARCHAR(500) OUTPUT

AS
BEGIN 
	SET @Respuesta = 0
	SET @Mensaje = ''

	IF NOT EXISTS (SELECT * FROM USUARIO WHERE Documento = @Documento AND IdUsuario != @IdUsuario)
		BEGIN
			UPDATE USUARIO SET
			Documento = @Documento,
			NombreCompleto = @NombreCompleto ,
			Correo = @Correo,
			Clave = @Clave,
			IdRol = @IdRol,
			Estado = @Estado

			WHERE IdUsuario = @IdUsuario

			SET @Respuesta = 1
		END
	ELSE 
		SET @Mensaje = 'No se puede repetir el documento para más de un usuario'
END
GO

---Procedimiento almacenado para eliminar un Usuario---
CREATE PROCEDURE USP_ELIMINAR_USUARIO
		@IdUsuario INT,
		@Respuesta BIT OUTPUT,
		@Mensaje VARCHAR(500) OUTPUT

AS
BEGIN 
	SET @Respuesta = 0
	SET @Mensaje = ''
	DECLARE @PasoReglas BIT = 1

	IF EXISTS(SELECT * FROM COMPRA C
			  INNER JOIN USUARIO U ON U.IdUsuario = C.IdUsuario
			  WHERE U.IdUsuario = @IdUsuario
	)
	BEGIN
		SET @PasoReglas = 0
		SET @Respuesta = 0
		SET @Mensaje = @Mensaje + 'No se puede eliminar porque el usuario se encuentra relacionado a una COMPRA\n'
	END


	IF EXISTS(SELECT * FROM VENTA V
			  INNER JOIN USUARIO U ON U.IdUsuario = V.IdUsuario
			  WHERE U.IdUsuario = @IdUsuario
	)
	BEGIN
		SET @PasoReglas = 0
		SET @Respuesta = 0
		SET @Mensaje = @Mensaje + 'No se puede eliminar porque el usuario se encuentra relacionado a una VENTA\n'
	END

	IF(@PasoReglas = 1)
	BEGIN
		DELETE FROM USUARIO WHERE IdUsuario = @IdUsuario
		SET @Respuesta = 1
	END
END
GO



/*--------------------Procedimientos almacenados para CRUD Categoria */--------------------

-- Procedimiento almacenado para guardar una nueva categoría
CREATE PROCEDURE USP_REGISTRAR_CATEGORIA
    @Descripcion varchar(50),
    @Estado BIT,
    @Resultado int OUTPUT, 
    @Mensaje varchar(500) OUTPUT 
AS
BEGIN
    SET @Resultado = 0
    IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion)
    BEGIN
        INSERT INTO CATEGORIA (Descripcion, Estado) VALUES (@Descripcion, @Estado)
        SET @Resultado = SCOPE_IDENTITY()
    END
    ELSE
    BEGIN
        SET @Mensaje = 'No se puede repetir la descripcion de una categoria'
    END
END
GO

---Procedimiento almacenado para actualizar Categoria---
CREATE PROCEDURE USP_ACTUALIZAR_CATEGORIA
		@IdCategoria int,
		@Descripcion varchar(50),
		@Estado BIT,
		@Resultado bit output, @Mensaje varchar(500) output

AS
BEGIN
		SET @Resultado = 1
	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion and IdCategoria != @IdCategoria)
	UPDATE CATEGORIA 
		SET Descripcion = @Descripcion,
			Estado = @Estado
		WHERE IdCategoria = @IdCategoria
	ELSE
BEGIN
		SET @Resultado = 0
		SET @Mensaje = 'No se puede repetir la descripcion de una categoria'
END
END
GO

--- Procedimiento almacenado para eliminar Categoria ---
CREATE PROCEDURE USP_ELIMINAR_CATEGORIA
    @IdCategoria INT,
    @Resultado BIT OUTPUT,
    @Mensaje VARCHAR(500) OUTPUT
AS
BEGIN
    SET @Resultado = 1

    IF NOT EXISTS (
        SELECT * 
        FROM CATEGORIA C
        INNER JOIN PRODUCTO P ON P.IdCategoria = C.IdCategoria
        WHERE C.IdCategoria = @IdCategoria
    )
    BEGIN
        DELETE TOP(1) FROM CATEGORIA WHERE IdCategoria = @IdCategoria
    END
    ELSE
    BEGIN
        SET @Resultado = 0
        SET @Mensaje = 'La categoria se encuentara relacionada a un producto'
    END
END
GO

/*--------------------Procedimientos almacenados para CRUD Productos */--------------------

--- Procedimiento almacenado para registrar un producto ---
CREATE PROCEDURE USP_REGISTRAR_PRODUCTO 
    @Codigo VARCHAR(20),
    @Nombre VARCHAR(30),
    @Descripcion VARCHAR(30),
    @IdCategoria INT,
    @Estado BIT,
    @Resultado INT OUTPUT,
    @Mensaje VARCHAR(500) OUTPUT
AS
BEGIN
    SET @Resultado = 0

    IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Codigo = @Codigo)
    BEGIN
        INSERT INTO PRODUCTO (Codigo, Nombre, Descripcion, IdCategoria, Estado) 
        VALUES (@Codigo, @Nombre, @Descripcion, @IdCategoria, @Estado) 

        SET @Resultado = SCOPE_IDENTITY()
    END
    ELSE
    BEGIN
        SET @Mensaje = 'Ya existe un producto con el mismo codigo'
    END
END
GO


---Procedimiento almacenado para actualizar un producto---

ALTER PROCEDURE USP_ACTUALIZAR_PRODUCTO 
			@IdProducto INT,
			@Codigo VARCHAR(20), 
			@Nombre VARCHAR(30),
			@IdCategoria INT, 
			@Resultado BIT OUTPUT,
			@Descripcion VARCHAR(30), 
			@Estado BIT,
			@Mensaje VARCHAR(500) OUTPUT

	AS
	BEGIN
		SET @Resultado = 1
			IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Codigo = @Codigo and IdProducto != @IdProducto)
		UPDATE PRODUCTO SET
			Codigo = @Codigo, 
			Nombre = @Nombre,
			Descripcion = @Descripcion, 
			IdCategoria = @IdCategoria,
			Estado = @Estado
		WHERE IdProducto = @IdProducto
			ELSE
	BEGIN
		SET @Resultado = 0
		SET @Mensaje = 'Ya existe un producto con el mismo codigo'
END
END
GO

---Procedimiento almacenado para eliminar un producto---

create PROC USP_ELIMINAR_PRODUCTO
		@IdProducto INT, 
		@Respuesta BIT OUTPUT,
		@Mensaje VARCHAR(500) OUTPUT

AS
	BEGIN
		SET @Respuesta = 0
		SET @Mensaje = ''
		DECLARE @PasoReglas BIT = 1
		IF EXISTS (SELECT * FROM DETALLE_COMPRA dc
		INNER JOIN PRODUCTO P ON p.IdProducto = dc.IdProducto
		WHERE p.IdProducto = @IdProducto)
	BEGIN
		SET @PasoReglas = 0
		SET @Respuesta = 0
		SET @Mensaje = @Mensaje + 'No se puede eliminar porque se encuentra relacionado a una COMPRA\n'
	END
		IF EXISTS (SELECT * FROM DETALLE_VENTA dv
		INNER JOIN PRODUCTO p ON p.IdProducto = dv.IdProducto
		WHERE p.IdProducto = @IdProducto)
BEGIN
		SET @PasoReglas = 0
		SET @Respuesta = 0
		SET @Mensaje = @Mensaje + 'No se puede eliminar porque se encuentra relacionado a una VENTA\n'
END
		IF (@PasoReglas = 1)
		BEGIN
		DELETE FROM PRODUCTO WHERE IdProducto = @IdProducto
		SET @Respuesta = 1
	END
END
GO

/*--------------------Procedimientos almacenados para CRUD Clientes */--------------------

--- Procedimiento almacenado para registrar un Cliente ---
CREATE PROCEDURE USP_REGISTRAR_CLIENTE 
    @Documento VARCHAR(50), 
    @NombreCompleto VARCHAR(50), 
    @Correo VARCHAR(50), 
    @Telefono VARCHAR(50), 
    @Resultado INT OUTPUT,
    @Mensaje VARCHAR(500) OUTPUT,
    @Estado BIT
AS
BEGIN
    SET @Resultado = 0

    IF NOT EXISTS (SELECT * FROM CLIENTE WHERE Documento = @Documento)
    BEGIN
        INSERT INTO CLIENTE (Documento, NombreCompleto, Correo, Telefono, Estado) 
        VALUES (@Documento, @NombreCompleto, @Correo, @Telefono, @Estado)

        SET @Resultado = SCOPE_IDENTITY()
    END
    ELSE
    BEGIN
        SET @Mensaje = 'El numero de documento ya existe'
    END
END
GO

--- Procedimiento almacenado para actualizar un Cliente ---
CREATE PROCEDURE USP_ACTUALIZAR_CLIENTE 
    @IdCliente INT,
    @Documento VARCHAR(50), 
    @NombreCompleto VARCHAR(50), 
    @Estado BIT,
    @Correo VARCHAR(50), 
    @Telefono VARCHAR(50),
    @Resultado BIT OUTPUT,
    @Mensaje VARCHAR(500) OUTPUT
AS
BEGIN
    SET @Resultado = 1

    IF NOT EXISTS (SELECT * FROM CLIENTE WHERE Documento = @Documento AND IdCliente != @IdCliente)
    BEGIN

        UPDATE CLIENTE SET
            Documento = @Documento,
            NombreCompleto = @NombreCompleto,
            Correo = @Correo, 
            Telefono = @Telefono,
            Estado = @Estado
        WHERE IdCliente = @IdCliente
    END
    ELSE
    BEGIN
        SET @Resultado = 0
        SET @Mensaje = 'El numero de documento ya existe'
    END
END
GO


/*--------------------Procedimientos almacenados para CRUD Proveedor */--------------------

--- Procedimiento almacenado para registrar un Proveedor ---
CREATE PROCEDURE USP_REGISTRAR_PROVEEDOR 
    @Documento VARCHAR(50), 
    @RazonSocial VARCHAR(50), 
    @Correo VARCHAR(50), 
    @Telefono VARCHAR(50), 
    @Resultado INT OUTPUT,
    @Estado BIT,
    @Mensaje VARCHAR(500) OUTPUT
AS
BEGIN

    SET @Resultado = 0

    IF NOT EXISTS (SELECT * FROM PROVEEDOR WHERE Documento = @Documento)
    BEGIN

        INSERT INTO PROVEEDOR (Documento, RazonSocial, Correo, Telefono, Estado) 
        VALUES (@Documento, @RazonSocial, @Correo, @Telefono, @Estado)

        SET @Resultado = SCOPE_IDENTITY()
    END
    ELSE
    BEGIN
        SET @Mensaje = 'El numero de documento ya existe'
    END
END
GO


--- Procedimiento almacenado para actualizar un Proveedor ---
CREATE PROCEDURE USP_ACTUALIZAR_PROVEEDOR
    @IdProvedor INT,
    @Documento VARCHAR(50),
    @RazonSocial VARCHAR(50),
    @Correo VARCHAR(50),
    @Telefono VARCHAR(50),
    @Estado BIT,
    @Resultado BIT OUTPUT,
    @Mensaje VARCHAR(500) OUTPUT
AS
BEGIN

    SET @Resultado = 1

    IF NOT EXISTS (SELECT * FROM PROVEEDOR WHERE Documento = @Documento AND IdProveedor != @IdProvedor)
    BEGIN

        UPDATE PROVEEDOR SET
            Documento = @Documento,
            RazonSocial = @RazonSocial,
            Correo = @Correo,
            Telefono = @Telefono,
            Estado = @Estado
        WHERE IdProveedor = @IdProvedor
    END
    ELSE
    BEGIN

        SET @Resultado = 0
        SET @Mensaje = 'El numero de documento ya existe'
    END
END
GO


--- Procedimiento almacenado para eliminar un Proveedor ---
CREATE PROCEDURE USP_ELIMINAR_PROVEEDOR 
    @IdProveedor INT,
    @Resultado BIT OUTPUT,
    @Mensaje VARCHAR(500) OUTPUT
AS
BEGIN
    SET @Resultado = 1

    IF NOT EXISTS (
        SELECT * 
        FROM PROVEEDOR P
        INNER JOIN COMPRA C ON P.IdProveedor = C.IdProveedor
        WHERE P.IdProveedor = @IdProveedor
    )
    BEGIN
        DELETE TOP (1) FROM PROVEEDOR WHERE IdProveedor = @IdProveedor
    END
    ELSE
    BEGIN
        SET @Resultado = 0
        SET @Mensaje = 'El proveedor se encuentara relacionado a una compra'
    END
END
GO

 

/*--------------------Procedimientos almacenados para registrar Compras */--------------------

CREATE TYPE [dbo]. [EDetalle_Compra] AS TABLE(
	[IdProducto] INT NULL,
	[PrecioCompra] DECIMAL (18,2)NULL,
	[PrecioVenta] DECIMAL (18,2) NULL,
	[Cantidad] INT NULL,
	[MontoTotal] DECIMAL (18,2) NULL
)
GO

-----Procedimiento almacenado para registrar compras-----
CREATE PROCEDURE USP_REGISTRAR_COMPRA
	@IdUsuario INT,
	@IdProveedor INT,
	@TipoDocumento VARCHAR (500),
	@NumeroDocumento VARCHAR (500),
	@MontoTotal DECIMAL (18,2),
	@DetalleCompra [EDetalle_Compra] READONLY,
	@Resultado BIT OUTPUT,
	@Mensaje VARCHAR (500) OUTPUT
AS
BEGIN
	BEGIN TRY
		DECLARE @IdCompra INT = 0
		SET @Resultado = 1
		SET @Mensaje = ''

		BEGIN TRANSACTION Registro

		INSERT INTO COMPRA(IdUsuario,IdProveedor, TipoDocumento, NumeroDocumento, MontoTotal)
				VALUES(@IdUsuario, @IdProveedor, @TipoDocumento, @NumeroDocumento, @MontoTotal)
		SET @IdCompra = SCOPE_IDENTITY()

		INSERT INTO DETALLE_COMPRA (IdCompra, IdProducto,Precio_Compra,Precio_Venta,Cantidad,MontoTotal)
		SELECT @IdCompra, IdProducto, PrecioCompra, PrecioVenta, Cantidad, MontoTotal FROM @DetalleCompra

		UPDATE p SET p.Stock = p.Stock + dc.Cantidad,
		p.Precio_Compra = dc.PrecioCompra,
		p.Precio_Venta = dc.PrecioVenta
		FROM PRODUCTO p
		INNER JOIN @DetalleCompra dc ON dc.IdProducto = p.IdProducto

		COMMIT TRANSACTION Registro
	END TRY

	BEGIN CATCH
		SET @Resultado = 0
		SET @Mensaje = ERROR_MESSAGE()
		ROLLBACK TRANSACTION Registro
	END CATCH
END

GO

/*--------------------Procedimientos almacenados para registrar ventas */--------------------

CREATE TYPE [dbo]. [EDetalle_Venta] AS TABLE(
	[IdProducto] INT NULL,
	[PrecioVenta] DECIMAL (18,2) NULL,
	[Cantidad] INT NULL,
	[SubTotal] DECIMAL (18,2) NULL
)
GO

CREATE PROCEDURE USP_REGISTRAR_VENTA
	@IdUsuario INT,
	@TipoDocumento VARCHAR (500),
	@NumeroDocumento VARCHAR (500),
	@DocumentoCliente VARCHAR (500),
	@NombreCliente VARCHAR (500),
	@MontoPago DECIMAL (18,2),
	@MontoCambio DECIMAL (18,2),
	@MontoTotal DECIMAL (18,2),
	@DetalleVenta [EDetalle_Venta] READONLY,
	@Resultado BIT OUTPUT,
	@Mensaje VARCHAR (500) OUTPUT
AS
BEGIN
	
	BEGIN TRY

		DECLARE @IdVenta INT = 0
		SET @Resultado = 1
		SET @Mensaje = ''

		BEGIN TRANSACTION Registro

		INSERT INTO VENTA (IdUsuario,TipoDocumento,NumeroDocumento,DocumentoCliente,NombreCliente,MontoPago,MontoCambio, MontoTotal)
		VALUES(@IdUsuario,@TipoDocumento,@NumeroDocumento,@DocumentoCliente,@NombreCliente,@MontoPago,@MontoCambio,@MontoTotal)

		SET @IdVenta = SCOPE_IDENTITY()

		INSERT INTO DETALLE_VENTA (IdVenta,IdProducto,Precio_Venta,Cantidad,SubTotal)
		SELECT @IdVenta, IdProducto, PrecioVenta, Cantidad, SubTotal FROM @DetalleVenta

		COMMIT TRANSACTION Registro
	END TRY

	BEGIN CATCH 
		SET @Resultado = 0
		SET @Mensaje = ERROR_MESSAGE()
		ROLLBACK TRANSACTION Registro
	END CATCH
END
GO

/*--------------------Procedimientos almacenados para Reportes de compras y ventas */--------------------
ALTER PROCEDURE USP_REPORTE_COMPRA
	@FechaInicio VARCHAR (10),
	@FechaFin VARCHAR (10),
	@IdProveedor INT
AS
BEGIN
	SET DATEFORMAT dmy;
	SELECT 
	CONVERT (CHAR(10), c.FechaRegistro,103)[FechaRegistro], c.TipoDocumento,c.NumeroDocumento,c.MontoTotal,
	u.NombreCompleto[UsuarioRegistro],
	pr.Documento[DocumentoProveedor], pr.RazonSocial,
	p.Codigo[CodigoProducto],p.Nombre[NombreProducto], ca.Descripcion[Categoria], dc.Precio_Compra,dc.Precio_Venta,dc.cantidad,dc.MontoTotal[SubTotal]
	FROM COMPRA c
	INNER JOIN USUARIO u ON  u.IdUsuario = c.IdUsuario
	INNER JOIN PROVEEDOR pr on pr.IdProveedor = c.IdProveedor
	INNER JOIN DETALLE_COMPRA dc ON dc.IdCompra = c.IdCompra
	INNER JOIN PRODUCTO p ON p.IdProducto = dc.IdProducto
	INNER JOIN CATEGORIA ca ON ca.IdCategoria = p.IdCategoria
	WHERE CONVERT(date,c.FechaRegistro) BETWEEN @FechaInicio AND @FechaFin
	AND pr.IdProveedor = IIF(@IdProveedor=0,pr.IdProveedor,@IdProveedor)
END
GO

CREATE PROC sp_ReporteVentas 
	@fechainicio varchar(10), 
	@fechafin varchar(10)
AS
BEGIN
	SET DATEFORMAT dmy;
	SELECT
	CONVERT(char(10), v.FechaRegistro, 103)[FechaRegistro], v.TipoDocumento, v.NumeroDocumento, v.MontoTotal,
	u.NombreCompleto[UsuarioRegistro],
	v.DocumentoCliente, v.NombreCliente,
	p.Codigo[CodigoProducto], p.Nombre[NombreProducto], ca.Descripcion[Categoria], dv.Precio_Venta, dv.Cantidad, dv.SubTotal 
	FROM VENTA v
	INNER JOIN USUARIO u ON u.IdUsuario = v.IdUsuario
	INNER JOIN DETALLE_VENTA dv ON dv.IdVenta = v.IdVenta
	INNER JOIN PRODUCTO p ON p.IdProducto = dv.IdProducto 
	INNER JOIN CATEGORIA ca ON ca.IdCategoria = p.IdCategoria
	WHERE CONVERT (date, v. FechaRegistro) BETWEEN @fechainicio AND @fechafin
END
GO



/*--------------------Funciones, vistas y trigger */--------------------

---función para obtener el total de ventas de un producto específico---
CREATE FUNCTION dbo.fn_TotalVentasProducto(@IdProducto INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalVentas DECIMAL(10,2)

    SELECT @TotalVentas = SUM(SubTotal)
    FROM DETALLE_VENTA
    WHERE IdProducto = @IdProducto

    RETURN @TotalVentas
END
GO

--vista que muestra la información detallada de las ventas---
CREATE VIEW vw_DetalleVentas
AS
SELECT V.IdVenta, V.FechaRegistro, U.NombreCompleto AS NombreUsuario, 
       C.NombreCompleto AS NombreCliente, P.Nombre AS NombreProducto, 
       DV.Precio_Venta, DV.Cantidad, DV.SubTotal
FROM VENTA V
JOIN USUARIO U ON V.IdUsuario = U.IdUsuario
JOIN DETALLE_VENTA DV ON V.IdVenta = DV.IdVenta
JOIN PRODUCTO P ON DV.IdProducto = P.IdProducto
JOIN CLIENTE C ON V.DocumentoCliente = C.Documento
GO


---trigger que actualiza el stock de un producto después de una venta---
CREATE TRIGGER tr_ActualizarStockProducto
ON DETALLE_VENTA
AFTER INSERT
AS
BEGIN
    DECLARE @IdProducto INT, @Cantidad INT

    SELECT @IdProducto = IdProducto, @Cantidad = Cantidad
    FROM INSERTED

    UPDATE PRODUCTO
    SET Stock = Stock - @Cantidad
    WHERE IdProducto = @IdProducto
END
GO


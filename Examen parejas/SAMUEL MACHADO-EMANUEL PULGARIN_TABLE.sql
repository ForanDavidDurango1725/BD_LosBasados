USE GestionRestaurantes
GO

CREATE TABLE Restaurantes (
    Id_Restaurante INT not null, 
    Nombre VARCHAR(100) NOT NULL, 
    Dirección VARCHAR(50) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL,
    País VARCHAR(50) NOT NULL,
    Teléfono VARCHAR(15) NOT NULL,
    HorarioApertura TIME NOT NULL,
    HorarioCierre TIME NOT NULL,
    Imagen IMAGE
);
GO

CREATE TABLE Cocinas (
    Id_Cocina INT not null,
    Nombre VARCHAR(50) NOT NULL,
    Descripción VARCHAR(200) NOT NULL,
	id_restaurante varchar(100) not null
);
GO

CREATE TABLE Menús (
    Id_Menu INT not null,
    Id_Restaurante INT NOT NULL,
    Id_Cocina INT NOT NULL,
	nombre varchar(100) not null,
);

GO

CREATE TABLE Plato (
    Id_Plato INT not null,
    Nombre VARCHAR(50) NOT NULL,
    Descripción VARCHAR(200) NOT NULL,
    Precio int NOT NULL,
    Id_Menu INT NOT NULL,
	id_restaurante int null,
);
GO

CREATE TABLE Clientes (
    Id_Cliente INT not null,
    Nombre VARCHAR(50) NOT NULL,
    Dirección VARCHAR(50) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL,
    País VARCHAR(50) NOT NULL,
    Teléfono VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Pedidos (
    Id_Pedido INT not null,
	Id_Restaurante INT NOT NULL,
    Id_Cliente INT NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Tipo_pedido VARCHAR(50) NOT NULL,
    Estado VARCHAR(50) NOT NULL,
    Precio_Total int NOT NULL    
);
GO

CREATE TABLE Reservacion (
    Id_reserva INT not null,
	Id_Restaurante INT NOT NULL,
    Id_Cliente INT NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Número_Personas INT NOT NULL
);
GO

CREATE TABLE PlatosVendidos (
    Id_Venta INT not null,
    Id_Plato INT NOT NULL,
	id_pedido int not null,
    Fecha DATE NOT NULL,
    Cantidad INT NOT NULL,
);
go
CREATE TABLE platos_menus(
id_platos_menus int not null,
id_plato int not null,
id_menus int not null,
);

go
CREATE TABLE reservacion_clientes(
id_reservacion_clientes int not null,
id_reservacion int not null,
id_clientes int not null,
);

go
CREATE TABLE restaurantes_pedidos (
id_restaurantes_pedidos int not null,
id_restaurantes int not null,
id_pedidos int not null,
);


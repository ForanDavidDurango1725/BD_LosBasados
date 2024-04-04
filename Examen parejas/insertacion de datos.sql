use gestionRestaurantes
go

-- Insertando datos en la tabla Restaurantes
INSERT INTO Restaurantes(Id_Restaurante, Nombre, Dirección, Ciudad, País, Teléfono, HorarioApertura, HorarioCierre, Imagen)
VALUES (1, 'La Marquesina', 'Calle 55 #44', 'Medellín', 'Colombia', '3134268251', '08:00:00', '22:00:00', NULL),
       (2, 'La Fogata Bendita', 'Carrera 39', 'Medellín', 'Colombia', '3240934321', '06:00:00', '22:00:00', NULL),
       (3, 'Los Sabores del Valle', 'Carrera 25 #67', 'Cali', 'Colombia', '3102457890', '09:00:00', '23:00:00', NULL),
       (4, 'La Trattoria Italiana', 'Carrera 17 #34', 'Bogotá', 'Colombia', '3109876543', '09:00:00', '22:00:00', NULL),
       (5, 'El Fogón Paisa', 'Avenida 15 #33', 'Bogotá', 'Colombia', '3174321098', '08:30:00', '22:30:00', NULL);
GO

-- Insertando datos en la tabla Cocinas
INSERT INTO Cocinas(Id_Cocina, Nombre, Descripción, id_restaurante)
VALUES (1, 'Colombiana', 'Cocina con pasta, pizza, hamburguesas, sandwich, comida vegana y más', 1),
       (2, 'Colombiana de Mariscos', 'Cocina con comida de mar, sushi, bebidas naturales y más', 2),
       (3, 'colombiana', 'Los Sabores del Valle ofrece una amplia variedad de platos regionales.', 3),
       (4, 'Italiana', 'La Trattoria Italiana ofrece auténtica comida italiana, incluyendo pastas frescas, pizzas al horno de leña y antipastos,', 4),
       (5, 'Colombiana', 'El Fogón Paisa es conocido por su auténtica cocina colombiana, ofreciendo una amplia variedad de platos tradicionales que incluyen bandejas paisas.', 5);
GO


INSERT INTO Menús(Id_Menu, Id_Restaurante, Id_Cocina, nombre) 
VALUES 
(1, 1, 1, 'Menú La Marquesina'),
(2, 2, 2, 'Menú La Fogata Bendita'),
(3, 3, 3, 'Menú Los Sabores del Valle'),
(4, 4, 4, 'La Trattoria italiana'),
(5, 5, 5, 'Menú El Fogón Paisa');
GO

-- Insertando datos en la tabla Platos
INSERT INTO Platos(Id_Plato, Nombre, Descripción, Precio, Id_Menu,id_restaurante) 
VALUES 

(1, 'Hamburguesa', 'Hamburguesa con doble carne, queso, lechuga, tomate, salsa de la casa, ensalada', 29000, 1,1),
(2, 'Tacos al Pastor', 'Tacos con carne de cerdo, piña y cilantro', 7000, 2,2),
(3, 'Chuleta al Ají Cali', 'Chuleta de cerdo acompañada de salsa de ají picante, servida con patacones y ensalada fresca.', 18000, 3, 3),
(4, 'Bandeja Paisa Cali', 'Plato tradicional colombiano con frijoles, arroz, carne, huevo y aguacate, preparado al estilo caleño.', 25000, 3, 3),
(5, 'Pizza Margherita', 'Pizza con tomate, queso mozzarella y albahaca', 30000, 4,4),
(6, 'Pasta Carbonara', 'Pasta con salsa de queso y panceta, salsa boloñesa, queso mozzarella', 15000, 4,4),
(7, 'Enchiladas', 'Tortillas rellenas con pollo y salsa verde', 10000, 5,5);

GO


INSERT INTO Clientes(Id_Cliente, Nombre, Dirección, Ciudad, País, Teléfono, Email) 
VALUES (1, 'Juan', 'Calle 456', 'Cali', 'Colombia', '0987654321', 'Juan@gmail.com'),
       (2, 'Manuel', 'Avenida 789', 'Medellín', 'Colombia', '324245232', 'Manuel@gmail.com'),
       (3, 'Karen', 'Bulevar 012', 'Venecia', 'Italia', '6677889900', 'Karen@hotmail.com'),
       (4, 'Lina', 'Carrera 89 #33', 'New York', 'EEUU', '1973622454', 'Lina@gmail.com'),
       (5, 'Mario', 'Avenida 69', 'Paris', 'Francia', '234566442', 'Mario@outlook.com'),
       (6, 'Laura', 'Calle 123', 'Bogotá', 'Colombia', '1234567890', 'Laura@gmail.com'),
       (7, 'Carlos', 'Avenida 456', 'Barcelona', 'España', '0987654321', 'Carlos@hotmail.com'),
       (8, 'Sofía', 'Bulevar 789', 'Roma', 'Italia', '1122334455', 'Sofia@gmail.com'),
       (9, 'Pedro', 'Carrera 012', 'Los Angeles', 'EEUU', '2233445566', 'Pedro@outlook.com'),
       (10, 'Ana', 'Avenida 345', 'Londres', 'Reino Unido', '3344556677', 'Ana@yahoo.com');
GO


INSERT INTO Pedidos(Id_Pedido, Fecha, Hora, Tipo_pedido, Estado, Precio_Total, Id_Restaurante, Id_Cliente) 
VALUES (1, '2024-04-02', '13:00:00', 'Para llevar', 'En preparación', 25000, 1, 1),
       (2, '2024-04-03', '14:00:00', 'Entrega a domicilio', 'Enviado', 35000, 2, 2),
       (3, '2024-04-04', '15:00:00', 'Para llevar', 'Entregado', 50000, 4, 3),
       (4, '2024-04-05', '06:30:00', 'A la mesa', 'En preparación', 40000, 3, 5),
       (5, '2024-04-05', '11:40:00', 'Entrega a domicilio', 'Enviado', 45000, 5, 4),
       (6, '2024-07-05', '05:40:00', 'Entrega a domicilio', 'Enviado', 45000, 5, 2);
GO

INSERT INTO Reservacion(Id_reserva, Fecha, Hora, Número_Personas, Id_Restaurante, Id_Cliente) 
VALUES (1, '2024-05-05', '20:00:00', 5, 1, 1),
       (2, '2024-05-06', '21:00:00', 3, 2, 2),
       (3, '2024-05-07', '22:00:00', 4, 5, 3),
       (4, '2024-05-07', '10:30:00', 6, 4, 4),
       (5, '2024-04-08', '23:00:00', 2, 5, 10);
GO


INSERT INTO PlatosVendidos(Id_Venta, Id_Plato, Fecha, Cantidad,id_pedido) 
VALUES (1, 1, '2024-04-02', 5,1),
       (2, 2, '2024-04-03', 3,2),  
       (3, 3, '2024-04-04', 4,3),  
       (4, 4, '2024-04-05', 6,4),  
       (5, 5, '2024-04-06', 2,5), 
       (6, 6, '2024-04-07', 7,6);
       
GO

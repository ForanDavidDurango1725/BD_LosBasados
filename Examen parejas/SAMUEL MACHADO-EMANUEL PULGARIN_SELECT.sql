USE GestionRestaurantes
go

SELECT DISTINCT Nombre
FROM Restaurantes
WHERE Id_Restaurante IN (SELECT id_restaurante FROM Cocinas WHERE Nombre = 'Italiana');


go
WITH PlatosPopulares AS (
    SELECT 
        ROW_NUMBER() OVER (PARTITION BY r.Nombre ORDER BY COUNT(*) DESC) AS rn,
        r.Nombre AS Restaurante,
        p.Nombre AS Plato,
        COUNT(*) AS TotalPedidos
    FROM Pedidos ped
    JOIN PlatosVendidos pv ON ped.Id_Pedido = pv.id_pedido
    JOIN Platos p ON pv.Id_Plato = p.Id_Plato
    JOIN Restaurantes r ON ped.Id_Restaurante = r.Id_Restaurante
    GROUP BY r.Nombre, p.Nombre
)
SELECT Restaurante, Plato
FROM PlatosPopulares
WHERE rn = 1;


go
SELECT 
    r.Nombre AS Restaurante,
    COUNT(*) AS TotalPedidos
FROM Pedidos ped
JOIN Restaurantes r ON ped.Id_Restaurante = r.Id_Restaurante
GROUP BY r.Nombre;


go
SELECT 
    Fecha,
    COUNT(*) AS TotalReservas
FROM Reservacion
WHERE Fecha = '2024-05-07' 
GROUP BY Fecha;


go
SELECT DISTINCT
    r.Nombre AS Restaurante,
    c.Nombre AS Cocina,
    m.nombre AS Menu,
    p.Nombre AS Plato
FROM Restaurantes r
JOIN Cocinas c ON r.Id_Restaurante = c.id_restaurante
JOIN Menús m ON r.Id_Restaurante = m.Id_Restaurante
JOIN Platos p ON m.Id_Menu = p.Id_Menu;


go
SELECT DISTINCT
    p.Id_Pedido,
    p.Fecha,
    p.Hora,
    p.Tipo_pedido,
    p.Estado,
    p.Precio_Total,
    r.Nombre AS Restaurante,
    c.Nombre AS Cliente
FROM Pedidos p
JOIN Restaurantes r ON p.Id_Restaurante = r.Id_Restaurante
JOIN Clientes c ON p.Id_Cliente = c.Id_Cliente;


go
SELECT DISTINCT
    r.Id_reserva,
    r.Fecha,
    r.Hora,
    r.Número_Personas,
    r.Id_Restaurante,
    r.Id_Cliente,
    c.Nombre AS Cliente,
    rest.Nombre AS Restaurante
FROM Reservacion r
JOIN Clientes c ON r.Id_Cliente = c.Id_Cliente
JOIN Restaurantes rest ON r.Id_Restaurante = rest.Id_Restaurante;

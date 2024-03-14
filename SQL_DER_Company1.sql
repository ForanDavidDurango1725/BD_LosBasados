CREATE DATABASE COMPANY

GO

USE COMPANY
GO

CREATE TABLE Empleado (
    ID_empleado INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Fecha_de_nacimiento DATE,
    Dirección VARCHAR(50)
);

GO

CREATE TABLE Departamento (
    ID_departamento INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Ubicación VARCHAR(50)
);

GO

CREATE TABLE Proyecto (
    ID_proyecto INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Fecha_inicio DATE,
    Fecha_fin DATE
);

GO

CREATE TABLE Habilidad (
    ID_habilidad INT PRIMARY KEY,
    Nombre VARCHAR(50)
);

GO

CREATE TABLE Trabaja_en (
    ID_empleado INT,
    ID_departamento INT,
    Fecha_inicio DATE,
    Fecha_fin DATE,
    PRIMARY KEY (ID_empleado, ID_departamento),
    FOREIGN KEY (ID_empleado) REFERENCES Empleado(ID_empleado),
    FOREIGN KEY (ID_departamento) REFERENCES Departamento(ID_departamento)
);

GO

CREATE TABLE Asignado_a (
    ID_empleado INT,
    ID_proyecto INT,
    Fecha_asignación DATE,
    PRIMARY KEY (ID_empleado, ID_proyecto),
    FOREIGN KEY (ID_empleado) REFERENCES Empleado(ID_empleado),
    FOREIGN KEY (ID_proyecto) REFERENCES Proyecto(ID_proyecto)
);

GO

CREATE TABLE Posee (
    ID_empleado INT,
    ID_habilidad INT,
    Nivel INT,
    PRIMARY KEY (ID_empleado, ID_habilidad),
    FOREIGN KEY (ID_empleado) REFERENCES Empleado(ID_empleado),
    FOREIGN KEY (ID_habilidad) REFERENCES Habilidad(ID_habilidad)
);

GO

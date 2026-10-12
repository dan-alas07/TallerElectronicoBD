CREATE DATABASE TallerElectronico;
GO

USE TallerElectronico;
GO

-- Estado para los Roles
CREATE TABLE EstadoRol (
    EstadoRolId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

-- Estado para los Empleados
CREATE TABLE EstadoEmpleado (
    EstadoEmpleadoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

-- Estado para la cuenta de Usuario
CREATE TABLE EstadoUsuario (
    EstadoUsuarioId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

-- Estado para los Equipos
CREATE TABLE EstadoEquipo (
    EstadoEquipoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

-- Estado para los Repuestos
CREATE TABLE EstadoRepuesto (
    EstadoRepuestoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

-- Estado para los Clientes
CREATE TABLE EstadoCliente (
    EstadoClienteId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

-- Tipos de Equipo (Categorías)
CREATE TABLE TipoEquipo (
    TipoEquipoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

-- Marca
CREATE TABLE Marca (
    MarcaId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

-- Tabla Role
CREATE TABLE Rol (
    RolId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Descripcion VARCHAR(250) NULL,
    EstadoRolId INT NOT NULL,
    FOREIGN KEY (EstadoRolId) REFERENCES EstadoRol(EstadoRolId)
);

-- Tabla Empleado
CREATE TABLE Empleado (
    EmpleadoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DUI VARCHAR(10) UNIQUE NOT NULL,
    Telefono VARCHAR(9) NULL,
    Correo VARCHAR(100) UNIQUE NOT NULL,
    EstadoEmpleadoId INT NOT NULL,
    FechaContratacion DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (EstadoEmpleadoId) REFERENCES EstadoEmpleado(EstadoEmpleadoId)
);

-- Tabla Usuario
CREATE TABLE Usuario (
    UsuarioId INT PRIMARY KEY IDENTITY,
    EmpleadoId INT UNIQUE NOT NULL,
    Nombre VARCHAR(50) UNIQUE NOT NULL,
    Clave VARCHAR(256) NOT NULL,
    RolId INT NOT NULL,
    EstadoUsuarioId INT NOT NULL,
    FOREIGN KEY (EmpleadoId) REFERENCES Empleado(EmpleadoId),
    FOREIGN KEY (RolId) REFERENCES Rol(RolId),
    FOREIGN KEY (EstadoUsuarioId) REFERENCES EstadoUsuario(EstadoUsuarioId)
);

-- Tabla Cliente
CREATE TABLE Cliente (
    ClienteId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    DUI VARCHAR(10) UNIQUE NULL,
    Telefono VARCHAR(15) NOT NULL,
    Correo VARCHAR(100) NULL,
    FechaRegistro DATETIME NOT NULL DEFAULT GETDATE(),
    EstadoClienteId INT NOT NULL DEFAULT 1,

    FOREIGN KEY (EstadoClienteId) REFERENCES EstadoCliente(EstadoClienteId)
);

-- Tabla Equipo
CREATE TABLE Equipo (
    EquipoId INT PRIMARY KEY IDENTITY,
    CodigoSeguimiento VARCHAR(20) UNIQUE NOT NULL,
    TipoEquipoId INT NOT NULL,
    MarcaId INT NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    DiagnosticoInicial VARCHAR(400) NOT NULL,
    Observaciones VARCHAR(300) NULL,
    EstadoEquipoId INT NOT NULL,
    FechaIngreso DATETIME DEFAULT GETDATE() NOT NULL,
    FechaEntrega DATETIME NULL,
    ClienteId INT NOT NULL,
    TecnicoAsignadoId INT NULL, 
    FOREIGN KEY (TipoEquipoId) REFERENCES TipoEquipo(TipoEquipoId),
    FOREIGN KEY (MarcaId) REFERENCES Marca(MarcaId),
    FOREIGN KEY (EstadoEquipoId) REFERENCES EstadoEquipo(EstadoEquipoId),
    FOREIGN KEY (ClienteId) REFERENCES Cliente(ClienteId),
    FOREIGN KEY (TecnicoAsignadoId) REFERENCES Empleado(EmpleadoId)
);

-- Tabla Repuesto
CREATE TABLE Repuesto (
    RepuestoId INT PRIMARY KEY IDENTITY,
    Codigo VARCHAR(50) UNIQUE NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(250) NULL,
    CantidadStock INT NOT NULL CHECK(CantidadStock > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL CHECK(PrecioUnitario > 0.00),
    EstadoRepuestoId INT NOT NULL,
    FOREIGN KEY (EstadoRepuestoId) REFERENCES EstadoRepuesto(EstadoRepuestoId)
);

-- Tabla DetalleRepuestoEquipo
CREATE TABLE DetalleRepuestoEquipo (
    DetalleId INT PRIMARY KEY IDENTITY,
    EquipoId INT NOT NULL,
    RepuestoId INT NOT NULL,
    CantidadUtilizada INT NOT NULL CHECK (CantidadUtilizada > 0),
    PrecioAplicado DECIMAL(10,2) NOT NULL,
    FechaUso DATETIME DEFAULT GETDATE() NOT NULL,
    FOREIGN KEY (EquipoId) REFERENCES Equipo(EquipoId),
    FOREIGN KEY (RepuestoId) REFERENCES Repuesto(RepuestoId)
);
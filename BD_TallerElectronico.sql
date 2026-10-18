CREATE DATABASE TallerElectronico;
GO

USE TallerElectronico;
GO

CREATE TABLE EstadoReparacion (
    EstadoReparacionId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Estado CHAR NOT NULL DEFAULT 'A' CHECK (Estado IN ('A', 'I')) -- A = Activo, I = Inactivo
);

CREATE TABLE TipoEquipo (
    TipoEquipoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Estado CHAR NOT NULL DEFAULT 'A' CHECK (Estado IN ('A', 'I')) -- A = Activo, I = Inactivo
);

CREATE TABLE Marca (
    MarcaId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Estado CHAR NOT NULL DEFAULT 'A' CHECK (Estado IN ('A', 'I')) -- A = Activo, I = Inactivo
);

-- Admin, Atencion al cliente, Tecnico 
CREATE TABLE Rol (
    RolId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Estado CHAR NOT NULL DEFAULT 'A' CHECK (Estado IN ('A', 'I')) -- A = Activo, I = Inactivo
);

CREATE TABLE Empleado (
    EmpleadoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DUI VARCHAR(10) UNIQUE NOT NULL,
    Telefono VARCHAR(9) NOT NULL,
    Correo VARCHAR(100) UNIQUE NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    FechaContratacion DATE NOT NULL,
    Estado CHAR NOT NULL DEFAULT 'A' CHECK (Estado IN ('A', 'I')) -- A = Activo, I = Inactivo
);

CREATE TABLE Usuario (
    UsuarioId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) UNIQUE NOT NULL,
    Clave VARCHAR(256) NOT NULL,
    EmpleadoId INT UNIQUE NOT NULL,
    RolId INT NOT NULL,
    Estado CHAR NOT NULL DEFAULT 'A' CHECK (Estado IN ('A', 'I')), -- A = Activo, I = Inactivo
    FOREIGN KEY (EmpleadoId) REFERENCES Empleado(EmpleadoId),
    FOREIGN KEY (RolId) REFERENCES Rol(RolId)
);

CREATE TABLE Cliente (
    ClienteId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    Correo VARCHAR(100) NULL,
    TipoDocumento VARCHAR(20) NOT NULL CHECK (TipoDocumento IN ('DUI', 'CarnetExtranjero')),
    DUI VARCHAR(10) NULL,
    CarnetExtranjero VARCHAR(20) NULL,
    FechaRegistro DATETIME NOT NULL DEFAULT GETDATE(),
    Estado CHAR NOT NULL DEFAULT 'A' CHECK (Estado IN ('A', 'I')) -- A = Activo, I = Inactivo

    CONSTRAINT CK_Cliente_Documento CHECK (
        (TipoDocumento = 'DUI' AND DUI IS NOT NULL AND CarnetExtranjero IS NULL)
        OR
        (TipoDocumento = 'CarnetExtranjero' AND CarnetExtranjero IS NOT NULL AND DUI IS NULL)
    )
);

CREATE TABLE Proveedor (
    ProveedorId INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    TipoProveedor CHAR(2) NOT NULL CHECK (TipoProveedor IN ('PN', 'PJ')),
    Telefono VARCHAR(15) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    DUI VARCHAR(10) NULL,
    NIT VARCHAR(20) NULL,
    NRC VARCHAR(20) NULL,
    Estado CHAR NOT NULL DEFAULT 'A' CHECK (Estado IN ('A', 'I')) -- A = Activo, I = Inactivo
);

CREATE TABLE Producto (
    ProductoId INT PRIMARY KEY IDENTITY,
    Codigo VARCHAR(50) UNIQUE NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(250) NULL,
    CantidadStock INT NOT NULL CHECK(CantidadStock >= 0), -- unidad
    PrecioUnitario DECIMAL(10,2) NOT NULL CHECK(PrecioUnitario > 0.00),
    ProveedorId INT NOT NULL,
    Estado CHAR NOT NULL DEFAULT 'A' CHECK (Estado IN ('A', 'I')), -- A = Activo, I = Inactivo

    -- Campos para auditoría
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    UsuarioCreacionId INT NOT NULL,
    FechaModificacion DATETIME NULL,
    UsuarioModificacionId INT NULL,

    FOREIGN KEY (ProveedorId) REFERENCES Proveedor(ProveedorId),
    FOREIGN KEY (UsuarioCreacionId) REFERENCES Usuario(UsuarioId),
    FOREIGN KEY (UsuarioModificacionId) REFERENCES Usuario(UsuarioId)
);

-- Tablas transaccionales
CREATE TABLE Reparacion (
    ReparacionId INT PRIMARY KEY IDENTITY,
    CodigoSeguimiento VARCHAR(20) UNIQUE NOT NULL,
    ClienteId INT NOT NULL,
    TipoEquipoId INT NOT NULL,
    MarcaId INT NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    TecnicoAsignadoId INT NULL,
    DiagnosticoInicial VARCHAR(400) NOT NULL, -- Cliente describe el problema
    EstadoReparacionId INT NOT NULL,
    FechaIngreso DATETIME DEFAULT GETDATE() NOT NULL,
    FechaEntrega DATETIME NULL,
    DiagnosticoFinal VARCHAR(300) NULL, -- Tecnico describe el problema y la solucion
    CostoManoObra DECIMAL(10,2) NOT NULL DEFAULT (0.00) CHECK (CostoManoObra >= 0.00), -- inicialmente en 0.00, se actualiza cuando el tecnico asignado termina la reparacion
    TotalReparacion DECIMAL(10,2) NULL CHECK (TotalReparacion >= 0.00),

    -- Campos para auditoría
    UsuarioCreacionId INT NOT NULL,
    FechaModificacion DATETIME NULL,
    UsuarioModificacionId INT NULL,

    FOREIGN KEY (TipoEquipoId) REFERENCES TipoEquipo(TipoEquipoId),
    FOREIGN KEY (MarcaId) REFERENCES Marca(MarcaId),
    FOREIGN KEY (EstadoReparacionId) REFERENCES EstadoReparacion(EstadoReparacionId),
    FOREIGN KEY (ClienteId) REFERENCES Cliente(ClienteId),
    FOREIGN KEY (TecnicoAsignadoId) REFERENCES Usuario(UsuarioId), -- Solo usuarios con Rol de Tecnico pueden ser asignados como TecnicoAsignado
    FOREIGN KEY (UsuarioCreacionId) REFERENCES Usuario(UsuarioId),
    FOREIGN KEY (UsuarioModificacionId) REFERENCES Usuario(UsuarioId)
);

CREATE TABLE DetalleReparacion (
    DetalleReparacionId INT PRIMARY KEY IDENTITY(1,1),
    ReparacionId INT NOT NULL,
    ProductoId INT NOT NULL,
    CantidadUtilizada INT NOT NULL CHECK (CantidadUtilizada > 0),
    PrecioUnitarioHistorico DECIMAL(10,2) NOT NULL DEFAULT (0.00) CHECK (PrecioUnitarioHistorico >= 0.00), -- para evitar que el precio del producto cambie y afecte el historial de reparaciones
    Subtotal AS (CantidadUtilizada * PrecioUnitarioHistorico) PERSISTED,
    FechaUso DATETIME NOT NULL DEFAULT GETDATE(),

    -- Campos para auditoría
    UsuarioCreacionId INT NOT NULL,
    FechaModificacion DATETIME NULL,
    UsuarioModificacionId INT NULL,

    FOREIGN KEY (ReparacionId) REFERENCES Reparacion(ReparacionId),
    FOREIGN KEY (ProductoId) REFERENCES Producto(ProductoId),
    FOREIGN KEY (UsuarioCreacionId) REFERENCES Usuario(UsuarioId),
    FOREIGN KEY (UsuarioModificacionId) REFERENCES Usuario(UsuarioId)
);
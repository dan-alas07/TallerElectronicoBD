CREATE DATABASE TallerElectronico;
GO

USE TallerElectronico;
GO

CREATE TABLE EstadoEmpleado (
    EstadoEmpleadoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE EstadoUsuario (
    EstadoUsuarioId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE EstadoEquipo (
    EstadoEquipoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE EstadoProducto (
    EstadoProductoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE EstadoCliente (
    EstadoClienteId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE EstadoProveedor (
    EstadoProveedorId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE TipoEquipo (
    TipoEquipoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE Marca (
    MarcaId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE Rol (
    RolId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Descripcion VARCHAR(250) NULL,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE Empleado (
    EmpleadoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DUI VARCHAR(10) UNIQUE NOT NULL,
    Telefono VARCHAR(9) NULL,
    Correo VARCHAR(100) UNIQUE NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    EstadoEmpleadoId INT NOT NULL,
    FechaContratacion DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (EstadoEmpleadoId) REFERENCES EstadoEmpleado(EstadoEmpleadoId)
);

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
    EstadoClienteId INT NOT NULL,

    FOREIGN KEY (EstadoClienteId) REFERENCES EstadoCliente(EstadoClienteId),

    CONSTRAINT CK_Cliente_Documento CHECK (
        (TipoDocumento = 'DUI' AND DUI IS NOT NULL AND CarnetExtranjero IS NULL)
        OR
        (TipoDocumento = 'CarnetExtranjero' AND CarnetExtranjero IS NOT NULL AND DUI IS NULL)
    )
);

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
    EstadoProveedorId INT NOT NULL,
    FOREIGN KEY (EstadoProveedorId) REFERENCES EstadoProveedor(EstadoProveedorId)
);

CREATE TABLE Producto (
    ProductoId INT PRIMARY KEY IDENTITY,
    Codigo VARCHAR(50) UNIQUE NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(250) NULL,
    CantidadStock INT NOT NULL CHECK(CantidadStock >= 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL CHECK(PrecioUnitario > 0.00),
    ProveedorId INT NOT NULL,
    EstadoProductoId INT NOT NULL,
    FOREIGN KEY (ProveedorId) REFERENCES Proveedor(ProveedorId),
    FOREIGN KEY (EstadoProductoId) REFERENCES EstadoProducto(EstadoProductoId)
);

CREATE TABLE DetalleProductoEquipo (
    DetalleProductoId INT PRIMARY KEY IDENTITY,
    EquipoId INT NOT NULL,
    ProductoId INT NOT NULL,
    CantidadUtilizada INT NOT NULL CHECK (CantidadUtilizada > 0),
    PrecioAplicado DECIMAL(10,2) NOT NULL,
    FechaUso DATETIME DEFAULT GETDATE() NOT NULL,
    FOREIGN KEY (EquipoId) REFERENCES Equipo(EquipoId),
    FOREIGN KEY (ProductoId) REFERENCES Producto(ProductoId)
);
-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertProveedor
    @Nombre VARCHAR(100),
    @TipoProveedor CHAR(2),
    @Telefono VARCHAR(15),
    @Email VARCHAR(100),
    @Direccion VARCHAR(255),
    @DUI VARCHAR(10) = NULL,
    @NIT VARCHAR(20) = NULL,
    @NRC VARCHAR(20) = NULL,
    @EstadoProveedorId INT = 1
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Proveedor (Nombre, TipoProveedor, Telefono, Email, Direccion, DUI,
        NIT, NRC, EstadoProveedorId)
    VALUES (
        @Nombre,
        @TipoProveedor,
        @Telefono,
        @Email,
        @Direccion,
        @DUI,
        @NIT,
        @NRC,
        @EstadoProveedorId
    );
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateProveedor
    @ProveedorId INT,
    @Nombre VARCHAR(100),
    @TipoProveedor CHAR(2),
    @Telefono VARCHAR(15),
    @Email VARCHAR(100),
    @Direccion VARCHAR(255),
    @DUI VARCHAR(10) = NULL,
    @NIT VARCHAR(20) = NULL,
    @NRC VARCHAR(20) = NULL,
    @EstadoProveedorId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Proveedor
    SET Nombre = @Nombre,
        TipoProveedor = @TipoProveedor,
        Telefono = @Telefono,
        Email = @Email,
        Direccion = @Direccion,
        DUI = @DUI,
        NIT = @NIT,
        NRC = @NRC,
        EstadoProveedorId = @EstadoProveedorId
    WHERE ProveedorId = @ProveedorId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteProveedor
    @ProveedorId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Proveedor
    SET EstadoProveedorId = 2
    WHERE ProveedorId = @ProveedorId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllProveedor
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ProveedorId,
        Nombre,
        TipoProveedor,
        Telefono,
        Email,
        Direccion,
        DUI,
        NIT,
        NRC,
        EstadoProveedorId
    FROM Proveedor
    ORDER BY ProveedorId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectProveedorById
    @ProveedorId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ProveedorId,
        Nombre,
        TipoProveedor,
        Telefono,
        Email,
        Direccion,
        DUI,
        NIT,
        NRC,
        EstadoProveedorId
    FROM Proveedor
    WHERE ProveedorId = @ProveedorId;
END;
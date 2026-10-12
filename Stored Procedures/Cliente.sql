
-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertCliente
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @Telefono VARCHAR(15),
    @EstadoClienteId INT = 1,
    @DUI VARCHAR(10) = NULL,
    @Correo VARCHAR(100) = NULL,
    @FechaRegistro DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cliente (
        Nombre,
        Apellido,
        DUI,
        Telefono,
        Correo,
        FechaRegistro,
        EstadoClienteId
    )
    VALUES (
        @Nombre,
        @Apellido,
        @DUI,
        @Telefono,
        @Correo,
        ISNULL(@FechaRegistro, GETDATE()),
        @EstadoClienteId
    );
END;
GO

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateCliente
    @ClienteId INT,
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @Telefono VARCHAR(15),
    @EstadoClienteId INT,
    @DUI VARCHAR(10) = NULL,
    @Correo VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Cliente
    SET Nombre = @Nombre,
        Apellido = @Apellido,
        DUI = @DUI,
        Telefono = @Telefono,
        Correo = @Correo,
        EstadoClienteId = @EstadoClienteId
    WHERE ClienteId = @ClienteId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteCliente
    @ClienteId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Cliente
    SET EstadoClienteId = 2
    WHERE ClienteId = @ClienteId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllCliente
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ClienteId,
        Nombre,
        Apellido,
        DUI,
        Telefono,
        Correo,
        FechaRegistro,
        EstadoClienteId
    FROM Cliente
    ORDER BY ClienteId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectClienteById
    @ClienteId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ClienteId,
        Nombre,
        Apellido,
        DUI,
        Telefono,
        Correo,
        FechaRegistro,
        EstadoClienteId
    FROM Cliente
    WHERE ClienteId = @ClienteId;
END;
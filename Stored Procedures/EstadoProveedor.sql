-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoProveedor
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EstadoProveedor (Nombre)
    VALUES (@Nombre);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoProveedor
    @EstadoProveedorId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoProveedor
    SET Nombre = @Nombre
    WHERE EstadoProveedorId = @EstadoProveedorId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoProveedor
    @EstadoProveedorId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoProveedor
    SET Activo = 0
    WHERE EstadoProveedorId = @EstadoProveedorId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoProveedor
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoProveedorId,
        Nombre,
        Activo
    FROM EstadoProveedor
    ORDER BY EstadoProveedorId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectEstadoProveedorById
    @EstadoProveedorId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoProveedorId,
        Nombre,
        Activo
    FROM EstadoProveedor
    WHERE EstadoProveedorId = @EstadoProveedorId;
END;
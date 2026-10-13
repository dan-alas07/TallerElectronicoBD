-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoProducto
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EstadoProducto (Nombre)
    VALUES (@Nombre);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoProducto
    @EstadoProductoId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoProducto
    SET Nombre = @Nombre
    WHERE EstadoProductoId = @EstadoProductoId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoProducto
    @EstadoProductoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoProducto
    SET Activo = 0
    WHERE EstadoProductoId = @EstadoProductoId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoProducto
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoProductoId,
        Nombre,
        Activo
    FROM EstadoProducto
    ORDER BY EstadoProductoId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectEstadoProductoById
    @EstadoProductoId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoProductoId,
        Nombre,
        Activo
    FROM EstadoProducto
    WHERE EstadoProductoId = @EstadoProductoId;
END;
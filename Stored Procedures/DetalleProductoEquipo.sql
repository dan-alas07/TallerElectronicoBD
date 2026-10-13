-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertDetalleProductoEquipo
    @EquipoId INT,
    @ProductoId INT,
    @CantidadUtilizada INT,
    @PrecioAplicado DECIMAL(10,2),
    @FechaUso DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO DetalleProductoEquipo (
        EquipoId,
        ProductoId,
        CantidadUtilizada,
        PrecioAplicado,
        FechaUso
    )
    VALUES (
        @EquipoId,
        @ProductoId,
        @CantidadUtilizada,
        @PrecioAplicado,
        ISNULL(@FechaUso, GETDATE())
    );
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateDetalleProductoEquipo
    @DetalleProductoId INT,
    @EquipoId INT,
    @ProductoId INT,
    @CantidadUtilizada INT,
    @PrecioAplicado DECIMAL(10,2),
    @FechaUso DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE DetalleProductoEquipo
    SET EquipoId = @EquipoId,
        ProductoId = @ProductoId,
        CantidadUtilizada = @CantidadUtilizada,
        PrecioAplicado = @PrecioAplicado,
        FechaUso = @FechaUso
    WHERE DetalleProductoId = @DetalleProductoId;
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteDetalleProductoEquipo
    @DetalleProductoId INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM DetalleProductoEquipo
    WHERE DetalleProductoId = @DetalleProductoId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllDetalleProductoEquipo
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        DetalleProductoId,
        EquipoId,
        ProductoId,
        CantidadUtilizada,
        PrecioAplicado,
        (CantidadUtilizada * PrecioAplicado) AS Subtotal,
        FechaUso
    FROM DetalleProductoEquipo
    ORDER BY DetalleProductoId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectDetalleProductoEquipoById
    @DetalleProductoId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        DetalleProductoId,
        EquipoId,
        ProductoId,
        CantidadUtilizada,
        PrecioAplicado,
        (CantidadUtilizada * PrecioAplicado) AS Subtotal,
        FechaUso
    FROM DetalleProductoEquipo
    WHERE DetalleProductoId = @DetalleProductoId;
END;
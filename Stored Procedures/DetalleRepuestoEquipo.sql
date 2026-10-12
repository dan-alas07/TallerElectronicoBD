-- Tabla: DestallesRepuestoEquipo

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertDetalleRepuestoEquipo
    @EquipoId INT,
    @RepuestoId INT,
    @CantidadUtilizada INT,
    @PrecioAplicado DECIMAL(10,2),
    @FechaUso DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO DetalleRepuestoEquipo
        (EquipoId, RepuestoId, CantidadUtilizada, PrecioAplicado, FechaUso)
    VALUES
        (
            @EquipoId,
            @RepuestoId,
            @CantidadUtilizada,
            @PrecioAplicado,
            ISNULL(@FechaUso, GETDATE())
        );
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateDetalleRepuestoEquipo
    @DetalleId INT,
    @EquipoId INT,
    @RepuestoId INT,
    @CantidadUtilizada INT,
    @PrecioAplicado DECIMAL(10,2),
    @FechaUso DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE DetalleRepuestoEquipo
    SET EquipoId = @EquipoId,
        RepuestoId = @RepuestoId,
        CantidadUtilizada = @CantidadUtilizada,
        PrecioAplicado = @PrecioAplicado,
        FechaUso = @FechaUso
    WHERE DetalleId = @DetalleId;
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteDetalleRepuestoEquipo
    @DetalleId INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM DetalleRepuestoEquipo
    WHERE DetalleId = @DetalleId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllDetalleRepuestoEquipo
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        DetalleId,
        EquipoId,
        RepuestoId,
        CantidadUtilizada,
        PrecioAplicado,
        (CantidadUtilizada * PrecioAplicado) AS Subtotal,
        FechaUso
    FROM DetalleRepuestoEquipo
    ORDER BY DetalleId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectDetalleRepuestoEquipoById
    @DetalleId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        DetalleId,
        EquipoId,
        RepuestoId,
        CantidadUtilizada,
        PrecioAplicado,
        (CantidadUtilizada * PrecioAplicado) AS Subtotal,
        FechaUso
    FROM DetalleRepuestoEquipo
    WHERE DetalleId = @DetalleId;
END;
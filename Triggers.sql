GO
CREATE OR ALTER TRIGGER TgAfterInsert_DetalleReparacion
ON DetalleReparacion
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Capturar el precio del producto
    UPDATE d
    SET d.PrecioUnitarioHistorico = p.PrecioUnitario
    FROM DetalleReparacion d
    INNER JOIN inserted i ON d.DetalleReparacionId = i.DetalleReparacionId
    INNER JOIN Producto p ON i.ProductoId = p.ProductoId
    WHERE d.PrecioUnitarioHistorico = 0.00;

    -- 2. Descontar el stock en Producto
    UPDATE p
    SET p.CantidadStock = p.CantidadStock - i.CantidadUtilizada
    FROM Producto p
    INNER JOIN inserted i ON p.ProductoId = i.ProductoId;

    -- 3. Actualizar TotalReparacion (y auditar el cambio automáticamente)
    UPDATE r
    SET 
        r.TotalReparacion = r.CostoManoObra + ISNULL((
            SELECT SUM(d.Subtotal) 
            FROM DetalleReparacion d 
            WHERE d.ReparacionId = r.ReparacionId
        ), 0.00),
        r.UsuarioModificacionId = i.UsuarioCreacionId, -- El técnico que metió el repuesto
        r.FechaModificacion = GETDATE()
    FROM Reparacion r
    INNER JOIN inserted i ON r.ReparacionId = i.ReparacionId;
END;
GO

-- 2. Tu trigger cuando cambia la Mano de Obra
CREATE OR ALTER TRIGGER TgAfterUpdate_ManoObraReparacion
ON Reparacion
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(CostoManoObra)
    BEGIN
        UPDATE r
        SET r.TotalReparacion = i.CostoManoObra + ISNULL((
            SELECT SUM(d.Subtotal)
            FROM DetalleReparacion d
            WHERE d.ReparacionId = r.ReparacionId
        ), 0.00)
        FROM Reparacion r
        INNER JOIN inserted i ON r.ReparacionId = i.ReparacionId;
    END;
END;
GO
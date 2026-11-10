-- 1. TRIGGER PARA DETALLE REPARACION (Control de Stock y Recálculo del Total)
CREATE OR ALTER TRIGGER Tg_DetalleReparacion_Stock_Total
ON DetalleReparacion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH Movimientos AS (

        SELECT ProductoId, CantidadUtilizada AS Cantidad FROM inserted
        UNION ALL

        SELECT ProductoId, -CantidadUtilizada AS Cantidad FROM deleted
    ),
    Agrupado AS (
        SELECT ProductoId, SUM(Cantidad) AS Variacion
        FROM Movimientos
        GROUP BY ProductoId
    )
    UPDATE p
    SET p.CantidadStock = p.CantidadStock - a.Variacion
    FROM Producto p
    INNER JOIN Agrupado a ON p.ProductoId = a.ProductoId;

    ;WITH ReparacionesAfectadas AS (
        SELECT ReparacionId FROM inserted
        UNION
        SELECT ReparacionId FROM deleted
    )
    UPDATE r
    SET 
        r.TotalReparacion = r.CostoManoObra + ISNULL((
            SELECT SUM(d.CantidadUtilizada * d.PrecioUnitarioHistorico) 
            FROM DetalleReparacion d 
            WHERE d.ReparacionId = r.ReparacionId
        ), 0.00),
        r.FechaModificacion = GETDATE()
    FROM Reparacion r
    INNER JOIN ReparacionesAfectadas ra ON r.ReparacionId = ra.ReparacionId;
END;
GO

-- 2. TRIGGER PARA REPARACION (Recálculo cuando cambia Mano de Obra)
CREATE OR ALTER TRIGGER TgAfterUpdate_ManoObraReparacion
ON Reparacion
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(CostoManoObra)
    BEGIN
        UPDATE r
        SET r.TotalReparacion = i.CostoManoObra + ISNULL((
            SELECT SUM(d.CantidadUtilizada * d.PrecioUnitarioHistorico)
            FROM DetalleReparacion d
            WHERE d.ReparacionId = r.ReparacionId
        ), 0.00)
        FROM Reparacion r
        INNER JOIN inserted i ON r.ReparacionId = i.ReparacionId
        INNER JOIN deleted d ON i.ReparacionId = d.ReparacionId
        WHERE i.CostoManoObra <> d.CostoManoObra;
    END;
END;
GO

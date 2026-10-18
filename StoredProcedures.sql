-- SP Ordenes de Reparación
GO
CREATE OR ALTER PROCEDURE spListarOrdenes
    @TecnicoId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        r.ReparacionId,
        r.CodigoSeguimiento,
        c.Nombre + ' ' + c.Apellido AS NombreCliente,
        t.Nombre AS TipoEquipo,
        m.Nombre AS Marca,
        r.Modelo,
        er.Nombre AS EstadoReparacion,
        r.FechaIngreso,
        ISNULL(r.TotalReparacion, 0.00) AS TotalReparacion
    FROM Reparacion r
    INNER JOIN Cliente c ON r.ClienteId = c.ClienteId
    INNER JOIN TipoEquipo t ON r.TipoEquipoId = t.TipoEquipoId
    INNER JOIN Marca m ON r.MarcaId = m.MarcaId
    INNER JOIN EstadoReparacion er ON r.EstadoReparacionId = er.EstadoReparacionId
    WHERE (@TecnicoId IS NULL OR r.TecnicoAsignadoId = @TecnicoId)
    ORDER BY r.FechaIngreso DESC;
END;
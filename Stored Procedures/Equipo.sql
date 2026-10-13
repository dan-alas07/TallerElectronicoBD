-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEquipo
    @CodigoSeguimiento VARCHAR(20),
    @TipoEquipoId INT,
    @MarcaId INT,
    @Modelo VARCHAR(50),
    @DiagnosticoInicial VARCHAR(400),
    @Observaciones VARCHAR(300) = NULL,
    @EstadoEquipoId INT = 1,
    @FechaIngreso DATETIME = NULL,
    @FechaEntrega DATETIME = NULL,
    @ClienteId INT,
    @TecnicoAsignadoId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Equipo
        (CodigoSeguimiento, TipoEquipoId, MarcaId, Modelo,
         DiagnosticoInicial, Observaciones, EstadoEquipoId,
         FechaIngreso, FechaEntrega, ClienteId, TecnicoAsignadoId)
    VALUES
        (
            @CodigoSeguimiento,
            @TipoEquipoId,
            @MarcaId,
            @Modelo,
            @DiagnosticoInicial,
            @Observaciones,
            @EstadoEquipoId,
            ISNULL(@FechaIngreso, GETDATE()),
            @FechaEntrega,
            @ClienteId,
            @TecnicoAsignadoId
        );
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEquipo
    @EquipoId INT,
    @CodigoSeguimiento VARCHAR(20),
    @TipoEquipoId INT,
    @MarcaId INT,
    @Modelo VARCHAR(50),
    @DiagnosticoInicial VARCHAR(400),
    @Observaciones VARCHAR(300) = NULL,
    @EstadoEquipoId INT,
    @FechaIngreso DATETIME,
    @FechaEntrega DATETIME = NULL,
    @ClienteId INT,
    @TecnicoAsignadoId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Equipo
    SET CodigoSeguimiento = @CodigoSeguimiento,
        TipoEquipoId = @TipoEquipoId,
        MarcaId = @MarcaId,
        Modelo = @Modelo,
        DiagnosticoInicial = @DiagnosticoInicial,
        Observaciones = @Observaciones,
        EstadoEquipoId = @EstadoEquipoId,
        FechaIngreso = @FechaIngreso,
        FechaEntrega = @FechaEntrega,
        ClienteId = @ClienteId,
        TecnicoAsignadoId = @TecnicoAsignadoId
    WHERE EquipoId = @EquipoId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteEquipo
    @EquipoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Equipo
    SET EstadoEquipoId = 2
    WHERE EquipoId = @EquipoId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEquipo
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EquipoId,
        CodigoSeguimiento,
        TipoEquipoId,
        MarcaId,
        Modelo,
        DiagnosticoInicial,
        Observaciones,
        EstadoEquipoId,
        FechaIngreso,
        FechaEntrega,
        ClienteId,
        TecnicoAsignadoId
    FROM Equipo
    ORDER BY EquipoId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectEquipoById
    @EquipoId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EquipoId,
        CodigoSeguimiento,
        TipoEquipoId,
        MarcaId,
        Modelo,
        DiagnosticoInicial,
        Observaciones,
        EstadoEquipoId,
        FechaIngreso,
        FechaEntrega,
        ClienteId,
        TecnicoAsignadoId
    FROM Equipo
    WHERE EquipoId = @EquipoId;
END;
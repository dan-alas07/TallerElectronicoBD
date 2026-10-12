
-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertTipoEquipo
    @Nombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO TipoEquipo (Nombre)
    VALUES (@Nombre);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateTipoEquipo
    @TipoEquipoId INT,
    @Nombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE TipoEquipo
    SET Nombre = @Nombre
    WHERE TipoEquipoId = @TipoEquipoId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteTipoEquipo
    @TipoEquipoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE TipoEquipo
    SET Activo = 0
    WHERE TipoEquipoId = @TipoEquipoId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllTipoEquipo
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        TipoEquipoId,
        Nombre,
        Activo
    FROM TipoEquipo
    ORDER BY TipoEquipoId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectTipoEquipoById
    @TipoEquipoId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        TipoEquipoId,
        Nombre,
        Activo
    FROM TipoEquipo
    WHERE TipoEquipoId = @TipoEquipoId;
END;
-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoEquipo
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EstadoEquipo (Nombre)
    VALUES (@Nombre);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoEquipo
    @EstadoEquipoId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoEquipo
    SET Nombre = @Nombre
    WHERE EstadoEquipoId = @EstadoEquipoId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoEquipo
    @EstadoEquipoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoEquipo
    SET Activo = 0
    WHERE EstadoEquipoId = @EstadoEquipoId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoEquipo
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoEquipoId,
        Nombre,
        Activo
    FROM EstadoEquipo
    ORDER BY EstadoEquipoId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectEstadoEquipoById
    @EstadoEquipoId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoEquipoId,
        Nombre,
        Activo
    FROM EstadoEquipo
    WHERE EstadoEquipoId = @EstadoEquipoId;
END;
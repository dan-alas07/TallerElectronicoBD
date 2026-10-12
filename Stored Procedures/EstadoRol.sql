
-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoRol
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EstadoRol (Nombre)
    VALUES (@Nombre);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoRol
    @EstadoRolId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoRol
    SET Nombre = @Nombre
    WHERE EstadoRolId = @EstadoRolId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoRol
    @EstadoRolId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoRol
    SET Activo = 0
    WHERE EstadoRolId = @EstadoRolId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoRol
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoRolId,
        Nombre,
        Activo
    FROM EstadoRol
    ORDER BY EstadoRolId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectEstadoRolById
    @EstadoRolId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoRolId,
        Nombre,
        Activo
    FROM EstadoRol
    WHERE EstadoRolId = @EstadoRolId;
END;
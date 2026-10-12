-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoUsuario
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EstadoUsuario (Nombre)
    VALUES (@Nombre);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoUsuario
    @EstadoUsuarioId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoUsuario
    SET Nombre = @Nombre
    WHERE EstadoUsuarioId = @EstadoUsuarioId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoUsuario
    @EstadoUsuarioId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoUsuario
    SET Activo = 0
    WHERE EstadoUsuarioId = @EstadoUsuarioId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoUsuario
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoUsuarioId,
        Nombre,
        Activo
    FROM EstadoUsuario
    ORDER BY EstadoUsuarioId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectEstadoUsuarioById
    @EstadoUsuarioId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoUsuarioId,
        Nombre,
        Activo
    FROM EstadoUsuario
    WHERE EstadoUsuarioId = @EstadoUsuarioId;
END;
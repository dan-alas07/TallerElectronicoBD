
-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertUsuario
    @EmpleadoId INT,
    @Nombre VARCHAR(50),
    @Clave VARCHAR(256),
    @RolId INT,
    @EstadoUsuarioId INT = 1
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Usuario
        (EmpleadoId, Nombre, Clave, RolId, EstadoUsuarioId)
    VALUES
        (
            @EmpleadoId,
            @Nombre,
            @Clave,
            @RolId,
            @EstadoUsuarioId
        );
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateUsuario
    @UsuarioId INT,
    @EmpleadoId INT,
    @Nombre VARCHAR(50),
    @Clave VARCHAR(256),
    @RolId INT,
    @EstadoUsuarioId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Usuario
    SET EmpleadoId = @EmpleadoId,
        Nombre = @Nombre,
        Clave = @Clave,
        RolId = @RolId,
        EstadoUsuarioId = @EstadoUsuarioId
    WHERE UsuarioId = @UsuarioId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteUsuario
    @UsuarioId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Usuario
    SET EstadoUsuarioId = 2
    WHERE UsuarioId = @UsuarioId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllUsuario
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        UsuarioId,
        EmpleadoId,
        Nombre,
        RolId,
        EstadoUsuarioId
    FROM Usuario
    ORDER BY UsuarioId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectUsuarioById
    @UsuarioId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        UsuarioId,
        EmpleadoId,
        Nombre,
        RolId,
        EstadoUsuarioId
    FROM Usuario
    WHERE UsuarioId = @UsuarioId;
END;
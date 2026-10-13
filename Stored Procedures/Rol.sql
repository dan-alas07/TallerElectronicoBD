-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertRol
    @Nombre VARCHAR(50),
    @Descripcion VARCHAR(250) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Rol (Nombre,Descripcion)
    VALUES (
        @Nombre,
        @Descripcion
    );
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateRol
    @RolId INT,
    @Nombre VARCHAR(50),
    @Descripcion VARCHAR(250) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Rol
    SET Nombre = @Nombre,
        Descripcion = @Descripcion
    WHERE RolId = @RolId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteRol
    @RolId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Rol
    SET Activo = 0
    WHERE RolId = @RolId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllRol
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        RolId,
        Nombre,
        Descripcion,
        Activo
    FROM Rol
    ORDER BY RolId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectRolById
    @RolId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        RolId,
        Nombre,
        Descripcion,
        Activo
    FROM Rol
    WHERE RolId = @RolId;
END;
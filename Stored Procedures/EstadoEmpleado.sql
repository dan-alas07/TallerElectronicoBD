-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoEmpleado
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EstadoEmpleado (Nombre)
    VALUES (@Nombre);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoEmpleado
    @EstadoEmpleadoId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoEmpleado
    SET Nombre = @Nombre
    WHERE EstadoEmpleadoId = @EstadoEmpleadoId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoEmpleado
    @EstadoEmpleadoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoEmpleado
    SET Activo = 0
    WHERE EstadoEmpleadoId = @EstadoEmpleadoId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoEmpleado
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoEmpleadoId,
        Nombre,
        Activo
    FROM EstadoEmpleado
    ORDER BY EstadoEmpleadoId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectEstadoEmpleadoById
    @EstadoEmpleadoId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoEmpleadoId,
        Nombre,
        Activo
    FROM EstadoEmpleado
    WHERE EstadoEmpleadoId = @EstadoEmpleadoId;
END;
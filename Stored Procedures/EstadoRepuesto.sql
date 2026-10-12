
-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoRepuesto
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EstadoRepuesto (Nombre)
    VALUES (@Nombre);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoRepuesto
    @EstadoRepuestoId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoRepuesto
    SET Nombre = @Nombre
    WHERE EstadoRepuestoId = @EstadoRepuestoId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoRepuesto
    @EstadoRepuestoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoRepuesto
    SET Activo = 0
    WHERE EstadoRepuestoId = @EstadoRepuestoId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoRepuesto
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoRepuestoId,
        Nombre,
        Activo
    FROM EstadoRepuesto
    ORDER BY EstadoRepuestoId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectEstadoRepuestoById
    @EstadoRepuestoId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoRepuestoId,
        Nombre,
        Activo
    FROM EstadoRepuesto
    WHERE EstadoRepuestoId = @EstadoRepuestoId;
END;
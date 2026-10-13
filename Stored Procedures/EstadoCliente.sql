-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoCliente
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EstadoCliente (Nombre)
    VALUES (@Nombre);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoCliente
    @EstadoClienteId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoCliente
    SET Nombre = @Nombre
    WHERE EstadoClienteId = @EstadoClienteId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoCliente
    @EstadoClienteId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE EstadoCliente
    SET Activo = 0
    WHERE EstadoClienteId = @EstadoClienteId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoCliente
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoClienteId,
        Nombre,
        Activo
    FROM EstadoCliente
    ORDER BY EstadoClienteId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectEstadoClienteById
    @EstadoClienteId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EstadoClienteId,
        Nombre,
        Activo
    FROM EstadoCliente
    WHERE EstadoClienteId = @EstadoClienteId;
END;
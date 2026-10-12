
-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertRepuesto
    @Codigo VARCHAR(50),
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(250) = NULL,
    @CantidadStock INT,
    @PrecioUnitario DECIMAL(10,2),
    @EstadoRepuestoId INT = 1
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Repuesto (
        Codigo,
        Nombre,
        Descripcion,
        CantidadStock,
        PrecioUnitario,
        EstadoRepuestoId
    )
    VALUES (
        @Codigo,
        @Nombre,
        @Descripcion,
        @CantidadStock,
        @PrecioUnitario,
        @EstadoRepuestoId
    );
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateRepuesto
    @RepuestoId INT,
    @Codigo VARCHAR(50),
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(250) = NULL,
    @CantidadStock INT,
    @PrecioUnitario DECIMAL(10,2),
    @EstadoRepuestoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Repuesto
    SET Codigo = @Codigo,
        Nombre = @Nombre,
        Descripcion = @Descripcion,
        CantidadStock = @CantidadStock,
        PrecioUnitario = @PrecioUnitario,
        EstadoRepuestoId = @EstadoRepuestoId
    WHERE RepuestoId = @RepuestoId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteRepuesto
    @RepuestoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Repuesto
    SET EstadoRepuestoId = 2
    WHERE RepuestoId = @RepuestoId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllRepuesto
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        RepuestoId,
        Codigo,
        Nombre,
        Descripcion,
        CantidadStock,
        PrecioUnitario,
        EstadoRepuestoId
    FROM Repuesto
    ORDER BY RepuestoId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectRepuestoById
    @RepuestoId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        RepuestoId,
        Codigo,
        Nombre,
        Descripcion,
        CantidadStock,
        PrecioUnitario,
        EstadoRepuestoId
    FROM Repuesto
    WHERE RepuestoId = @RepuestoId;
END;
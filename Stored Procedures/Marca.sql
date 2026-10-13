-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertMarca
    @Nombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Marca (Nombre)
    VALUES (@Nombre);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateMarca
    @MarcaId INT,
    @Nombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Marca
    SET Nombre = @Nombre
    WHERE MarcaId = @MarcaId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteMarca
    @MarcaId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Marca
    SET Activo = 0
    WHERE MarcaId = @MarcaId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllMarca
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        MarcaId,
        Nombre,
        Activo
    FROM Marca
    ORDER BY MarcaId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectMarcaById
    @MarcaId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        MarcaId,
        Nombre,
        Activo
    FROM Marca
    WHERE MarcaId = @MarcaId;
END;
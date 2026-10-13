-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertProducto
    @Codigo VARCHAR(50),
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(250) = NULL,
    @CantidadStock INT,
    @PrecioUnitario DECIMAL(10,2),
    @ProveedorId INT,
    @EstadoProductoId INT = 1
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Producto (
        Codigo,
        Nombre,
        Descripcion,
        CantidadStock,
        PrecioUnitario,
        ProveedorId,
        EstadoProductoId
    )
    VALUES (
        @Codigo,
        @Nombre,
        @Descripcion,
        @CantidadStock,
        @PrecioUnitario,
        @ProveedorId,
        @EstadoProductoId
    );
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateProducto
    @ProductoId INT,
    @Codigo VARCHAR(50),
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(250) = NULL,
    @CantidadStock INT,
    @PrecioUnitario DECIMAL(10,2),
    @ProveedorId INT,
    @EstadoProductoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Producto
    SET Codigo = @Codigo,
        Nombre = @Nombre,
        Descripcion = @Descripcion,
        CantidadStock = @CantidadStock,
        PrecioUnitario = @PrecioUnitario,
        ProveedorId = @ProveedorId,
        EstadoProductoId = @EstadoProductoId
    WHERE ProductoId = @ProductoId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteProducto
    @ProductoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Producto
    SET EstadoProductoId = 2
    WHERE ProductoId = @ProductoId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllProducto
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ProductoId,
        Codigo,
        Nombre,
        Descripcion,
        CantidadStock,
        PrecioUnitario,
        ProveedorId,
        EstadoProductoId
    FROM Producto
    ORDER BY ProductoId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectProductoById
    @ProductoId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ProductoId,
        Codigo,
        Nombre,
        Descripcion,
        CantidadStock,
        PrecioUnitario,
        ProveedorId,
        EstadoProductoId
    FROM Producto
    WHERE ProductoId = @ProductoId;
END;
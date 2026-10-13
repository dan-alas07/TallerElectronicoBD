-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEmpleado
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @DUI VARCHAR(10),
    @Telefono VARCHAR(9) = NULL,
    @Correo VARCHAR(100),
    @Direccion VARCHAR(255),
    @EstadoEmpleadoId INT = 1,
    @FechaContratacion DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Empleado (Nombre, Apellido, DUI, Telefono, Correo, Direccion, EstadoEmpleadoId, FechaContratacion)
    VALUES (
        @Nombre,
        @Apellido,
        @DUI,
        @Telefono,
        @Correo,
        @Direccion,
        @EstadoEmpleadoId,
        ISNULL(@FechaContratacion, GETDATE())
    );
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEmpleado
    @EmpleadoId INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @DUI VARCHAR(10),
    @Telefono VARCHAR(9) = NULL,
    @Correo VARCHAR(100),
    @Direccion VARCHAR(255),
    @EstadoEmpleadoId INT,
    @FechaContratacion DATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Empleado
    SET Nombre = @Nombre,
        Apellido = @Apellido,
        DUI = @DUI,
        Telefono = @Telefono,
        Correo = @Correo,
        Direccion = @Direccion,
        EstadoEmpleadoId = @EstadoEmpleadoId,
        FechaContratacion = @FechaContratacion
    WHERE EmpleadoId = @EmpleadoId;
END;

-- 3) SP DELETE (BAJA LÓGICA)
GO
CREATE OR ALTER PROCEDURE spDeleteEmpleado
    @EmpleadoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Empleado
    SET EstadoEmpleadoId = 2
    WHERE EmpleadoId = @EmpleadoId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEmpleado
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EmpleadoId,
        Nombre,
        Apellido,
        DUI,
        Telefono,
        Correo,
        Direccion,
        EstadoEmpleadoId,
        FechaContratacion
    FROM Empleado
    ORDER BY EmpleadoId ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectEmpleadoById
    @EmpleadoId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EmpleadoId,
        Nombre,
        Apellido,
        DUI,
        Telefono,
        Correo,
        Direccion,
        EstadoEmpleadoId,
        FechaContratacion
    FROM Empleado
    WHERE EmpleadoId = @EmpleadoId;
END;
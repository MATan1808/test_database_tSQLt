-- 1. Tạo Database mới
CREATE DATABASE EmployeeDB1;
GO
USE EmployeeDB1;
GO

-- 2. Tạo bảng Employees1
CREATE TABLE Employees1 (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName NVARCHAR(100),
    Department NVARCHAR(50),
    Salary DECIMAL(10,2)
);
GO

-- 3. Bật CLR và cài đặt tSQLt
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'clr enabled', 1;
RECONFIGURE;
EXEC sp_configure 'clr strict security', 0;
RECONFIGURE;
GO

/*
EXEC sp_configure 'show advanced options', 1; → Bật tùy chọn nâng cao.
EXEC sp_configure 'clr enabled', 1; → Bật hỗ trợ CLR (Common Language Runtime).
EXEC sp_configure 'clr strict security', 0; → Tắt chế độ bảo mật nghiêm ngặt để sử dụng tSQLt.
RECONFIGURE; → Áp dụng thay đổi.
*/

-- 4. Tạo schema kiểm thử (Tên phải đồng nhất)
EXEC tSQLt.NewTestClass 'TestEmployees1'; --Tạo schema TestEmployees1 để chứa các test case.
GO

-- 5. Kiểm thử 1: Kiểm tra bảng Employees1 không rỗng
CREATE PROCEDURE TestEmployees1.[test EmployeeTableNotEmpty]
AS
BEGIN
    DECLARE @Actual INT;
    SELECT @Actual = COUNT(*) FROM Employees1;  --- Đếm số nhân viên trong bảng

    -- So sánh kết quả mong đợi (phải có ít nhất 1 nhân viên)
    EXEC tSQLt.AssertEquals @Expected = 1, @Actual = @Actual;  -
END;
GO

-- 6. Kiểm thử 2: Kiểm tra nhân viên có tồn tại trong Employees1
CREATE PROCEDURE TestEmployees1.[test EmployeeExists]
AS
BEGIN
    -- Tạo dữ liệu kiểm thử
    INSERT INTO Employees1 (EmployeeName, Department, Salary)
    VALUES ('Test User', 'IT', 5000);

    -- Lấy ID của nhân viên mới
    DECLARE @EmployeeID INT = SCOPE_IDENTITY();

    -- Kiểm tra xem nhân viên có tồn tại không
    DECLARE @Actual INT;
    SELECT @Actual = COUNT(*) FROM Employees1 WHERE EmployeeID = @EmployeeID;

    -- So sánh kết quả mong đợi
    EXEC tSQLt.AssertEquals @Expected = 1, @Actual = @Actual;  

    -- Xóa dữ liệu kiểm thử
    DELETE FROM Employees1 WHERE EmployeeID = @EmployeeID;
END;
GO
-- 7. Kiểm thử 2: Kiểm tra nhân viên có tồn tại trong Employees1
EXEC tSQLt.Run 'TestEmployees1.test EmployeeTableNotEmpty';
GO
---- 8. Kiểm thử 2: Kiểm tra nhân viên có tồn tại trong Employees1
EXEC tSQLt.Run 'TestEmployees1.test EmployeeExists';
GO
--- run all 
EXEC tSQLt.RunAll;
GO


SELECT * FROM Employees1;

--- them du lieu vao bang 
INSERT INTO Employees1 (EmployeeName, Department, Salary)
VALUES ('Test User', 'IT', 5000);


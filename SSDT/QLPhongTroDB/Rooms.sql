CREATE TABLE [dbo].[Rooms]
(
    RoomID INT IDENTITY(1,1) PRIMARY KEY,
    RoomName NVARCHAR(100) NOT NULL,
    RentPrice DECIMAL(10,2) NOT NULL,
    Status NVARCHAR(50) NOT NULL DEFAULT 'Available'
);

GO  -- Dùng GO để phân tách batch

INSERT INTO Rooms (RoomName, RentPrice, Status)
VALUES 
    (N'Phòng 101', 5000000, N'Available'),
    (N'Phòng 102', 5500000, N'Occupied'),
    (N'Phòng 103', 6000000, N'Available');

GO




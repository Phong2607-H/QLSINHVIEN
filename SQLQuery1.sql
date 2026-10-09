CREATE DATABASE QLSINHVIEN
USE QLSINHVIEN
GO

CREATE TABLE SINHVIEN
(
	Id INT IDENTITY(1,1) PRIMARY KEY,

    HoTen NVARCHAR(100) NOT NULL,

    Email VARCHAR(100) NOT NULL,

    Tuoi INT NOT NULL
);
GO
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL, -- Cột lưu mật khẩu đã băm (loằng ngoằng)
    FullName NVARCHAR(100) NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO
USE QLSINHVIEN;
GO

CREATE TABLE AuditLogs (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(100) NOT NULL,
    Action NVARCHAR(20) NOT NULL,
    TableName NVARCHAR(50) NOT NULL,
    OldValues NVARCHAR(MAX) NULL,
    NewValues NVARCHAR(MAX) NULL,
    Timestamp DATETIME NOT NULL DEFAULT GETDATE()
);
GO
INSERT INTO SINHVIEN (HoTen, Email, Tuoi)
VALUES
(N'Nguyễn Văn An', 'an@gmail.com', 20),

(N'Trần Thị Bình', 'binh@gmail.com', 21),

(N'Lê Hoàng Nam', 'nam@gmail.com', 22),

(N'Phạm Minh Tuấn', 'tuan@gmail.com', 20),

(N'Nguyễn Thị Lan', 'lan@gmail.com', 19);
GO


INSERT INTO Users (Username, PasswordHash, FullName)
VALUES
('admin1', '$2a$11$J1p1YdG5y7fJd.gXWn.8hOfYF2.mZ1o9Q/v1BwP2a0K8k8UvK0wXm', N'Quản trị viên'),
('giangvien1', '$2a$11$H5sD4fG3h2j1k0l9p8o7i6u5y4t3r2e1w0qA.s.d.f.g.h.j.k', N'Nguyễn Minh Hoàng');
ALTER TABLE Users
ADD Role VARCHAR(20) NOT NULL DEFAULT 'GiangVien';
GO
SELECT * FROM SINHVIEN;
SELECT * FROM Users;
TRUNCATE TABLE SINHVIEN;
TRUNCATE TABLE Users;
UPDATE Users
SET Role = 'Admin'
WHERE Username = 'admin';
GO
ALTER TABLE SINHVIEN
ADD AvatarUrl NVARCHAR(255) NULL;
GO
SELECT * FROM AuditLogs ORDER BY Timestamp DESC;
UPDATE Users
SET Role = 'Admin'
WHERE Username = 'tan1607';
GO
-- Thêm cột IsDeleted vào bảng SinhVien
ALTER TABLE SinhVien ADD IsDeleted BIT NOT NULL DEFAULT 0;
-- (Tùy chọn) Thêm cả vào bảng Users nếu muốn áp dụng cho cả tài khoản
ALTER TABLE Users ADD IsDeleted BIT NOT NULL DEFAULT 0;
SELECT * FROM Auditlogs;
ALTER TABLE SinhVien ADD RowVersion ROWVERSION;
SELECT Id, HoTen, IsDeleted FROM SinhVien WHERE IsDeleted = 1;
# 🌟 Corn Travel - Hệ thống Quản lý Tour Du lịch

<div align="center">
  <img src="Website_tour/Website_tour/wwwroot/image/LuxTrip&Stay.jpg" alt="Corn Travel Logo" width="200"/>
  
  [![.NET](https://img.shields.io/badge/.NET%208-512BD4?style=for-the-badge&logo=.net&logoColor=white)](https://dotnet.microsoft.com/download)
  [![EF Core](https://img.shields.io/badge/EF%20Core-8-purple?style=for-the-badge)](https://docs.microsoft.com/ef/core)
  [![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
</div>

## 📝 Giới thiệu

Corn Travel là một hệ thống quản lý tour du lịch hiện đại, được xây dựng trên nền tảng .NET 8 với Razor Pages. Hệ thống cung cấp đầy đủ các tính năng cần thiết cho việc quản lý tour du lịch, từ đặt tour đến quản lý người dùng và xử lý thanh toán.

## ✨ Tính năng nổi bật

### 🔐 Bảo mật & Xác thực
- Đăng nhập/Đăng ký với JWT Authentication
- Phân quyền người dùng (Admin/Manager/Customer)
- Xác thực 2 yếu tố qua Email (2FA)
- Quản lý phiên đăng nhập

### 🎯 Quản lý Tour
- CRUD operations cho tour và loại tour
- Tìm kiếm và lọc tour nâng cao
- Quản lý đặt tour và thanh toán
- Hệ thống đánh giá và bình luận

### 📸 Quản lý Media
- Upload nhiều ảnh cùng lúc
- Tích hợp Firebase Storage
- Tối ưu hóa hình ảnh tự động
- Quản lý thư viện ảnh tour

### 📧 Thông báo
- Gửi email xác nhận đặt tour
- Thông báo OTP qua email
- Nhắc nhở lịch trình tour
- Template email tùy chỉnh

## 🛠 Công nghệ sử dụng

### Backend
- **.NET 8**
- **Entity Framework Core**
- **ASP.NET Core Identity**
- **AutoMapper**
- **JWT Authentication**

### Storage & Security
- **Firebase Storage**
- **BCrypt Password Hashing**
- **SQL Server**

### Tools & Libraries
- **Swagger/OpenAPI**
- **Serilog**
- **FluentValidation**
- **SendGrid Email Service**

## 🚀 Hướng dẫn cài đặt

### Yêu cầu hệ thống
```bash
- .NET 8 SDK
- SQL Server 2019+
- Firebase Account
- SMTP Server
Các bước cài đặt
Clone repository
Sao chép
git clone https://github.com/your-username/corn-travel.git
cd corn-travel
Cấu hình appsettings.json
Sao chép
{
  "ConnectionStrings": {
    "DefaultConnection": "Your_Connection_String"
  },
  "Jwt": {
    "ValidIssuer": "your-issuer",
    "ValidAudience": "your-audience",
    "Secret": "your-secret-key"
  },
  "Firebase": {
    "ApiKey": "your-api-key",
    "Bucket": "your-bucket",
    "ProjectId": "your-project-id"
  }
}
Khởi tạo database

update-datebase

## Chạy ứng dụng

dotnet run
## 📚 API Documentation
Authentication

POST /api/account/signin
POST /api/account/signup
POST /api/account/refresh-token
Tour Management

GET    /api/tours
POST   /api/tours
PUT    /api/tours/{id}
DELETE /api/tours/{id}
Image Management

POST   /api/images/upload
DELETE /api/images/{id}
GET    /api/images/tour/{tourId}
🤝 Đóng góp
Chúng tôi luôn chào đón mọi đóng góp từ cộng đồng! Hãy làm theo các bước sau:

Fork dự án
Tạo branch mới (git checkout -b feature/AmazingFeature)
Commit thay đổi (git commit -m 'Add some AmazingFeature')
Push to branch (git push origin feature/AmazingFeature)
Tạo Pull Request
📝 License
Copyright © 2024 Corn Travel.
Project được phát hành dưới giấy phép MIT.

📞 Liên hệ
Website: corntravel.com
Email: sngominhnhut6808.com
GitHub: @Thuan3101

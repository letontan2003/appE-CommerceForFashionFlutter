# 👗 FashionStore Platform - Full-Stack Fashion E-Commerce App

> **Dự án Toàn diện: Ứng dụng Bán Thời Trang Hiện Đại tích hợp Trợ lý Trí Tuệ Nhân Tạo (Chatbox AI)**  
> **👨‍💻 Developer:** **Lê Tôn Tần**  
> **🎯 Mục tiêu dự án:** Dự án cá nhân rèn luyện (train) và nâng cao kỹ năng Full-Stack toàn diện: **Flutter, Java Spring Boot, MongoDB, RESTful API và Chatbox AI**.

---

## 🌟 1. Tổng quan Dự án & Mục tiêu

**FashionStore** là một giải pháp ứng dụng thương mại điện tử chuyên ngành thời trang hoàn chỉnh, kết nối liền mạch giữa ứng dụng di động phía người dùng (**Frontend Flutter**) và hệ thống máy chủ dịch vụ (**Backend Java Spring Boot & MongoDB**).

### 🎯 Mục tiêu phát triển:
- **Project cá nhân phục vụ học tập & rèn luyện (Train):**
  - **Mobile:** Xây dựng ứng dụng di động đa nền tảng hiện đại với **Flutter**, thiết kế UI/UX bắt mắt, hoạt ảnh (animations) mượt mà và tương tác người dùng cao cấp.
  - **Backend:** Xây dựng máy chủ **Java Spring Boot 3** theo kiến trúc phân tầng chuyên nghiệp (Controller - Service - Repository - DTO), bảo mật cao và xử lý dữ liệu tin cậy.
  - **Database:** Khai thác sức mạnh của cơ sở dữ liệu phi quan hệ **MongoDB / MongoDB Atlas** để quản lý danh mục sản phẩm thời trang linh hoạt.
  - **RESTful API:** Chuẩn hóa giao tiếp giữa Client và Server qua các RESTful Endpoints bảo mật, đồng nhất định dạng dữ liệu (`ApiResponse<T>`).
  - **Chatbox AI:** Tích hợp mô hình AI thông minh (Virtual Stylist / Trợ lý thời trang ảo) giúp tư vấn phong cách phối đồ và hỗ trợ chăm sóc khách hàng 24/7.

---

## 🛠️ 2. Công nghệ sử dụng trong toàn bộ hệ thống

```
                             [ KHÁCH HÀNG / MOBILE CLIENT ]
                                           │
                                📱 Flutter Mobile App
                             (Dart / Material 3 / Http)
                                           │
                                  RESTful API (JSON)
                                           │
                                           ▼
                                🚀 Java Spring Boot 3
                               (Spring MVC / Security)
                                     │           │
                 ┌───────────────────┘           └──────────────────┐
                 ▼                                                  ▼
     🗄️ MongoDB Atlas (NoSQL DB)                       🤖 Chatbox AI (Virtual Stylist)
    (Users, Products, Orders,...)                     (Tư vấn phong cách & Hỗ trợ 24/7)
```

| Tầng hệ thống | Công nghệ / Framework | Vai trò chi tiết |
|---|---|---|
| **Mobile Frontend** | **Flutter** (Dart 3.x) | Ứng dụng di động iOS/Android, giao diện người dùng, animations |
| **Backend API** | **Java 17+ / Spring Boot 3** | Xử lý logic nghiệp vụ, quản lý phiên, xác thực, điều phối dữ liệu |
| **Cơ sở dữ liệu** | **MongoDB Atlas** (NoSQL) | Lưu trữ thông tin người dùng, danh mục thời trang, đơn hàng linh hoạt |
| **Kiến trúc giao tiếp**| **RESTful API** | Giao tiếp chuẩn định dạng JSON, phân tách độc lập Frontend - Backend |
| **Bảo mật** | **BCrypt / Dotenv** | Băm mật khẩu người dùng, bảo vệ biến môi trường và thông tin nhạy cảm |
| **Trí tuệ nhân tạo** | **Chatbox AI** | Trợ lý tư vấn phối đồ (Mix & Match), gợi ý trang phục, hỗ trợ khách hàng |

---

## 🛍️ 3. Mô tả Chức năng chính cho App Bán Thời Trang

### 🎨 1. Khám phá & Trải nghiệm giao diện (Onboarding & UI)
- Chuỗi màn hình khởi động (Splash & Onboarding 4 bước) với hiệu ứng chuyển động sống động.
- Màn hình Get Started phong cách thời trang cao cấp với thông điệp *"You want Authentic, here you go! Find it here, buy it now!"*.

### 🔐 2. Quản lý Tài khoản & Phân quyền (Auth & Users)
- Đăng ký, đăng nhập tài khoản nhanh chóng, bảo mật dữ liệu với mã hóa BCrypt.
- Lưu thông tin cá nhân, địa chỉ nhận hàng và tích lũy điểm thưởng thành viên khi mua sắm.
- Phân quyền người dùng: Khách hàng mua sắm (`ROLE_USER`) và Quản trị viên (`ROLE_ADMIN`).

### 👗 3. Danh mục & Chi tiết Sản phẩm Thời trang (Catalog & Products)
- Phân loại sản phẩm đa dạng: Quần áo Nam, Thời trang Nữ, Phụ kiện, Giày dép, Hàng mới về (New Arrivals).
- Bộ lọc thông minh: Lọc theo kích thước (Size S, M, L, XL), màu sắc, thương hiệu và tầm giá.
- Trang chi tiết sản phẩm: Ảnh chất lượng cao, bảng size quy chuẩn, mô tả chất liệu và đánh giá thực tế.

### 🛒 4. Giỏ hàng & Quy trình Đặt hàng (Cart & Checkout)
- Thêm sản phẩm vào giỏ hàng với tùy chọn biến thể (kích cỡ, màu sắc).
- Áp dụng mã giảm giá, voucher khuyến mãi và tính toán điểm thưởng.
- Chọn phương thức thanh toán và theo dõi hành trình đơn hàng từng bước.

### 🤖 5. Chatbox AI - Trợ lý Thời trang Thông minh (Virtual Stylist)
- **Tư vấn trang phục:** Khách hàng có thể chat để xin gợi ý phối đồ theo dịp (đi làm, dự tiệc, hẹn hò, du lịch).
- **Gợi ý theo vóc dáng & thời tiết:** Tư vấn form dáng và màu sắc phù hợp nhất với người dùng.
- **Hỗ trợ khách hàng tự động 24/7:** Giải đáp nhanh các câu hỏi về size đồ, chính sách đổi trả và trạng thái vận chuyển.

---

## 📁 4. Cấu trúc thư mục Dự án

```
c:\DuAnTest/
├── README.md                      # Tài liệu tổng quan toàn bộ hệ thống
├── Be-Train/                      # 🚀 Phân hệ Backend (Java Spring Boot + MongoDB)
│   ├── .env                       # Biến môi trường bảo mật
│   ├── pom.xml                    # Quản lý dependencies Maven
│   ├── README.md                  # Hướng dẫn chi tiết Backend
│   └── src/main/java/...          # Mã nguồn Spring Boot (Controller, Service, Entity, DTO)
└── ProjectTrain/                  # 📱 Phân hệ Frontend (Flutter Mobile App)
    ├── pubspec.yaml               # Thư viện Flutter
    ├── README.md                  # Hướng dẫn chi tiết Frontend Flutter
    └── lib/                       # Mã nguồn Flutter (UI Screens, Services, Animations)
```

---

## 🚀 5. Hướng dẫn Khởi chạy Hệ thống

### Bước 1: Khởi động Backend Spring Boot
Xem tài liệu chi tiết tại [Be-Train README](file:///c:/DuAnTest/Be-Train/README.md).
```bash
cd c:\DuAnTest\Be-Train
mvn clean spring-boot:run
```
> Server sẽ khởi chạy tại `http://localhost:8080`.

### Bước 2: Khởi động Ứng dụng Di động Flutter
Xem tài liệu chi tiết tại [ProjectTrain README](file:///c:/DuAnTest/ProjectTrain/README.md).
```bash
cd c:\DuAnTest\ProjectTrain
flutter pub get
flutter run
```

---

## 👨‍💻 Thông tin Tác giả
- **Developer:** **Lê Tôn Tần**
- **Dự án:** Ứng dụng Bán Thời Trang (Personal Train Project)
- **Email:** ltontan03@gmail.com
- **Mục tiêu:** Trau dồi kỹ năng chuyên sâu Full-Stack Mobile & Backend (Flutter, Spring Boot, MongoDB, REST API, Chatbox AI).


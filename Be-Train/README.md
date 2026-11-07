# 🛍️ FashionStore Backend - Java Spring Boot & MongoDB RESTful API

> **Dự án Backend cho Hệ thống Ứng dụng Mua sắm Thời trang (Fashion E-Commerce Platform)**  
> **Developer:** **Lê Tôn Tần**  
> **Mục tiêu:** Project cá nhân chuyên sâu phục vụ học tập, rèn luyện (train) và hoàn thiện kỹ năng Full-Stack: **Java Spring Boot, MongoDB, RESTful API, Flutter, tích hợp Chatbox AI**.

---

## 📌 1. Giới thiệu dự án & Mục tiêu

Dự án **FashionStore Backend** là nền tảng máy chủ cung cấp hệ thống RESTful API an toàn, hiệu năng cao và mở rộng cho ứng dụng di động bán thời trang. Được xây dựng theo kiến trúc phân tầng chuẩn doanh nghiệp (Layered Architecture), dự án xử lý logic nghiệp vụ, quản lý tài khoản, danh mục thời trang, giỏ hàng, đơn hàng và kết nối với dịch vụ trợ lý ảo **Chatbox AI**.

### 🎯 Mục tiêu phát triển:
- **Thực hành & Nâng cao kỹ năng (Train):** Làm chủ hệ sinh thái **Java Spring Boot 3** hiện đại và cơ sở dữ liệu NoSQL **MongoDB Atlas**.
- **Chuẩn hóa API:** Thiết kế RESTful API chuẩn mực với cơ chế phản hồi đồng nhất (`ApiResponse<T>`), validation chặt chẽ và xử lý ngoại lệ tập trung (`GlobalExceptionHandler`).
- **Bảo mật & Tối ưu:** Mã hóa mật khẩu người dùng với thuật toán băm **BCrypt**, bảo vệ thông tin cá nhân và cấu hình biến môi trường an toàn (`.env`).
- **Sẵn sàng tích hợp đa nền tảng:** Kết nối mượt mà với ứng dụng di động **Flutter** và module **Chatbox AI** (Trợ lý thời trang thông minh).

---

## 🛠️ 2. Công nghệ & Thư viện sử dụng

| Phân loại | Công nghệ / Thư viện | Mô tả |
|---|---|---|
| **Ngôn ngữ** | Java 17+ | Ngôn ngữ hướng đối tượng mạnh mẽ, an toàn |
| **Framework chính** | Spring Boot 3.x | Nền tảng phát triển ứng dụng Java Enterprise |
| **Web & REST** | Spring Web (Spring MVC) | Xây dựng RESTful Web Services |
| **Cơ sở dữ liệu** | MongoDB / MongoDB Atlas | Hệ quản trị CSDL NoSQL linh hoạt, mở rộng cao |
| **Truy cập dữ liệu** | Spring Data MongoDB | Thao tác dữ liệu với MongoRepository |
| **Bảo mật** | Spring Security Crypto | Mã hóa mật khẩu an toàn với BCrypt |
| **Validation** | Jakarta Bean Validation | Kiểm tra tính hợp lệ của dữ liệu đầu vào |
| **Cấu hình môi trường** | Dotenv-Java (`cdimascio:dotenv-java`) | Bảo mật thông tin kết nối và API keys qua file `.env` |
| **Tiện ích code** | Project Lombok | Tự động sinh Getter, Setter, Builder, Constructor |
| **Quản lý dependencies** | Apache Maven | Quản lý vòng đời build và thư viện dự án |
| **Kiểm thử API** | Postman / cURL | Test và tài liệu hóa các endpoint |

---

## 👔 3. Chức năng chính cho App Bán Thời Trang (Hệ thống API)

### 🔐 1. Xác thực & Quản lý Tài khoản (Authentication & User)
- **Đăng ký tài khoản mới:** Mã hóa mật khẩu tự động với BCrypt, kiểm tra tính duy nhất của Email.
- **Đăng nhập hệ thống:** Xác thực thông tin, trả về token và thông tin người dùng an toàn (UserResponse).
- **Hồ sơ cá nhân:** Cập nhật thông tin, địa chỉ nhận hàng, số điện thoại, điểm thưởng thành viên (`diemThuong`).
- **Phân quyền người dùng:** Quản lý quyền hạn `ROLE_USER` (Khách hàng) và `ROLE_ADMIN` (Quản trị viên).

### 👗 2. Quản lý Danh mục & Sản phẩm Thời trang (Catalog & Products)
- Quản lý danh mục đa cấp: Thời trang Nam, Nữ, Unisex, Giày dép, Phụ kiện, Bộ sưu tập mới nhất.
- Chi tiết sản phẩm phong phú: Biến thể màu sắc, kích cỡ (S, M, L, XL,...), số lượng tồn kho, giá bán và khuyến mãi.
- Tìm kiếm & Lọc thông minh: Lọc theo khoảng giá, danh mục, màu sắc, size và độ hot.

### 🛒 3. Giỏ hàng & Quản lý Đơn hàng (Cart & Order Management)
- Thêm/bớt, cập nhật số lượng và chọn biến thể sản phẩm trong giỏ hàng.
- Xử lý quy trình đặt hàng, tính toán điểm tích lũy, áp dụng mã ưu đãi/voucher.
- Theo dõi trạng thái đơn hàng (Chờ xác nhận, Đang chuẩn bị, Đang giao, Đã giao, Đã hủy).

### 🤖 4. Tích hợp Chatbox AI - Trợ lý Thời trang Thông minh (AI Fashion Stylist)
- Cung cấp API kết nối giữa Client Flutter và các mô hình AI (như Google Gemini API).
- Hỗ trợ tư vấn phối đồ (Mix & Match) dựa trên sở thích, vóc dáng, giới tính và thời tiết.
- Tự động hóa giải đáp thắc mắc khách hàng 24/7 (chính sách đổi trả, size fitting, tra cứu trạng thái đơn hàng).

---

## 📂 4. Cấu trúc thư mục (Layered Architecture)

```
Be-Train/
├── .env                              # Biến môi trường cục bộ (bảo mật, không commit Git)
├── .env.example                      # File mẫu hướng dẫn cấu hình biến môi trường
├── .gitignore                        # Bỏ qua tệp build, tệp nhạy cảm
├── pom.xml                           # Cấu hình Maven dependencies
├── README.md                         # Tài liệu hướng dẫn Backend
└── src/
    ├── main/
    │   ├── java/com/projecttrain/
    │   │   ├── BeTrainApplication.java            # Khởi động ứng dụng Spring Boot & nạp .env
    │   │   ├── config/
    │   │   │   ├── MongoConnectionRunner.java     # Tự động ping và kiểm tra kết nối MongoDB Atlas
    │   │   │   ├── PasswordEncoderConfig.java     # Cấu hình BCryptPasswordEncoder
    │   │   │   └── WebConfig.java                 # Cấu hình CORS cho Flutter Mobile & Web Client
    │   │   ├── controller/
    │   │   │   ├── AuthController.java            # Endpoints Đăng ký, Đăng nhập
    │   │   │   ├── HealthCheckController.java     # Kiểm tra sức khỏe Server & Database
    │   │   │   └── UserController.java            # REST API quản trị người dùng
    │   │   ├── dto/
    │   │   │   ├── request/                       # DTO nhận dữ liệu gửi lên từ Client
    │   │   │   │   ├── CreateUserRequest.java
    │   │   │   │   ├── LoginRequest.java
    │   │   │   │   ├── RegisterRequest.java
    │   │   │   │   └── UpdateUserRequest.java
    │   │   │   └── response/                      # DTO trả về Client (an toàn, ẩn mật khẩu)
    │   │   │       ├── ApiResponse.java           # Định dạng JSON chuẩn hệ thống
    │   │   │       └── UserResponse.java
    │   │   ├── entity/
    │   │   │   └── User.java                      # Schema User lưu trên MongoDB
    │   │   ├── exception/
    │   │   │   ├── AppException.java              # Lỗi nghiệp vụ tùy biến
    │   │   │   ├── ResourceNotFoundException.java # Lỗi không tìm thấy tài nguyên (404)
    │   │   │   └── GlobalExceptionHandler.java    # Bắt và format tập trung mọi Exception
    │   │   ├── repository/
    │   │   │   └── UserRepository.java            # Tương tác với MongoDB qua Spring Data
    │   │   └── service/
    │   │       ├── UserService.java               # Interface nghiệp vụ
    │   │       └── impl/
    │   │           └── UserServiceImpl.java       # Triển khai nghiệp vụ (băm mật khẩu, kiểm tra trùng)
    │   └── resources/
    │       └── application.properties             # Ánh xạ thuộc tính từ file .env
    └── test/
        └── java/com/projecttrain/
            └── BeTrainApplicationTests.java
```

---

## 📡 5. Danh sách REST API Endpoints hiện tại

### 🩺 1. Health Check
| Method | Endpoint | Mô tả |
|---|---|---|
| `GET` | `/api/v1/health` | Kiểm tra tình trạng hoạt động của Spring Server & MongoDB |

### 🔐 2. Xác thực (Authentication)
| Method | Endpoint | Request Body | Mô tả |
|---|---|---|---|
| `POST` | `/api/v1/auth/register` | `RegisterRequest` (`email`, `tenKH`, `passWord`, `confirmPassWord`) | Đăng ký tài khoản người dùng mới |
| `POST` | `/api/v1/auth/login` | `LoginRequest` (`email`, `passWord`) | Đăng nhập và xác thực tài khoản |

### 👤 3. Quản lý Người dùng (Users Management)
| Method | Endpoint | Request Body | Mô tả |
|---|---|---|---|
| `POST` | `/api/v1/users` | `CreateUserRequest` | Tạo người dùng mới (dành cho Admin) |
| `GET` | `/api/v1/users` | None | Lấy danh sách toàn bộ người dùng |
| `GET` | `/api/v1/users/{id}` | None | Lấy thông tin người dùng theo `maKH` |
| `GET` | `/api/v1/users/by-email?email=...` | None | Tra cứu người dùng theo địa chỉ Email |
| `PUT` | `/api/v1/users/{id}` | `UpdateUserRequest` | Cập nhật thông tin người dùng |
| `DELETE` | `/api/v1/users/{id}` | None | Xóa người dùng theo ID |

---

## ⚙️ 6. Cấu hình & Hướng dẫn khởi chạy

### Bước 1: Chuẩn bị file `.env`
Tạo file `.env` tại thư mục `Be-Train/.env`:
```env
PORT=8080
MONGODB_URI=mongodb+srv://<username>:<password>@cluster.mongodb.net/FashionAppFlutter?retryWrites=true&w=majority
DB_NAME=FashionAppFlutter
```

### Bước 2: Chạy ứng dụng

#### Lựa chọn 1: Sử dụng Maven dòng lệnh
```bash
cd c:\DuAnTest\Be-Train
mvn clean spring-boot:run
```

#### Lựa chọn 2: Sử dụng IDE (IntelliJ IDEA / VS Code / STS)
1. Mở thư mục `Be-Train` trong IDE.
2. Chờ Maven tải xong các thư viện trong `pom.xml`.
3. Chạy file [BeTrainApplication.java](file:///c:/DuAnTest/Be-Train/src/main/java/com/projecttrain/BeTrainApplication.java).
4. Quan sát log khởi động để kiểm tra kết nối MongoDB thành công:
```log
============================================================
  KẾT NỐI MONGODB THÀNH CÔNG RỰC RỠ!
  Database Name        : FashionAppFlutter
  Ping Status          : 1
============================================================
```

---

## 👨‍💻 Tác giả
- **Developer:** **Lê Tôn Tần**
- **Dự án:** Ứng dụng Bán Thời Trang (Personal Train Project)
- **Email / Liên hệ:** ltontan03@gmail.com

# 📱 FashionStore Mobile App - Flutter Frontend

> **Ứng dụng Mua sắm Thời trang Trực tuyến Hiện đại (Modern Fashion E-Commerce Mobile App)**  
> **Developer:** **Lê Tôn Tần**  
> **Mục tiêu:** Dự án cá nhân rèn luyện và nâng cao kỹ năng (Train): **Flutter (Dart), RESTful API Integration, State Management, UI/UX Animation và Chatbox AI**.

---

## 📌 1. Giới thiệu dự án & Mục tiêu

**FashionStore Mobile App** là ứng dụng di động mua sắm thời trang cao cấp được phát triển bằng **Flutter**. Ứng dụng mang đến trải nghiệm người dùng mượt mà, giao diện tinh tế, hiện đại với tông màu sang trọng và tích hợp trợ lý thời trang thông minh **Chatbox AI**.

### 🎯 Mục tiêu phát triển:
- **Thực hành & Rèn luyện kỹ năng (Train):**
  - Xây dựng giao diện di động chuẩn UI/UX với Flutter, tối ưu hiệu năng hiển thị trên cả **Android** và **iOS**.
  - Xử lý các hiệu ứng chuyển động chuyên sâu (CurvedAnimation, Tween, Hero Animation, Page Transitions).
  - Tích hợp gọi RESTful API từ máy chủ Backend **Java Spring Boot**, đồng bộ dữ liệu với **MongoDB**.
  - Nghiên cứu và tích hợp mô hình **Chatbox AI** (Trợ lý tư vấn thời trang thông minh / Virtual Stylist) hỗ trợ người mua hàng 24/7.
- **Tiêu chuẩn sản phẩm:** Thiết kế responsive, xử lý trạng thái bất đồng bộ an toàn, quản lý lỗi mạng linh hoạt và giao diện thân thiện với người dùng.

---

## 🛠️ 2. Công nghệ & Thư viện sử dụng

| Công nghệ / Thư viện | Phiên bản | Vai trò & Mục đích |
|---|---|---|
| **Flutter SDK** | `>=3.3.4 <4.0.0` | Framework đa nền tảng cho Mobile (Android & iOS) |
| **Dart** | 3.x | Ngôn ngữ lập trình chính với cơ chế type-safe |
| **http** | `^1.2.1` | Thực hiện các yêu cầu HTTP kết nối REST API Spring Boot |
| **Cupertino Icons & Material 3** | Latest | Hệ thống Iconography và thiết kế giao diện hiện đại |
| **Animation Framework** | Flutter Built-in | SingleTickerProvider, Fade & Scale Animation, Hero Widget |
| **Chatbox AI Integration** | REST / AI SDK | Module hội thoại thông minh tư vấn phong cách (Stylist AI) |

---

## ✨ 3. Các chức năng chính của App Bán Thời Trang

### 🎨 1. Trải nghiệm Khởi động & Giới thiệu (Onboarding & Splash Flow)
- **Chuỗi Splash Screens tương tác (4 màn hình):**
  - Hiệu ứng Fade & Scale mượt mà khi ứng dụng khởi chạy.
  - Bộ thanh trượt Onboarding hiển thị thông điệp giới thiệu thời trang với chỉ số trang tương tác (1/3, 2/3, 3/3).
  - Dots indicator hiệu ứng Hero chuyển động uyển chuyển khi lướt qua các trang.
- **Màn hình Get Started:**
  - Thiết kế thời thượng với lớp phủ Gradient nghệ thuật.
  - Lời chào mừng cá nhân hóa sau khi đăng nhập thành công.

### 🔐 2. Đăng ký & Đăng nhập (Authentication Flow)
- **Đăng nhập (Sign In):** Xác thực tài khoản với Email và Mật khẩu, hiển thị/ẩn mật khẩu linh hoạt, lưu phiên làm việc.
- **Đăng ký (Sign Up):** Kiểm tra hợp lệ dữ liệu (Email chuẩn, mật khẩu khớp với xác nhận mật khẩu), kết nối API tạo tài khoản.
- **Tự động thích ứng mạng (`AuthService`):**
  - Nhận diện môi trường chạy: Android Emulator (`10.0.2.2`), Thiết bị thật / Web (`localhost` / IP LAN).
  - Timeout an toàn và hiển thị thông báo lỗi chi tiết (SnackBar) khi kết nối thất bại.

### 👗 3. Khám phá & Mua sắm Thời trang (Shopping Experience)
- **Trang chủ & Bộ sưu tập:** Duyệt trang phục Hot Trend, Quần áo Nam, Thời trang Nữ, Phụ kiện, Giày dép theo mùa.
- **Bộ lọc & Tìm kiếm:** Lọc sản phẩm theo tầm giá, kích thước (Size S, M, L, XL), bảng màu và nhãn hàng.
- **Chi tiết sản phẩm:** Thư viện ảnh sản phẩm sắc nét, thông số kích thước (Size Chart), đánh giá từ khách hàng đã mua.

### 🛒 4. Giỏ hàng & Thanh toán (Cart & Checkout)
- Quản lý giỏ hàng: Chọn kích cỡ, màu sắc, tăng giảm số lượng sản phẩm.
- Áp dụng mã giảm giá / Voucher khuyến mãi dành cho thành viên.
- Quản lý địa chỉ giao hàng và phương thức thanh toán an toàn, tiện lợi.

### 🤖 5. Chatbox AI - Trợ lý Thời trang Ảo (AI Stylist & Customer Support)
- **Tư vấn phong cách thông minh:** Gợi ý cách phối đồ (Mix & Match) cho từng sự kiện (đi tiệc, công sở, dạo phố, du lịch).
- **Gợi ý trang phục theo thời tiết & vóc dáng:** Chat trực tiếp với AI để chọn mẫu đồ tôn dáng và hợp gu nhất.
- **Chăm sóc khách hàng tự động 24/7:** Hỗ trợ giải đáp size, tư vấn chính sách đổi trả hàng và tra cứu đơn hàng nhanh chóng.

---

## 📁 4. Cấu trúc thư mục nguồn Flutter (`lib/`)

```
ProjectTrain/lib/
├── main.dart                 # Điểm khởi chạy ứng dụng, cấu hình Theme & Router
├── splash_screen_1.dart      # Màn hình Splash đầu tiên với hiệu ứng Fade/Scale
├── splash_screen_2.dart      # Onboarding Slide 1 (Khám phá phong cách)
├── splash_screen_3.dart      # Onboarding Slide 2 (Ưu đãi & Xu hướng)
├── splash_screen_4.dart      # Onboarding Slide 3 (Mua sắm nhanh chóng)
├── sign_in_screen.dart       # Giao diện Đăng nhập & Xác thực người dùng
├── sign_up_screen.dart       # Giao diện Đăng ký tài khoản thời trang
├── get_started_screen.dart   # Màn hình chào đón & sẵn sàng trải nghiệm mua sắm
└── services/
    └── auth_service.dart     # Service gọi REST API (Đăng nhập, Đăng ký) tới Spring Boot
```

---

## 🚀 5. Hướng dẫn cài đặt & Chạy ứng dụng

### 1. Yêu cầu môi trường
- Đã cài đặt [Flutter SDK](https://docs.flutter.dev/get-started/install) (phiên bản `>= 3.3.4`).
- Android Studio / VS Code đã cấu hình Flutter & Dart plugins.
- Máy ảo Android Emulator hoặc thiết bị thật kết nối qua USB Debugging.
- **Lưu ý:** Đảm bảo Backend [Be-Train](file:///c:/DuAnTest/Be-Train) đã được khởi động ở cổng `8080`.

### 2. Cài đặt dependencies
Mở Terminal tại thư mục `ProjectTrain`:
```bash
cd c:\DuAnTest\ProjectTrain
flutter pub get
```

### 3. Cấu hình địa chỉ IP kết nối Backend
Trong file [lib/services/auth_service.dart](file:///c:/DuAnTest/ProjectTrain/lib/services/auth_service.dart):
- Nếu chạy trên **Android Emulator**: Sử dụng `http://10.0.2.2:8080/api/v1` (mặc định đã cấu hình sẵn).
- Nếu chạy trên **Thiết bị thật (Real Device)**: Đổi thành địa chỉ IP LAN của máy tính host (ví dụ: `http://192.168.1.x:8080/api/v1`).
- Nếu chạy trên **Web / Chrome**: Sử dụng `http://localhost:8080/api/v1`.

### 4. Khởi chạy ứng dụng
```bash
# Chạy trên thiết bị mặc định
flutter run

# Hoặc chỉ định thiết bị
flutter run -d chrome
flutter run -d emulator-5554
```

---

## 👨‍💻 Tác giả
- **Developer:** **Lê Tôn Tần**
- **Dự án:** Ứng dụng Di Động Bán Thời Trang (Personal Train Project)
- **Liên hệ:** ltontan03@gmail.com

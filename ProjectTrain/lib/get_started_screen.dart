// Nhập thư viện Flutter material
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Màn hình Get Started sau khi đăng nhập thành công
class GetStartedScreen extends StatelessWidget {
  final Map<String, dynamic>? user;

  const GetStartedScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    // Cấu hình thanh trạng thái hiển thị icon sáng (trắng) trên nền ảnh tối
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Hình ảnh nền toàn màn hình
          Image.asset(
            'assets/imageStater.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              // Dự phòng nếu không tìm thấy ảnh
              return Container(
                color: const Color(0xFF1E293B),
                child: const Center(
                  child: Icon(Icons.checkroom, size: 80, color: Colors.white24),
                ),
              );
            },
          ),

          // 2. Lớp phủ Gradient tối từ giữa xuống đáy giúp chữ nổi bật
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.35, 0.7, 1.0],
                colors: [
                  Colors.black.withOpacity(0.05),
                  Colors.transparent,
                  Colors.black.withOpacity(0.65),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),

          // 3. Nội dung chữ và nút bấm đặt phía dưới màn hình
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Tiêu đề chính
                  const Text(
                    'You want\nAuthentic, here\nyou go!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Phụ đề mô tả
                  const Text(
                    'Find it here, buy it now!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF2F2F2),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                    ),
                  ),

                  const SizedBox(height: 38),

                  // Nút Get Started
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        final tenKH = user?['tenKH'] ?? 'bạn';
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Chào mừng $tenKH đến với ứng dụng!',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                            backgroundColor: const Color(0xFFF83758),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF83758),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

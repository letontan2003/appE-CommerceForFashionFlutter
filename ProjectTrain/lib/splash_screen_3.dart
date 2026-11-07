// Nhập thư viện Flutter material
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'splash_screen_4.dart';

// Định nghĩa màn hình SplashScreen3 (Onboarding 2/3)
class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({super.key});

  @override
  // Xây dựng giao diện màn hình
  Widget build(BuildContext context) {
    // Cấu hình thanh trạng thái hiển thị icon tối, nền trong suốt
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    // Lấy kích thước màn hình
    final size = MediaQuery.of(context).size;

    // Khung màn hình chính
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            // Thanh tiêu đề trên cùng (Số trang và nút Skip)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Hiển thị chỉ số trang 2/3
                  RichText(
                    text: const TextSpan(
                      text: '2',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: '/3',
                          style: TextStyle(
                            color: Color(0xFFA0A0A1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Nút bỏ qua (Skip)
                  GestureDetector(
                    onTap: () {
                      // Xử lý khi nhấn Skip
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Khoảng đệm co giãn linh hoạt
            const Spacer(),

            // Hình ảnh minh họa chính giữa (Make Payment)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Image.asset(
                'assets/image2.png',
                width: size.width * 0.85,
                height: size.height * 0.38,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Widget dự phòng nếu không tải được ảnh
                  return const SizedBox(
                    height: 250,
                    child: Center(
                      child: Icon(Icons.payment, size: 100, color: Color(0xFFF83758)),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // Tiêu đề nổi bật
            const Text(
              'Make Payment',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 12),

            // Nội dung mô tả chi tiết
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.0),
              child: Text(
                'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFA8A8A9),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),

            // Khoảng đệm co giãn linh hoạt
            const Spacer(),

            // Thanh điều hướng đáy màn hình (Prev, Dots indicator, Next)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Nút quay lại trang trước (Prev) ở mép trái
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        // Quay lại màn hình 2 với hiệu ứng mượt mà
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Prev',
                        style: TextStyle(
                          color: Color(0xFFC4C4C4),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Dãy chấm chỉ số trang (Dots) với animation Hero chuyển tiếp
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Chấm trang 1 (không kích hoạt)
                      Hero(
                        tag: 'indicator_dot_0',
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFDEDBDB),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Chấm trang 2 (kích hoạt - thanh dài)
                      Hero(
                        tag: 'indicator_dot_1',
                        child: Container(
                          width: 40,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFF17223B),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Chấm trang 3 (không kích hoạt)
                      Hero(
                        tag: 'indicator_dot_2',
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFDEDBDB),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Nút chuyển trang kế tiếp (Next) ở mép phải
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Chuyển sang màn hình 4 với hiệu ứng trượt mượt mà
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                const SplashScreen4(),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOutCubic;
                              final tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Color(0xFFF83758),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

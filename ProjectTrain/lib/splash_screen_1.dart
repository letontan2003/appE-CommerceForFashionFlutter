// Nhập thư viện Flutter material
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Nhập màn hình splash screen 2
import 'splash_screen_2.dart';

// Định nghĩa widget SplashScreen
class SplashScreen1 extends StatefulWidget {
  final VoidCallback? onNext;
  final Duration duration;

  const SplashScreen1({
    super.key,
    this.onNext,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

// Cài đặt State cho splash screen
class _SplashScreen1State extends State<SplashScreen1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  // Khởi tạo animation
  void initState() {
    super.initState();

    // Controller cho animation (1.2s)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Animation độ trong suốt (fade)
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Animation thu phóng (scale) (92% → 100%)
    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Bắt đầu animation
    _controller.forward();

    // Tự động chuyển trang mượt mà sang screen 2 sau thời gian chờ
    Future.delayed(widget.duration, () {
      if (!mounted) return;

      if (widget.onNext != null) {
        widget.onNext?.call();
      } else {
        // Chuyển trang với hiệu ứng FadeTransition mượt mà
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SplashScreen2(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  // Giải phóng controller animation
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  // Xây dựng UI
  Widget build(BuildContext context) {
    // Cấu hình UI hệ thống (status bar trong suốt, icon tối)
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
    final screenWidth = MediaQuery.of(context).size.width;
    final logoWidth = screenWidth * 0.65; // Standard logo size

    // Scaffold layout
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          // Wrapper cho fade animation
          child: FadeTransition(
            opacity: _fadeAnimation,
            // Wrapper cho scale animation
            child: ScaleTransition(
              scale: _scaleAnimation,
              // Hình ảnh logo
              child: Image.asset(
                'assets/logo.png',
                width: logoWidth.clamp(200.0, 320.0),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Hình dự phòng nếu logo không tải
                  return Image.asset(
                    'assets/logo.png',
                    width: logoWidth.clamp(200.0, 320.0),
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

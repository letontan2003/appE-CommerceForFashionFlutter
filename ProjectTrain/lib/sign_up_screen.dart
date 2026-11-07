// Nhập thư viện Flutter material
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Nhập màn hình đăng nhập
import 'sign_in_screen.dart';
// Nhập AuthService kết nối backend Spring Boot
import 'services/auth_service.dart';

// Định nghĩa màn hình Đăng ký (SignUpScreen)
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

// Trạng thái quản lý dữ liệu và UI màn hình đăng ký
class _SignUpScreenState extends State<SignUpScreen> {
  // Controller cho ô nhập email
  final TextEditingController _emailController = TextEditingController();
  // Controller cho ô nhập tên người dùng
  final TextEditingController _usernameController = TextEditingController();
  // Controller cho ô nhập mật khẩu
  final TextEditingController _passwordController = TextEditingController();
  // Controller cho ô xác nhận mật khẩu
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Biến trạng thái ẩn/hiện mật khẩu
  bool _obscurePassword = true;
  // Biến trạng thái ẩn/hiện xác nhận mật khẩu
  bool _obscureConfirmPassword = true;

  // Biến trạng thái loading khi gửi request
  bool _isLoading = false;

  @override
  // Giải phóng bộ nhớ controller
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Hàm hiển thị thông báo SnackBar
  void _showSnackBar(String message, {bool isError = true}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: isError ? const Color(0xFFD32F2F) : const Color(0xFF388E3C),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Hàm xử lý tạo tài khoản & Validate
  Future<void> _handleSignUp() async {
    final email = _emailController.text.trim();
    final userName = _usernameController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // 1. Validate Email
    if (email.isEmpty) {
      _showSnackBar('Vui lòng nhập địa chỉ Email!');
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      _showSnackBar('Email không đúng định dạng (Ví dụ: name@example.com)!');
      return;
    }

    // 2. Validate UserName
    if (userName.isEmpty) {
      _showSnackBar('Vui lòng nhập Tên người dùng (UserName)!');
      return;
    }
    if (userName.length < 2) {
      _showSnackBar('UserName phải có ít nhất 2 ký tự!');
      return;
    }

    // 3. Validate Password
    if (password.isEmpty) {
      _showSnackBar('Vui lòng nhập Mật khẩu!');
      return;
    }
    if (password.length < 6) {
      _showSnackBar('Mật khẩu phải có ít nhất 6 ký tự!');
      return;
    }

    // 4. Validate Confirm Password
    if (confirmPassword.isEmpty) {
      _showSnackBar('Vui lòng nhập Xác nhận mật khẩu!');
      return;
    }
    if (password != confirmPassword) {
      _showSnackBar('Mật khẩu xác nhận không khớp!');
      return;
    }

    // Bắt đầu gọi API
    setState(() {
      _isLoading = true;
    });

    final result = await AuthService.register(
      email: email,
      userName: userName,
      password: password,
      confirmPassword: confirmPassword,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (result['success'] == true) {
      final data = result['data'] as Map<String, dynamic>?;
      final maKH = data?['maKH'] ?? '';

      // Thông báo thành công kèm mã KH
      _showSnackBar('Đăng ký thành công! Mã KH của bạn: $maKH', isError: false);

      // Chuyển hướng sang màn hình Đăng nhập sau 1 giây
      await Future.delayed(const Duration(milliseconds: 1200));
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SignInScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    } else {
      // Hiển thị lỗi từ Backend (ví dụ email đã tồn tại, username đã tồn tại...)
      _showSnackBar(result['message'] ?? 'Đăng ký tài khoản thất bại!');
    }
  }

  @override
  // Xây dựng giao diện màn hình đăng ký
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

    // Khung màn hình chính
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // Cho phép cuộn khi hiển thị bàn phím
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36),

              // Tiêu đề Create an account
              const Text(
                'Create an\naccount',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 32),

              // Ô nhập Email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: const TextStyle(
                    color: Color(0xFF676767),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xFF626262),
                    size: 22,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF3F3F3),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFA8A8A9), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFF83758), width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Ô nhập UserName
              TextField(
                controller: _usernameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'UserName',
                  hintStyle: const TextStyle(
                    color: Color(0xFF676767),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color(0xFF626262),
                    size: 22,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF3F3F3),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFA8A8A9), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFF83758), width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Ô nhập mật khẩu
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    color: Color(0xFF676767),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Color(0xFF626262),
                    size: 22,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: const Color(0xFF626262),
                      size: 22,
                    ),
                    onPressed: () {
                      // Bật tắt ẩn hiện mật khẩu
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF3F3F3),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFA8A8A9), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFF83758), width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Ô nhập xác nhận mật khẩu
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  hintText: 'ConfirmPassword',
                  hintStyle: const TextStyle(
                    color: Color(0xFF676767),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Color(0xFF626262),
                    size: 22,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: const Color(0xFF626262),
                      size: 22,
                    ),
                    onPressed: () {
                      // Bật tắt ẩn hiện xác nhận mật khẩu
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF3F3F3),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFA8A8A9), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFF83758), width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Đoạn điều khoản đăng ký
              RichText(
                text: const TextSpan(
                  text: 'By clicking the ',
                  style: TextStyle(
                    color: Color(0xFF676767),
                    fontSize: 12,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(
                      text: 'Register',
                      style: TextStyle(
                        color: Color(0xFFFF4B26),
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: ' button, you agree\nto the public offer',
                      style: TextStyle(
                        color: Color(0xFF676767),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // Nút tạo tài khoản (Create Account)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF83758),
                    disabledBackgroundColor: const Color(0xFFF83758).withOpacity(0.6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 48),

              // Dòng chữ phân cách đăng nhập qua mạng xã hội
              const Center(
                child: Text(
                  '- OR Continue with -',
                  style: TextStyle(
                    color: Color(0xFF575757),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Hàng nút đăng nhập bằng mạng xã hội (Google, Apple, Facebook)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nút Google
                  _SocialButton(
                    onTap: () {
                      // Đăng nhập Google
                    },
                    child: const CustomPaint(
                      size: Size(24, 24),
                      painter: _GoogleLogoPainter(),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // Nút Apple
                  _SocialButton(
                    onTap: () {
                      // Đăng nhập Apple
                    },
                    child: const Icon(
                      Icons.apple,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(width: 14),

                  // Nút Facebook
                  _SocialButton(
                    onTap: () {
                      // Đăng nhập Facebook
                    },
                    child: const Icon(
                      Icons.facebook,
                      size: 30,
                      color: Color(0xFF1877F2),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Dòng chữ dẫn đến đăng nhập tài khoản đã có (Login)
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Chuyển về màn hình đăng nhập (SignInScreen)
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              const SignInScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    }
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'I Already Have an Account ',
                      style: TextStyle(
                        color: Color(0xFF575757),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Color(0xFFF83758),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFF83758),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget nút mạng xã hội dạng hình tròn với viền đỏ hồng
class _SocialButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _SocialButton({
    required this.child,
    required this.onTap,
  });

  @override
  // Xây dựng giao diện nút mạng xã hội
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: const Color(0xFFFCF3F6),
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFF83758),
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

// CustomPainter vẽ biểu tượng Google chuẩn 4 màu
class _GoogleLogoPainter extends CustomPainter {
  const _GoogleLogoPainter();

  @override
  // Vẽ các cung màu của biểu tượng Google
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final center = Offset(w / 2, h / 2);
    final radius = w / 2;
    final strokeWidth = w * 0.22;
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Cung màu đỏ (Top - Left)
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(rect, -3.14159 * 0.75, 3.14159 * 0.5, false, paint);

    // Cung màu vàng (Bottom - Left)
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(rect, -3.14159 * 0.25 - 3.14159, 3.14159 * 0.5, false, paint);

    // Cung màu xanh lá (Bottom)
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(rect, 0.15, 3.14159 * 0.45, false, paint);

    // Cung màu xanh dương (Right)
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(rect, -3.14159 * 0.25, 3.14159 * 0.4, false, paint);

    // Thanh ngang màu xanh dương
    final linePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTRB(w * 0.48, h * 0.39, w * 0.96, h * 0.61),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


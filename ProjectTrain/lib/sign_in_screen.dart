// Nhập thư viện Flutter material
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Nhập màn hình đăng ký
import 'sign_up_screen.dart';
// Nhập màn hình Get Started
import 'get_started_screen.dart';
// Nhập AuthService kết nối backend Spring Boot
import 'services/auth_service.dart';

// Định nghĩa màn hình Đăng nhập (SignInScreen)
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

// Trạng thái quản lý dữ liệu và UI màn hình đăng nhập
class _SignInScreenState extends State<SignInScreen> {
  // Controller cho ô nhập tài khoản / email
  final TextEditingController _usernameController = TextEditingController();
  // Controller cho ô nhập mật khẩu
  final TextEditingController _passwordController = TextEditingController();
  // Biến trạng thái ẩn/hiện mật khẩu
  bool _obscurePassword = true;

  // Biến trạng thái loading khi gửi request
  bool _isLoading = false;

  @override
  // Giải phóng bộ nhớ controller
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
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

  // Hàm xử lý đăng nhập & Validate
  Future<void> _handleSignIn() async {
    final emailOrUsername = _usernameController.text.trim();
    final password = _passwordController.text;

    // 1. Validate Email hoặc UserName
    if (emailOrUsername.isEmpty) {
      _showSnackBar('Vui lòng nhập Email hoặc UserName!');
      return;
    }

    // 2. Validate Password
    if (password.isEmpty) {
      _showSnackBar('Vui lòng nhập Mật khẩu!');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await AuthService.login(
      emailOrUsername: emailOrUsername,
      password: password,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (result['success'] == true) {
      final data = result['data'] as Map<String, dynamic>?;
      final tenKH = data?['tenKH'] ?? 'Khách hàng';

      _showSnackBar('Đăng nhập thành công! Xin chào $tenKH', isError: false);

      // Chuyển tiếp mượt mà sang màn hình GetStartedScreen
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              GetStartedScreen(user: data),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
        ),
      );
    } else {
      // Hiển thị lỗi từ backend
      _showSnackBar(result['message'] ?? 'Đăng nhập thất bại!');
    }
  }

  @override
  // Xây dựng giao diện màn hình đăng nhập
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
        // Cho phép cuộn khi bàn phím mở lên
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36),

              // Tiêu đề chào mừng
              const Text(
                'Welcome\nBack!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 36),

              // Ô nhập tên tài khoản hoặc email
              TextField(
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Username or Email',
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

              const SizedBox(height: 24),

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
                      // Chuyển đổi trạng thái ẩn/hiện mật khẩu
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

              const SizedBox(height: 10),

              // Nút quên mật khẩu căn phải
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // Xử lý khi nhấn quên mật khẩu
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFFF83758),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Nút đăng nhập chính
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignIn,
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
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 60),

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

              // Dòng chữ dẫn đến đăng ký tài khoản mới
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Chuyển sang màn hình đăng ký (SignUpScreen)
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SignUpScreen(),
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
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Create An Account ',
                      style: TextStyle(
                        color: Color(0xFF575757),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
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

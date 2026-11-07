// main.dart – file khởi động ứng dụng Flutter
// Import các package cần thiết
import 'package:flutter/material.dart';
// Import widget SplashScreen
import 'splash_screen_1.dart';

void main() {
  runApp(const TrailApp());
}

// Ứng dụng chính, cấu hình MaterialApp
class TrailApp extends StatelessWidget {
  const TrailApp({super.key});

  @override
  // Xây dựng giao diện MaterialApp
  Widget build(BuildContext context) {
    // Khởi tạo MaterialApp với cấu hình chủ đề và màn hình khởi đầu
    return MaterialApp(
      // Ẩn banner debug ở góc trên bên phải
      debugShowCheckedModeBanner: false,
      // Tiêu đề của ứng dụng
      title: 'Stylish',
      // Định nghĩa theme cho toàn bộ app
      theme: ThemeData(
        // Màu nền mặc định cho Scaffold
        scaffoldBackgroundColor: Colors.white,
        // Định nghĩa bảng màu dựa trên seed color
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF83758),
          primary: const Color(0xFFF83758),
        ),
      ),
      // Màn hình khởi động đầu tiên của ứng dụng
      home: const SplashScreen1(),
    );
  }
}



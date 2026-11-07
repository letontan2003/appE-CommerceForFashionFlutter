import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Cấu hình URL cơ sở:
  // - Máy ảo Android Emulator sử dụng 10.0.2.2 để kết nối vào localhost của máy tính host
  // - Web / Desktop sử dụng localhost
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:8080/api/v1';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/v1';
    } else {
      return 'http://localhost:8080/api/v1';
    }
  }

  /// Gọi API Đăng ký tài khoản (Sign Up)
  static Future<Map<String, dynamic>> register({
    required String email,
    required String userName,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({
              'email': email.trim(),
              'tenKH': userName.trim(),
              'passWord': password,
              'confirmPassWord': confirmPassword,
            }),
          )
          .timeout(const Duration(seconds: 15));

      final responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = jsonDecode(responseBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Đăng ký tài khoản thành công!',
          'data': responseData['data'],
        };
      } else {
        // Lỗi từ backend trả về (trùng email, validate fail...)
        String errorMsg = responseData['message'] ?? 'Đăng ký thất bại!';
        if (responseData['data'] is Map) {
          // Lỗi validation chi tiết
          final Map validationErrors = responseData['data'];
          errorMsg = validationErrors.values.first.toString();
        }
        return {
          'success': false,
          'message': errorMsg,
        };
      }
    } on SocketException {
      return {
        'success': false,
        'message': 'Không thể kết nối đến máy chủ Backend (Port 8080). Vui lòng kiểm tra lại kết nối mạng!',
      };
    } on http.ClientException {
      return {
        'success': false,
        'message': 'Lỗi kết nối HTTP. Vui lòng kiểm tra server Backend!',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Đã xảy ra lỗi: ${e.toString()}',
      };
    }
  }

  /// Gọi API Đăng nhập (Sign In)
  static Future<Map<String, dynamic>> login({
    required String emailOrUsername,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({
              'emailOrUsername': emailOrUsername.trim(),
              'passWord': password,
            }),
          )
          .timeout(const Duration(seconds: 15));

      final responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = jsonDecode(responseBody);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Đăng nhập thành công!',
          'data': responseData['data'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Đăng nhập thất bại!',
        };
      }
    } on SocketException {
      return {
        'success': false,
        'message': 'Không thể kết nối đến máy chủ Backend (Port 8080). Vui lòng kiểm tra lại kết nối mạng!',
      };
    } on http.ClientException {
      return {
        'success': false,
        'message': 'Lỗi kết nối HTTP. Vui lòng kiểm tra server Backend!',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Đã xảy ra lỗi: ${e.toString()}',
      };
    }
  }
}

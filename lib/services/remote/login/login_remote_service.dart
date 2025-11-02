import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../core/constant/constant.dart';
import '../../../models/login/authentication_login_model.dart';
import '../../abstract/login/login_service.dart';

class LoginRemoteService extends LoginService {
  final String baseUrl = Constant.baseUrl;

  @override
  Future<AuthenticationLoginModel> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final isEmail = email.contains('@');

      final payload = isEmail
          ? {'email': email, 'password': password}
          : {'username': email, 'password': password};

      log('🔵 [LOGIN] Request ke: $url');
      log('🟢 [LOGIN] Payload: $payload');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      log('🟣 [LOGIN] Status Code: ${response.statusCode}');
      log('🟣 [LOGIN] Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('✅ [LOGIN] Login berhasil!');
        return AuthenticationLoginModel.fromJson(data);
      } else {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final message =
            body['detail'] ?? body['message'] ?? 'Terjadi kesalahan';
        final errorMsg = 'Login gagal (${response.statusCode}): $message';
        log('❌ [LOGIN] $errorMsg');
        throw Exception(errorMsg);
      }
    } catch (e, stackTrace) {
      log('⚠️ [LOGIN] Exception: $e');
      log(stackTrace.toString());
      rethrow;
    }
  }
}

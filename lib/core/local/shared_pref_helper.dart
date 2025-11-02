import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _tokenKey = 'auth_token';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    log(
      '🔒 [SharedPrefHelper] Token disimpan: ${token.substring(0, token.length > 15 ? 15 : token.length)}...',
    );
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    if (token == null || token.isEmpty) {
      log('⚠️ [SharedPrefHelper] Token tidak ditemukan atau kosong.');
      return null;
    }
    log('✅ [SharedPrefHelper] Token ditemukan (panjang: ${token.length})');
    return token;
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    log('🧹 [SharedPrefHelper] Token dihapus dari penyimpanan.');
  }

  static Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    final exists = prefs.containsKey(_tokenKey);
    log('🔍 [SharedPrefHelper] Cek token: ${exists ? "ada" : "tidak ada"}');
    return exists;
  }
}

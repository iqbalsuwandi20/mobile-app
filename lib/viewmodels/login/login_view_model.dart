import 'package:flutter/material.dart';

import '../../core/local/shared_pref_helper.dart';
import '../../models/login/authentication_login_model.dart';
import '../../repositories/login/login_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository _repository;

  LoginViewModel({required LoginRepository loginRepository})
    : _repository = loginRepository;

  bool _isLoading = false;
  String? _errorMessage;
  AuthenticationLoginModel? _loginData;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  AuthenticationLoginModel? get loginData => _loginData;

  bool _disposed = false;

  Future<void> login({
    required String email,
    required String password,
    Function(AuthenticationLoginModel)? onSuccess,
    Function(String)? onError,
  }) async {
    debugPrint('[LoginViewModel] Login attempt with $email');

    _isLoading = true;
    _errorMessage = null;
    safeNotify();

    try {
      final result = await _repository.login(email: email, password: password);
      _loginData = result;

      if (result.accessToken?.isNotEmpty == true) {
        await SharedPrefHelper.saveToken(result.accessToken!);
        debugPrint('[LoginViewModel] ✅ Token saved: ${result.accessToken}');
      } else {
        debugPrint('[LoginViewModel] ⚠️ Token kosong, tidak disimpan');
      }

      debugPrint('[LoginViewModel] Login success for user: $email');
      onSuccess?.call(result);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('[LoginViewModel] ❌ Login error: $e');
      onError?.call(_errorMessage!);
    } finally {
      _isLoading = false;
      safeNotify();
      debugPrint('[LoginViewModel] Login process finished.');
    }
  }

  Future<void> logout() async {
    debugPrint('[LoginViewModel] Logging out...');
    await SharedPrefHelper.clearToken();
    _loginData = null;
    _errorMessage = null;
    safeNotify();
  }

  Future<String?> getSavedToken() async {
    final token = await SharedPrefHelper.getToken();
    debugPrint('[LoginViewModel] Retrieved token: $token');
    return token;
  }

  void clearLoginData() {
    debugPrint('[LoginViewModel] Clearing login data...');
    _loginData = null;
    _errorMessage = null;
    safeNotify();
  }

  void safeNotify() {
    if (!_disposed) {
      notifyListeners();
    } else {
      debugPrint(
        '[LoginViewModel] Skipped notify — ViewModel already disposed.',
      );
    }
  }

  @override
  void dispose() {
    debugPrint('[LoginViewModel] Disposing...');
    _disposed = true;
    super.dispose();
  }
}

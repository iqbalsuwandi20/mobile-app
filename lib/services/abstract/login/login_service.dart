import '../../../models/login/authentication_login_model.dart';

abstract class LoginService {
  Future<AuthenticationLoginModel> login({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }
}

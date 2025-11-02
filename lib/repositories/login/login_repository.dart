import '../../models/login/authentication_login_model.dart';
import '../../services/abstract/login/login_service.dart';

class LoginRepository {
  final LoginService _remoteLoginService;

  LoginRepository({required LoginService remoteLoginService})
    : _remoteLoginService = remoteLoginService;

  Future<AuthenticationLoginModel> login({
    required String email,
    required String password,
  }) async {
    return await _remoteLoginService.login(email: email, password: password);
  }
}

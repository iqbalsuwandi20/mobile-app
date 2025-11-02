class AuthenticationLoginModel {
  final String? email;
  final String? password;
  final String? accessToken;
  final String? tokenType;

  AuthenticationLoginModel({
    this.email,
    this.password,
    this.accessToken,
    this.tokenType,
  });

  Map<String, dynamic> toJson() {
    return {
      if (email != null) 'email': email,
      if (password != null) 'password': password,
    };
  }

  factory AuthenticationLoginModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationLoginModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}

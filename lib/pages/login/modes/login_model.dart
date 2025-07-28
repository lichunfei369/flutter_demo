/// 登录请求数据模型
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'LoginRequest(email: $email, password: [HIDDEN])';
  }
}

/// 登录响应数据模型
class LoginResponse {
  final bool success;
  final String? token;
  final UserInfo? user;
  final String? message;

  const LoginResponse({
    required this.success,
    this.token,
    this.user,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      token: json['token'],
      user: json['user'] != null ? UserInfo.fromJson(json['user']) : null,
      message: json['message'],
    );
  }
}

/// 用户信息模型
class UserInfo {
  final String id;
  final String email;
  final String? name;
  final String? avatar;

  const UserInfo({
    required this.id,
    required this.email,
    this.name,
    this.avatar,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
    };
  }
}

/// 登录状态枚举
enum LoginState {
  initial,
  loading,
  success,
  error,
}

/// 第三方登录类型
enum SocialLoginType {
  apple,
  google,
}
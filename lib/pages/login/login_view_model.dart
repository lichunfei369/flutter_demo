import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoading => _isLoading;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<bool> login() async {
    if (formKey.currentState?.validate() != true) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    // 模拟登录延迟
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();

    // 在实际应用中，这里会处理登录结果
    return true;
  }

  void socialLogin(String provider) {
    // 在这里处理第三方登录逻辑
    // 例如，可以显示一个 SnackBar
    debugPrint('$provider 登录功能开发中');
  }

  void forgotPassword() {
    // 在这里处理忘记密码逻辑
    debugPrint('忘记密码功能开发中');
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '请输入邮箱地址';
    }
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim())) {
      return '请输入有效的邮箱地址';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入密码';
    }
    if (value.length < 6) {
      return '密码长度至少6位';
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
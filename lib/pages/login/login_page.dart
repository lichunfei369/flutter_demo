//

import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/login/widgets/divider_with_text.dart';
import 'package:flutter_demo/pages/login/widgets/email_field.dart';
import 'package:flutter_demo/pages/login/widgets/forgot_password_button.dart';
import 'package:flutter_demo/pages/login/widgets/login_button.dart';
import 'package:flutter_demo/pages/login/widgets/login_header.dart';
import 'package:flutter_demo/pages/login/widgets/password_field.dart';
import 'package:flutter_demo/pages/login/widgets/social_login_section.dart';
import 'package:flutter_demo/pages/login/widgets/custom_message.dart';
import '../main_tab_page.dart';
import '../../navigation/app_navigation.dart';

// 登录页面，包含UI和业务逻辑
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 表单的全局key，用于验证表单
  final _formKey = GlobalKey<FormState>();
  // 邮箱输入框的控制器
  final _emailController = TextEditingController(text: 'test@example.com');
  // 密码输入框的控制器
  final _passwordController = TextEditingController(text: 'password123');
  // 标记密码是否可见
  bool _isPasswordVisible = false;
  // 标记是否正在登录
  bool _isLoading = false;
  

  // 释放控制器资源
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 处理登录逻辑
  Future<void> _handleLogin() async {
    // 验证表单是否有效
    if (_formKey.currentState!.validate()) {
      // 显示加载指示器
      setState(() {
        _isLoading = true;
      });

      // 模拟一个耗时的登录请求
      await Future.delayed(const Duration(seconds: 2));

      // 隐藏加载指示器
      setState(() {
        _isLoading = false;
      });

      // 如果组件仍然挂载，则导航到主页
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainTabPage()),
        );
      }
    }
  }

  // 处理第三方登录
  void _handleSocialLogin(String provider) {
    // 使用自定义消息组件显示提示，说明该功能正在开发中
    MessageUtils.showInfo(
      context,
      title: '功能开发中',
      message: '$provider 登录功能正在开发中，敬请期待',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                const LoginHeader(),
                const SizedBox(height: 48),
                EmailField(controller: _emailController),
                const SizedBox(height: 16),
                PasswordField(
                  controller: _passwordController,
                  isPasswordVisible: _isPasswordVisible,
                  onVisibilityChanged: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 16),
                const ForgotPasswordButton(),
                const SizedBox(height: 32),
                LoginButton(isLoading: _isLoading, onTap: () => _handleLogin()),
                const SizedBox(height: 32),
                const DividerWithText(),
                const SizedBox(height: 24),
                SocialLoginSection(onSocialLogin: _handleSocialLogin),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/profile/profile_page.dart';

/// 应用导航管理类
/// 统一管理所有页面路由和导航操作
class AppNavigation {
  /// 路由名称常量
  static const String home = '/home';
  static const String login = '/login';
  static const String profile = '/profile';

  /// 获取所有路由配置
  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    profile: (context) => const ProfilePage(),
  };

  /// 跳转到首页
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, home);
  }

  /// 跳转到登录页
  static void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, login);
  }

  /// 跳转到个人资料页
  static void goToProfile(BuildContext context) {
    Navigator.pushNamed(context, profile);
  }

  /// 替换到首页（清除栈）
  static void replaceToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, home);
  }

  /// 替换到登录页（清除栈）
  static void replaceToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, login);
  }

  /// 返回上一页
  static void goBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  /// 返回到指定页面
  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }
}
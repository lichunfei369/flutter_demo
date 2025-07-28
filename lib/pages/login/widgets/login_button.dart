import 'package:flutter/material.dart';

// 自定义登录按钮组件
class LoginButton extends StatelessWidget {
  // 是否处于加载状态
  final bool isLoading;
  // 点击事件回调
  final VoidCallback onTap;

  const LoginButton({
    Key? key,
    required this.isLoading,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF32D74B), Color(0xFF28C940)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          // 如果正在加载，则禁用点击事件
          onTap: isLoading ? null : onTap,
          child: Container(
            alignment: Alignment.center,
            // 根据是否加载显示不同内容
            child: isLoading
                // 加载中，显示圆形进度条
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  )
                // 非加载状态，显示登录文本
                : const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
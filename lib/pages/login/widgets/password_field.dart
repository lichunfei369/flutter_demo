import 'package:flutter/material.dart';

// 自定义密码输入框组件
class PasswordField extends StatelessWidget {
  // 输入框控制器
  final TextEditingController controller;
  // 标记密码是否可见
  final bool isPasswordVisible;
  // 密码可见性改变时的回调
  final VoidCallback onVisibilityChanged;

  const PasswordField({
    Key? key,
    required this.controller,
    required this.isPasswordVisible,
    required this.onVisibilityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: !isPasswordVisible,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: const TextStyle(
                color: Color(0xFF8E8E93),
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF8E8E93),
                ),
                onPressed: onVisibilityChanged,
              ),
            ),
            validator: (value) {
              // 验证密码是否为空
              if (value == null || value.isEmpty) {
                return '请输入密码';
              }
              // 验证密码长度
              if (value.length < 6) {
                return '密码长度至少6位';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
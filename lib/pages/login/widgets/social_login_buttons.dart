import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  final Function(String) onSocialLogin;

  const SocialLoginButtons({Key? key, required this.onSocialLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        const Row(
          children: [
            Expanded(child: Divider(color: Colors.grey)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('或使用以下方式登录', style: TextStyle(color: Colors.grey)),
            ),
            Expanded(child: Divider(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton('assets/icons/google.svg', () => onSocialLogin('Google')),
            const SizedBox(width: 20),
            _buildSocialButton('assets/icons/apple.svg', () => onSocialLogin('Apple')),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(String assetName, VoidCallback onPressed) {
    return IconButton(
      icon: Image.asset(assetName, height: 40),
      onPressed: onPressed,
    );
  }
}
import 'package:flutter/material.dart';

class SocialLoginSection extends StatelessWidget {
  final Function(String) onSocialLogin;

  const SocialLoginSection({Key? key, required this.onSocialLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSocialButton(
          onTap: () => onSocialLogin('Apple'),
          icon: Icons.apple,
          text: 'Continue With Apple',
          backgroundColor: const Color(0xFF2C2C2E),
          textColor: Colors.white,
        ),
        const SizedBox(height: 16),
        _buildSocialButton(
          onTap: () => onSocialLogin('Google'),
          icon: Icons.g_mobiledata,
          text: 'Continue With Google',
          backgroundColor: const Color(0xFF2C2C2E),
          textColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: textColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/login/login_view_model.dart';
import 'package:flutter_demo/pages/login/widgets/custom_text_field.dart';
import 'package:flutter_demo/pages/login/widgets/login_button.dart';
import 'package:flutter_demo/pages/login/widgets/login_header.dart';
import 'package:flutter_demo/pages/login/widgets/social_login_buttons.dart';

class LoginForm extends StatelessWidget {
  final LoginViewModel viewModel;
  final VoidCallback onLogin;

  const LoginForm({Key? key, required this.viewModel, required this.onLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoginHeader(),
          const SizedBox(height: 40),
          CustomTextField(
            controller: viewModel.emailController,
            hintText: '邮箱地址',
            validator: viewModel.validateEmail,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: viewModel.passwordController,
            hintText: '密码',
            isPassword: !viewModel.isPasswordVisible,
            onSuffixIconPressed: viewModel.togglePasswordVisibility,
            validator: viewModel.validatePassword,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: viewModel.forgotPassword,
              child: const Text('忘记密码?', style: TextStyle(color: Colors.blue)),
            ),
          ),
          const SizedBox(height: 20),
          LoginButton(onTap: onLogin, isLoading: viewModel.isLoading),
          SocialLoginButtons(onSocialLogin: viewModel.socialLogin),
        ],
      ),
    );
  }
}
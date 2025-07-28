import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/login/widgets/custom_message.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // 使用自定义消息组件显示提示，说明该功能正在开发中
          MessageUtils.showInfo(
            context,
            title: '功能开发中',
            message: '忘记密码功能正在开发中，敬请期待',
          );
        },
        child: const Text(
          'Forget Password ?',
          style: TextStyle(color: Color(0xFFFF9F0A), fontSize: 15),
        ),
      ),
    );
  }
}

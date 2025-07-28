import 'package:flutter/material.dart';

/// 消息类型枚举
enum MessageType {
  success,
  info,
  warning,
  error,
}

/// 自定义消息组件
class CustomMessage extends StatelessWidget {
  final String title;
  final String message;
  final MessageType type;
  final VoidCallback? onClose;
  final bool showCloseButton;

  const CustomMessage({
    Key? key,
    required this.title,
    required this.message,
    required this.type,
    this.onClose,
    this.showCloseButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = _getMessageConfig(type);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: config.borderColor,
            width: 4,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 图标
            Icon(
              config.icon,
              color: config.iconColor,
              size: 20,
            ),
            const SizedBox(width: 12),
            
            // 内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: config.titleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      color: config.messageColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            
            // 关闭按钮
            if (showCloseButton)
              GestureDetector(
                onTap: onClose,
                child: Icon(
                  Icons.close,
                  color: config.closeButtonColor,
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }

  _MessageConfig _getMessageConfig(MessageType type) {
    switch (type) {
      case MessageType.success:
        return _MessageConfig(
          backgroundColor: const Color(0xFFD1FAE5),
          borderColor: const Color(0xFF10B981),
          icon: Icons.check_circle,
          iconColor: const Color(0xFF10B981),
          titleColor: const Color(0xFF065F46),
          messageColor: const Color(0xFF047857),
          closeButtonColor: const Color(0xFF6B7280),
        );
      case MessageType.info:
        return _MessageConfig(
          backgroundColor: const Color(0xFFDBEAFE),
          borderColor: const Color(0xFF3B82F6),
          icon: Icons.info,
          iconColor: const Color(0xFF3B82F6),
          titleColor: const Color(0xFF1E3A8A),
          messageColor: const Color(0xFF1D4ED8),
          closeButtonColor: const Color(0xFF6B7280),
        );
      case MessageType.warning:
        return _MessageConfig(
          backgroundColor: const Color(0xFFFEF3C7),
          borderColor: const Color(0xFFF59E0B),
          icon: Icons.warning,
          iconColor: const Color(0xFFF59E0B),
          titleColor: const Color(0xFF92400E),
          messageColor: const Color(0xFFD97706),
          closeButtonColor: const Color(0xFF6B7280),
        );
      case MessageType.error:
        return _MessageConfig(
          backgroundColor: const Color(0xFFFEE2E2),
          borderColor: const Color(0xFFEF4444),
          icon: Icons.cancel,
          iconColor: const Color(0xFFEF4444),
          titleColor: const Color(0xFF991B1B),
          messageColor: const Color(0xFFDC2626),
          closeButtonColor: const Color(0xFF6B7280),
        );
    }
  }
}

/// 消息配置类
class _MessageConfig {
  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;
  final Color iconColor;
  final Color titleColor;
  final Color messageColor;
  final Color closeButtonColor;

  const _MessageConfig({
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
    required this.iconColor,
    required this.titleColor,
    required this.messageColor,
    required this.closeButtonColor,
  });
}

/// 消息显示工具类
class MessageUtils {
  /// 显示成功消息
  static void showSuccess(
    BuildContext context, {
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showMessage(
      context,
      title: title,
      message: message,
      type: MessageType.success,
      duration: duration,
    );
  }

  /// 显示信息消息
  static void showInfo(
    BuildContext context, {
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showMessage(
      context,
      title: title,
      message: message,
      type: MessageType.info,
      duration: duration,
    );
  }

  /// 显示警告消息
  static void showWarning(
    BuildContext context, {
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showMessage(
      context,
      title: title,
      message: message,
      type: MessageType.warning,
      duration: duration,
    );
  }

  /// 显示错误消息
  static void showError(
    BuildContext context, {
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showMessage(
      context,
      title: title,
      message: message,
      type: MessageType.error,
      duration: duration,
    );
  }

  /// 显示自定义消息
  static void _showMessage(
    BuildContext context, {
    required String title,
    required String message,
    required MessageType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).viewPadding.top + 20,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: AnimatedMessageWrapper(
            child: CustomMessage(
              title: title,
              message: message,
              type: type,
              onClose: () {
                overlayEntry.remove();
              },
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // 自动移除
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

/// 动画包装器
class AnimatedMessageWrapper extends StatefulWidget {
  final Widget child;

  const AnimatedMessageWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedMessageWrapper> createState() => _AnimatedMessageWrapperState();
}

class _AnimatedMessageWrapperState extends State<AnimatedMessageWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );
  }
}
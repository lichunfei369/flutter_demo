// import 'package:flutter/material.dart';
import '../../navigation/app_navigation.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('个人中心'),
//       ),
//       body: const Center(
//         child: Text(
//           '个人中心页面',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人中心'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AppNavigation.goBack(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 第一个设置组
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildSettingItem(
                    icon: Icons.person_outline,
                    title: 'Username',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildSettingItem(
                    icon: Icons.directions_walk_outlined,
                    title: 'Step data source',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildSettingItem(
                    icon: Icons.translate_outlined,
                    title: 'Language',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildSettingItem(
                    icon: Icons.security_outlined,
                    title: 'Privacy',
                    onTap: () {},
                    isLast: true,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Premium Status
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildSettingItem(
                icon: Icons.diamond_outlined,
                iconColor: Colors.blue,
                title: 'Premium Status',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Inactive',
                      style: TextStyle(
                        color: Colors.orange.shade600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
                onTap: () {},
                isLast: true,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Refer a friend
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade400,
                    Colors.orange.shade600,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Refer a friend',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade400,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    '₽',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                '50',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                '/referral',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 熊猫图标区域
                  SizedBox(
                    width: 80,
                    height: 60,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '🐼',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '🐼',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 最后一个设置组
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    icon: Icons.apps_outlined,
                    iconColor: Colors.orange,
                    title: 'App Icon',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildSettingItem(
                    icon: Icons.widgets_outlined,
                    title: 'Widget',
                    onTap: () {},
                    isLast: true,
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            // Add your friends
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.grey,
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Add your friends',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Widget? trailing,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            trailing ??
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 56),
      child: Divider(
        height: 1,
        color: Colors.grey.shade200,
      ),
    );
  }
}
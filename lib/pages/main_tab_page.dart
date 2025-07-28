import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_icons.dart';
import '../constants/app_strings.dart';
import '../models/tab_item.dart';
import 'home/home_page.dart';
import 'profile/profile_page.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  int _currentIndex = 0;
  final List<TabItem> _tabs = const [
    TabItem(
      title: AppStrings.home,
      icon: AppIcons.home,
      activeIcon: AppIcons.homeActive,
    ),
    TabItem(
      title: AppStrings.profile,
      icon: AppIcons.profile,
      activeIcon: AppIcons.profileActive,
    ),
  ];

  final List<Widget> _pages = const [
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _tabs.map((tab) {
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(tab.icon, width: 24, height: 24, color: AppColors.tabInactive),
            activeIcon: SvgPicture.asset(tab.activeIcon, width: 24, height: 24, color: AppColors.tabActive),
            label: tab.title,
          );
        }).toList(),
        selectedItemColor: AppColors.tabActive,
        unselectedItemColor: AppColors.tabInactive,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
        mouseCursor: SystemMouseCursors.basic,
      ),
    );
  }
}
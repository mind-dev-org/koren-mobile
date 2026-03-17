import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'farmers_screen.dart';
import 'about_screen.dart';
import '../theme/app_colors.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    FarmersScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        height: 88,
        decoration: const BoxDecoration(
          color: AppColors.backgroundLight,
          border: Border(
            top: BorderSide(
              color: Color(0x14000000),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            _navItem(
              index: 0,
              icon: Icons.storefront_outlined,
              activeIcon: Icons.storefront,
              label: 'Market',
            ),
            _navItem(
              index: 1,
              icon: Icons.favorite_border,
              activeIcon: Icons.favorite_border,
              label: 'Favourite',
            ),
            _navItem(
              index: 2,
              icon: Icons.person_outline,
              activeIcon: Icons.person_outline,
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final bool active = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              active ? activeIcon : icon,
              size: 26,
              color: active ? AppColors.accent : Colors.grey,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 14,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                color: active ? AppColors.accent : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

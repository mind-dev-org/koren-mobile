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
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        height: 88,
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(
            top: BorderSide(
              color: scheme.onSurface.withValues(alpha: 0.1),
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
              activeIcon: Icons.favorite,
              label: 'Favourite',
            ),
            _navItem(
              index: 2,
              icon: Icons.person_outline,
              activeIcon: Icons.person,
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
    final scheme = Theme.of(context).colorScheme;
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
              color: active
                  ? AppColors.accent
                  : scheme.onSurface.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 14,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                color: active
                    ? AppColors.accent
                    : scheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

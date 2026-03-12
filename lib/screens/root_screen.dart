import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'farmers_screen.dart';
import 'about_screen.dart';

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
    final navWidth = MediaQuery.of(context).size.width - 32;
    final pillWidth = navWidth / 3 - 12;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.06,
                child: Image.asset(
                  "assets/texture/background.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          pages[currentIndex],
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFF252422),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeInOut,
                alignment: switch (currentIndex) {
                  0 => Alignment.centerLeft,
                  1 => Alignment.center,
                  _ => Alignment.centerRight,
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Container(
                    width: pillWidth,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2725B),
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: navItem(0, Icons.storefront)),
                  Expanded(child: navItem(1, Icons.search)),
                  Expanded(child: navItem(2, Icons.person_outline)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(int index, IconData icon) {
    final bool active = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(0, active ? -2 : 0, 0),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 250),
            scale: active ? 1.15 : 1.0,
            child: Icon(
              icon,
              size: active ? 28 : 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

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

  final pages = const [
    HomeScreen(),
    FarmersScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                "assets/textures/background.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          pages[currentIndex],
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFF252422),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment(
                  -1 + (currentIndex * 1.0),
                  0,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3 - 30,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2725B),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  navItem(0, "assets/icons/harvest.png", "Harvest"),
                  navItem(1, "assets/icons/farmers.png", "Farmers"),
                  navItem(2, "assets/icons/about.png", "About"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(int index, String icon, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3 - 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 22,
              color: Colors.white,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/ticker_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(),
            const TickerWidget(),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "ABOUT\nKOREN.",
                style: TextStyle(
                  fontFamily: "Fraunces",
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 0.95,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                "Koren is an eco-marketplace built to connect beginner farmers "
                "with customers who value seasonal food, transparent sourcing, "
                "and lower-impact delivery.\n\n"
                "Our goal is to make direct farm-to-customer sales simple, "
                "beautiful and accessible across web and mobile.",
                style: TextStyle(
                  fontFamily: "SpaceGrotesk",
                  fontSize: 15,
                  height: 1.55,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE2725B).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "VALUES",
                    style: TextStyle(
                      fontFamily: "Fraunces",
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "• local production\n"
                    "• seasonal harvest\n"
                    "• eco-friendly packaging\n"
                    "• direct support for farmers",
                    style: TextStyle(
                      fontFamily: "SpaceGrotesk",
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

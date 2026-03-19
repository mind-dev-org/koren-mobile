import 'package:flutter/material.dart';

import '../widgets/market_top_bar.dart';

class FarmersScreen extends StatelessWidget {
  const FarmersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MarketTopBar(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "OUR\nFARMERS.",
                style: TextStyle(
                  fontFamily: "Fraunces",
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 0.95,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const _FarmerCard(
              name: "Ethan Carter",
              region: "Poltava region",
              description:
                  "Small-scale farmer focused on seasonal vegetables and regenerative practices.",
            ),
            const _FarmerCard(
              name: "Olena Hrytsenko",
              region: "Lviv region",
              description:
                  "Grows apples, greens and herbs with an emphasis on low-waste packaging.",
            ),
            const _FarmerCard(
              name: "Mykola Bondar",
              region: "Vinnytsia region",
              description:
                  "Produces eggs and root vegetables from a family eco-farm.",
            ),
          ],
        ),
      ),
    );
  }
}

class _FarmerCard extends StatelessWidget {
  final String name;
  final String region;
  final String description;

  const _FarmerCard({
    required this.name,
    required this.region,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontFamily: "Fraunces",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            region,
            style: const TextStyle(
              fontFamily: "SpaceGrotesk",
              fontSize: 14,
              color: Color(0xFFE2725B),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontFamily: "SpaceGrotesk",
              fontSize: 15,
              height: 1.45,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

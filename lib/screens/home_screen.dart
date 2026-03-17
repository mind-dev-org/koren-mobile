import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.06,
              child: Image.asset(
                'assets/texture/background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                /// HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'KOREN',
                        style: TextStyle(
                          fontFamily: 'Fraunces',
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: AppColors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 46,
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.black,
                              width: 1,
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.search,
                                size: 24,
                                color: AppColors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Search',
                                style: TextStyle(
                                  fontFamily: 'SpaceGrotesk',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    border: Border(
                      top: BorderSide(color: AppColors.black, width: 1),
                      bottom: BorderSide(color: AppColors.black, width: 1),
                    ),
                  ),
                  child: Marquee(
                    text:
                        'LOCAL FOOD • ECO FARMING • NO PLASTIC • SEASONAL PRODUCTS • ',
                    style: const TextStyle(
                      fontFamily: 'ArchivoBlack',
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                    blankSpace: 32,
                    velocity: 35,
                    pauseAfterRound: Duration.zero,
                    startPadding: 10,
                    accelerationDuration: Duration.zero,
                    decelerationDuration: Duration.zero,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 26, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today’s",
                        style: TextStyle(
                          fontFamily: 'Fraunces',
                          fontSize: 54,
                          height: 0.95,
                          fontWeight: FontWeight.w900,
                          color: AppColors.black,
                        ),
                      ),
                      const Text(
                        "Harvest.",
                        style: TextStyle(
                          fontFamily: 'Fraunces',
                          fontSize: 54,
                          height: 0.95,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Every product below was picked within\nthe last 48 hours. Named farmer,\nreal address, zero middlemen.',
                        style: TextStyle(
                          fontFamily: 'Fraunces',
                          fontSize: 18,
                          height: 1.18,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: AppColors.dark,
                        ),
                      ),
                      const SizedBox(height: 34),
                      const Divider(color: AppColors.black, thickness: 1.2),
                      const _StatRow(number: '6', label: 'PRODUCTS TODAY'),
                      const Divider(color: AppColors.black, thickness: 1.2),
                      const _StatRow(
                        number: '5',
                        label: 'FARMERS HARVESTING',
                      ),
                      const Divider(color: AppColors.black, thickness: 1.2),
                      const _StatRow(
                        number: '0',
                        label: 'MIDDLEMAN IN THE CHAIN',
                      ),
                      const Divider(color: AppColors.black, thickness: 1.2),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 400,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Browse all products',
                        style: TextStyle(
                          fontFamily: 'Fraunces',
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 220,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 220,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 220,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        height: 280,
                        color: AppColors.olive,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  final String number;
  final String label;

  const _StatRow({
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Row(
        children: [
          SizedBox(
            width: 86,
            child: Text(
              number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'ArchivoBlack',
                fontSize: 34,
                color: AppColors.accent,
              ),
            ),
          ),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'ArchivoBlack',
                fontSize: 16,
                color: AppColors.dark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

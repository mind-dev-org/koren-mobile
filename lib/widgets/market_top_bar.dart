import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../theme/app_colors.dart';
import '../screens/cart_screen.dart';
import '../screens/search_screen.dart';

class MarketTopBar extends StatelessWidget {
  const MarketTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
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
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SearchScreen(),
                        ),
                      );
                    },
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
                  const SizedBox(width: 10),
                  Consumer<CartProvider>(
                    builder: (context, cart, child) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 46,
                          width: 46,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.black,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            '${cart.itemCount}',
                            style: const TextStyle(
                              fontFamily: 'ArchivoBlack',
                              fontSize: 16,
                              color: AppColors.accent,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
      ],
    );
  }
}

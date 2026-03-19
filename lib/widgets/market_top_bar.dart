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
              Text(
                'KOREN',
                style: TextStyle(
                  fontFamily: 'Fraunces',
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.onSurface,
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
                      final scheme = Theme.of(context).colorScheme;

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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: scheme.onSurface,
                              width: 1,
                            ),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Center(
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 22,
                                  color: scheme.onSurface,
                                ),
                              ),
                              if (cart.itemCount > 0)
                                Positioned(
                                  right: -4,
                                  top: -4,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: AppColors.accent,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 18,
                                      minHeight: 18,
                                    ),
                                    child: Text(
                                      '${cart.itemCount}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'ArchivoBlack',
                                        fontSize: 9,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
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

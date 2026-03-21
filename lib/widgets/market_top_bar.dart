import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../screens/cart_screen.dart';
import '../screens/search_screen.dart';
import '../theme/app_colors.dart';

class MarketTopBar extends StatelessWidget {
  const MarketTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final borderColor =
        isDark ? Colors.white.withValues(alpha: 0.25) : AppColors.black;

    final searchBackground =
        isDark ? const Color(0xFF1E1E1E) : Colors.transparent;

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
                  color: scheme.onSurface,
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
                        color: searchBackground,
                        border: Border.all(
                          color: borderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 24,
                            color: scheme.onSurface,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Search',
                            style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurface,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
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
                                      cart.itemCount > 9
                                          ? '9+'
                                          : '${cart.itemCount}',
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
          decoration: BoxDecoration(
            color: AppColors.accent,
            border: Border(
              top: BorderSide(color: borderColor, width: 1),
              bottom: BorderSide(color: borderColor, width: 1),
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

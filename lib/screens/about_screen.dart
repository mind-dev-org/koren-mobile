import 'package:flutter/material.dart';
import 'package:koren_mobile/widgets/app_background.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_colors.dart';
import '../theme/theme_provider.dart';
import '../widgets/market_top_bar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final favorites = context.watch<FavoritesProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    final scheme = Theme.of(context).colorScheme;

    final cardColor =
        isDark ? const Color(0xFF1E1E1E) : Colors.white.withValues(alpha: 0.78);

    final secondaryCardColor =
        isDark ? const Color(0xFF252525) : Colors.white.withValues(alpha: 0.78);

    final borderColor =
        isDark ? Colors.white.withValues(alpha: 0.25) : AppColors.black;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MarketTopBar(),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "MY\nACCOUNT.",
                    style: TextStyle(
                      fontFamily: "Fraunces",
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      height: 0.95,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: borderColor, width: 1),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.accent,
                        child: Text(
                          'K',
                          style: TextStyle(
                            fontFamily: 'ArchivoBlack',
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pavlo Bereziuk',
                              style: TextStyle(
                                fontFamily: 'Fraunces',
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: scheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'pavlobereza@gmail.com',
                              style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 14,
                                color: scheme.onSurface.withValues(alpha: 0.75),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _AccountStatCard(
                          title: 'FAVOURITES',
                          value: '${favorites.favoriteProductIds.length}',
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _AccountStatCard(
                          title: 'CART ITEMS',
                          value: '${cart.itemCount}',
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: secondaryCardColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: borderColor, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dark theme',
                              style: TextStyle(
                                fontFamily: 'Fraunces',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: scheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Switch between light and dark mode.',
                              style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 14,
                                height: 1.45,
                                color: scheme.onSurface.withValues(alpha: 0.75),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: isDark,
                        onChanged: (_) {
                          themeProvider.toggleTheme();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _AccountActionCard(
                  title: 'Clear cart',
                  description: 'Remove all products from your cart.',
                  buttonText: 'CLEAR CART',
                  onPressed: () {
                    context.read<CartProvider>().clearCart();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cart cleared'),
                      ),
                    );
                  },
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
                _AccountActionCard(
                  title: 'Clear favourites',
                  description: 'Remove all saved favourite products.',
                  buttonText: 'CLEAR FAVOURITES',
                  onPressed: () {
                    context.read<FavoritesProvider>().clearFavorites();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Favourites cleared'),
                      ),
                    );
                  },
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AccountStatCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isDark;

  const _AccountStatCard({
    required this.title,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E1E1E)
            : Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color:
              isDark ? Colors.white.withValues(alpha: 0.25) : AppColors.black,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'ArchivoBlack',
              fontSize: 11,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Fraunces',
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountActionCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;
  final bool isDark;

  const _AccountActionCard({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E1E1E)
            : Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color:
              isDark ? Colors.white.withValues(alpha: 0.25) : AppColors.black,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Fraunces',
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 14,
              height: 1.45,
              color: scheme.onSurface.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? AppColors.accent : AppColors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontFamily: 'ArchivoBlack',
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

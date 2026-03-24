import 'package:flutter/material.dart';
import 'package:koren_mobile/widgets/app_background.dart';
import 'package:provider/provider.dart';

import '../features/products/data/models/product_model.dart';
import '../features/products/data/repositories/product_repository_impl.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/market_top_bar.dart';
import 'product_detail_screen.dart';
import 'package:koren_mobile/features/products/presentation/widgets/product_image.dart';

class FarmersScreen extends StatelessWidget {
  const FarmersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ProductRepositoryImpl();
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor =
        isDark ? const Color(0xFF1E1E1E) : Colors.white.withValues(alpha: 0.78);

    final borderColor =
        isDark ? Colors.white.withValues(alpha: 0.25) : AppColors.black;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: FutureBuilder<List<ProductModel>>(
            future: repository.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Error: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: scheme.onSurface,
                      ),
                    ),
                  ),
                );
              }

              final products = snapshot.data ?? [];

              return Consumer<FavoritesProvider>(
                builder: (context, favorites, child) {
                  final favoriteProducts = products
                      .where((product) => favorites.isFavorite(product.id))
                      .toList();

                  return SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MarketTopBar(),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "YOUR\nFAVOURITES.",
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
                        if (favoriteProducts.isEmpty)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: borderColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'You have no favourite products yet.\nTap the heart icon on a product to save it here.',
                              style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 15,
                                height: 1.5,
                                color: scheme.onSurface,
                              ),
                            ),
                          )
                        else
                          ...favoriteProducts.map(
                            (product) => _FavouriteCard(
                              product: product,
                              isDark: isDark,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FavouriteCard extends StatelessWidget {
  final ProductModel product;
  final bool isDark;

  const _FavouriteCard({
    required this.product,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final cardColor =
        isDark ? const Color(0xFF1E1E1E) : Colors.white.withValues(alpha: 0.78);

    final borderColor =
        isDark ? Colors.white.withValues(alpha: 0.25) : AppColors.black;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(
              imageUrl: product.imageUrl,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontFamily: 'Fraunces',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.farmer.name.isNotEmpty
                        ? product.farmer.name
                        : 'Local farmer',
                    style: const TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 14,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${product.price.toStringAsFixed(2)} € / ${product.unit}',
                    style: const TextStyle(
                      fontFamily: 'ArchivoBlack',
                      fontSize: 15,
                      color: AppColors.accent,
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:koren_mobile/widgets/app_background.dart';

import '../features/products/data/models/product_model.dart';
import '../features/products/data/repositories/product_repository_impl.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/market_top_bar.dart';
import 'product_detail_screen.dart';
import 'package:koren_mobile/features/products/presentation/widgets/product_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProductModel>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductRepositoryImpl().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final borderColor =
        isDark ? Colors.white.withValues(alpha: 0.25) : AppColors.black;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: FutureBuilder<List<ProductModel>>(
            future: _productsFuture,
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
                      'ERROR:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: scheme.onSurface,
                      ),
                    ),
                  ),
                );
              }

              final products = snapshot.data ?? [];
              final uniqueFarmers = products
                  .map((p) => p.farmer.name)
                  .where((name) => name.isNotEmpty)
                  .toSet()
                  .length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MarketTopBar(),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(20, 26, 20, 24),
                      children: [
                        Text(
                          "Today’s",
                          style: TextStyle(
                            fontFamily: 'Fraunces',
                            fontSize: 54,
                            height: 0.95,
                            fontWeight: FontWeight.w900,
                            color: scheme.onSurface,
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
                        Text(
                          'Every product below was picked within\nthe last 48 hours. Named farmer,\nreal address, zero middlemen.',
                          style: TextStyle(
                            fontFamily: 'Fraunces',
                            fontSize: 18,
                            height: 1.18,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            color: scheme.onSurface.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 34),
                        Divider(color: borderColor, thickness: 1.2),
                        _StatRow(
                          number: '${products.length}',
                          label: 'PRODUCTS TODAY',
                        ),
                        Divider(color: borderColor, thickness: 1.2),
                        _StatRow(
                          number: '$uniqueFarmers',
                          label: 'FARMERS HARVESTING',
                        ),
                        Divider(color: borderColor, thickness: 1.2),
                        const _StatRow(
                          number: '0',
                          label: 'MIDDLEMAN IN THE CHAIN',
                        ),
                        Divider(color: borderColor, thickness: 1.2),
                        const SizedBox(height: 24),
                        Text(
                          'Browse all products',
                          style: TextStyle(
                            fontFamily: 'Fraunces',
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...products.map(
                          (product) => _ProductCardLite(
                            product: product,
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
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
    final scheme = Theme.of(context).colorScheme;

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
              style: TextStyle(
                fontFamily: 'ArchivoBlack',
                fontSize: 16,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCardLite extends StatelessWidget {
  final ProductModel product;
  final bool isDark;

  const _ProductCardLite({
    required this.product,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final cardColor =
        isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF4F1EA);

    final borderColor =
        isDark ? Colors.white.withValues(alpha: 0.25) : AppColors.black;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1.2),
          color: cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor),
                    ),
                    child: Text(
                      product.category.name.isNotEmpty
                          ? product.category.name.toUpperCase()
                          : 'PRODUCT',
                      style: TextStyle(
                        fontFamily: 'ArchivoBlack',
                        fontSize: 9,
                        color: scheme.onSurface,
                      ),
                    ),
                  ),
                  Consumer<FavoritesProvider>(
                    builder: (context, favorites, child) {
                      final isFavorite = favorites.isFavorite(product.id);

                      return InkWell(
                        onTap: () {
                          favorites.toggleFavorite(product.id);
                        },
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color:
                              isFavorite ? AppColors.accent : scheme.onSurface,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 180,
              width: double.infinity,
              child: ProductImage(
                imageUrl: product.imageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontFamily: 'Fraunces',
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      height: 0.9,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.farmer.name.isNotEmpty
                        ? 'BY ${product.farmer.name.toUpperCase()}'
                        : 'BY FARMER',
                    style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface.withValues(alpha: 0.65),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${product.price.toStringAsFixed(2)} € / ${product.unit}',
                    style: const TextStyle(
                      fontFamily: 'ArchivoBlack',
                      fontSize: 16,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 32,
                    color: isDark ? AppColors.accent : AppColors.black,
                    alignment: Alignment.center,
                    child: const Text(
                      'VIEW PRODUCT',
                      style: TextStyle(
                        fontFamily: 'ArchivoBlack',
                        fontSize: 11,
                        color: Colors.white,
                      ),
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

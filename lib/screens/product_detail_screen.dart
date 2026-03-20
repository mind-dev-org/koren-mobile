import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/products/data/models/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_colors.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final categoryLabel = product.category.name.isNotEmpty
        ? product.category.name.toUpperCase()
        : 'PRODUCT';

    final farmerLabel =
        product.farmer.name.isNotEmpty ? product.farmer.name : 'Local farmer';

    final farmerRegion =
        product.farmer.region.isNotEmpty ? product.farmer.region : 'Ukraine';

    return Scaffold(
      backgroundColor: scheme.surface,
      body: Stack(
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 20, 8),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Product',
                          style: TextStyle(
                            fontFamily: 'Fraunces',
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: scheme.onSurface,
                          ),
                        ),
                      ),
                      Consumer<FavoritesProvider>(
                        builder: (context, favorites, child) {
                          final isFavorite = favorites.isFavorite(product.id);

                          return IconButton(
                            onPressed: () {
                              favorites.toggleFavorite(product.id);
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? AppColors.accent
                                  : scheme.onSurface,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: scheme.onSurface),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: scheme.onSurface),
                                  ),
                                  child: Text(
                                    categoryLabel,
                                    style: TextStyle(
                                      fontFamily: 'ArchivoBlack',
                                      fontSize: 10,
                                      color: scheme.onSurface,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 280,
                                width: double.infinity,
                                child: product.imageUrl.isNotEmpty
                                    ? Image.network(
                                        product.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(
                                          color: const Color(0xFFE7E2D7),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            size: 56,
                                            color: scheme.onSurface,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        color: const Color(0xFFE7E2D7),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.image_not_supported_outlined,
                                          size: 56,
                                          color: scheme.onSurface,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          product.name,
                          style: TextStyle(
                            fontFamily: 'Fraunces',
                            fontSize: 40,
                            height: 0.95,
                            fontWeight: FontWeight.w900,
                            color: scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${product.price.toStringAsFixed(2)} € / ${product.unit}',
                          style: const TextStyle(
                            fontFamily: 'ArchivoBlack',
                            fontSize: 18,
                            color: AppColors.accent,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: _InfoMiniCard(
                                title: 'FARMER',
                                value: farmerLabel,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _InfoMiniCard(
                                title: 'REGION',
                                value: farmerRegion,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _InfoMiniCard(
                                title: 'IN STOCK',
                                value: '${product.stockQty}',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _InfoMiniCard(
                                title: 'UNIT',
                                value: product.unit.toUpperCase(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'About product',
                          style: TextStyle(
                            fontFamily: 'Fraunces',
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          product.description.isNotEmpty
                              ? product.description
                              : 'Fresh seasonal product from local farmers.',
                          style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 16,
                            height: 1.5,
                            color: scheme.onSurface.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<CartProvider>().addToCart(product);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('${product.name} added to cart'),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: scheme.onSurface,
                              foregroundColor: scheme.surface,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            child: const Text(
                              'ADD TO CART',
                              style: TextStyle(
                                fontFamily: 'ArchivoBlack',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          color: AppColors.olive,
                          child: const Text(
                            'Transparent sourcing. Real farmer. Real product.',
                            style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoMiniCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoMiniCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.onSurface),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TITLE',
            style: TextStyle(
              fontFamily: 'ArchivoBlack',
              fontSize: 10,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

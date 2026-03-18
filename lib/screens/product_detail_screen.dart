import 'package:flutter/material.dart';
import '../features/products/data/models/product_model.dart';
import '../theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final categoryLabel = product.category.name.isNotEmpty
        ? product.category.name.toUpperCase()
        : 'PRODUCT';

    final farmerLabel =
        product.farmer.name.isNotEmpty ? product.farmer.name : 'Local farmer';

    final farmerRegion =
        product.farmer.region.isNotEmpty ? product.farmer.region : 'Ukraine';

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
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
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Product',
                        style: TextStyle(
                          fontFamily: 'Fraunces',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black,
                        ),
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
                            border: Border.all(
                              color: AppColors.black,
                              width: 1.2,
                            ),
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
                                    border: Border.all(color: AppColors.black),
                                  ),
                                  child: Text(
                                    categoryLabel,
                                    style: const TextStyle(
                                      fontFamily: 'ArchivoBlack',
                                      fontSize: 10,
                                      color: AppColors.dark,
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
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: const Color(0xFFE7E2D7),
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons
                                                  .image_not_supported_outlined,
                                              size: 56,
                                              color: AppColors.dark,
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        color: const Color(0xFFE7E2D7),
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.image_not_supported_outlined,
                                          size: 56,
                                          color: AppColors.dark,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontFamily: 'Fraunces',
                            fontSize: 40,
                            height: 0.95,
                            fontWeight: FontWeight.w900,
                            color: AppColors.black,
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
                        const Text(
                          'About product',
                          style: TextStyle(
                            fontFamily: 'Fraunces',
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          product.description.isNotEmpty
                              ? product.description
                              : 'Fresh seasonal product from local farmers. Carefully harvested and delivered with a focus on quality, transparency and lower-impact packaging.',
                          style: const TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 16,
                            height: 1.5,
                            color: AppColors.dark,
                          ),
                        ),
                        if (product.tags.isNotEmpty) ...[
                          const SizedBox(height: 22),
                          const Text(
                            'Tags',
                            style: TextStyle(
                              fontFamily: 'Fraunces',
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: product.tags
                                .map(
                                  (tag) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.black,
                                      ),
                                    ),
                                    child: Text(
                                      tag.toUpperCase(),
                                      style: const TextStyle(
                                        fontFamily: 'ArchivoBlack',
                                        fontSize: 10,
                                        color: AppColors.dark,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
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
                              backgroundColor: AppColors.black,
                              foregroundColor: Colors.white,
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
                                color: Colors.white,
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
                            'Transparent sourcing. Real farmer. Real product. No middlemen.',
                            style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 14,
                              height: 1.45,
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
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.black,
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
              fontSize: 10,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}

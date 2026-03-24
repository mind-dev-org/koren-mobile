import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:koren_mobile/config/app_config.dart';

import '../features/products/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  String _resolveImageUrl(String raw) {
    if (raw.trim().isEmpty) return '';
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    return '${AppConfig.imageBaseUrl}$raw';
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _resolveImageUrl(product.imageUrl);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 190,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.78),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: imageUrl.isEmpty
                  ? _placeholder()
                  : CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _loadingPlaceholder(),
                      errorWidget: (context, url, error) => _placeholder(),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
              child: Text(
                product.name,
                style: const TextStyle(
                  fontFamily: 'Fraunces',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                '€${product.price.toStringAsFixed(2)} / ${product.unit}',
                style: const TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 14,
                  color: Color(0xFFE2725B),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Text(
                product.isFeatured ? 'Featured product' : 'Fresh seasonal item',
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      height: 140,
      color: const Color(0xFFE7E2D7),
      alignment: Alignment.center,
      child: const Icon(Icons.image_not_supported_outlined, color: Color(0xFF999999)),
    );
  }

  Widget _loadingPlaceholder() {
    return Container(
      height: 140,
      color: const Color(0xFFE7E2D7),
      alignment: Alignment.center,
      child: const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}

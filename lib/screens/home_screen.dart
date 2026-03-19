import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'cart_screen.dart';
import '../features/products/data/models/product_model.dart';
import '../features/products/data/repositories/product_repository_impl.dart';
import '../providers/cart_provider.dart';
import '../theme/app_colors.dart';
import 'product_detail_screen.dart';
import 'search_screen.dart';
import '../widgets/market_top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ProductRepositoryImpl();

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
                      'ERROR:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.black,
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
                        _StatRow(
                          number: '${products.length}',
                          label: 'PRODUCTS TODAY',
                        ),
                        const Divider(color: AppColors.black, thickness: 1.2),
                        _StatRow(
                          number: '$uniqueFarmers',
                          label: 'FARMERS HARVESTING',
                        ),
                        const Divider(color: AppColors.black, thickness: 1.2),
                        const _StatRow(
                          number: '0',
                          label: 'MIDDLEMAN IN THE CHAIN',
                        ),
                        const Divider(color: AppColors.black, thickness: 1.2),
                        const SizedBox(height: 24),
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
                        ...products.map(
                          (product) => _ProductCardLite(product: product),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
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

class _ProductCardLite extends StatelessWidget {
  final ProductModel product;

  const _ProductCardLite({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
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
          border: Border.all(color: AppColors.black, width: 1.2),
          color: const Color(0xFFF4F1EA),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black),
                ),
                child: Text(
                  product.category.name.isNotEmpty
                      ? product.category.name.toUpperCase()
                      : 'PRODUCT',
                  style: const TextStyle(
                    fontFamily: 'ArchivoBlack',
                    fontSize: 9,
                    color: AppColors.dark,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 180,
              width: double.infinity,
              child: product.imageUrl.isNotEmpty
                  ? Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFE7E2D7),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            size: 40,
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
                        size: 40,
                        color: AppColors.dark,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontFamily: 'Fraunces',
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      height: 0.9,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.farmer.name.isNotEmpty
                        ? 'BY ${product.farmer.name.toUpperCase()}'
                        : 'BY FARMER',
                    style: const TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
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
                    color: AppColors.black,
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

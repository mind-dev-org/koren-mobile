import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import '../theme/app_colors.dart';
import '../features/products/data/models/product_model.dart';
import '../features/products/data/repositories/product_repository_impl.dart';
import 'product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'search_screen.dart';

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
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              final products = snapshot.data ?? [];

              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
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
                                    return Container(
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
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              height: 48,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: AppColors.accent,
                                border: Border(
                                  top: BorderSide(
                                      color: AppColors.black, width: 1),
                                  bottom: BorderSide(
                                      color: AppColors.black, width: 1),
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
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 26, 20, 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  const Divider(
                                      color: AppColors.black, thickness: 1.2),
                                  const _StatRow(
                                      number: '6', label: 'PRODUCTS TODAY'),
                                  const Divider(
                                      color: AppColors.black, thickness: 1.2),
                                  const _StatRow(
                                    number: '5',
                                    label: 'FARMERS HARVESTING',
                                  ),
                                  const Divider(
                                      color: AppColors.black, thickness: 1.2),
                                  const _StatRow(
                                    number: '0',
                                    label: 'MIDDLEMAN IN THE CHAIN',
                                  ),
                                  const Divider(
                                      color: AppColors.black, thickness: 1.2),
                                  const SizedBox(height: 20),
                                  Container(
                                    width: double.infinity,
                                    height: 400,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 20),
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
                                    (product) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 14),
                                      child: _ProductCardLite(
                                        product: product,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Container(
                                    width: double.infinity,
                                    height: 280,
                                    color: AppColors.olive,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
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
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black, width: 1.2),
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
            Container(
              width: double.infinity,
              color: const Color(0xFFF4F1EA),
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
                      'ADD TO CART',
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

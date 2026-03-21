import 'package:flutter/material.dart';
import 'package:koren_mobile/widgets/app_background.dart';

import '../features/products/data/models/product_model.dart';
import '../features/products/data/repositories/product_repository_impl.dart';
import '../theme/app_colors.dart';
import 'product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final ProductRepositoryImpl _repository = ProductRepositoryImpl();

  late Future<List<ProductModel>> _productsFuture;

  String query = '';

  @override
  void initState() {
    super.initState();
    _productsFuture = _repository.getProducts();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final inputFillColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final cardColor =
        isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF4F1EA);
    final fallbackColor =
        isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE7E2D7);
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
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: scheme.onSurface),
                  ),
                );
              }

              final products = snapshot.data ?? [];
              final filtered = products.where((product) {
                return product.name.toLowerCase().contains(query.toLowerCase());
              }).toList();

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                            color: scheme.onSurface,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            autofocus: true,
                            onChanged: (value) {
                              setState(() {
                                query = value;
                              });
                            },
                            style: TextStyle(
                              color: scheme.onSurface,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search products',
                              hintStyle: TextStyle(
                                color: scheme.onSurface.withValues(alpha: 0.6),
                              ),
                              filled: true,
                              fillColor: inputFillColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(color: borderColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final product = filtered[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailScreen(product: product),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor),
                              color: cardColor,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 110,
                                  height: 110,
                                  child: product.imageUrl.isNotEmpty
                                      ? Image.network(
                                          product.imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                            color: fallbackColor,
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons
                                                  .image_not_supported_outlined,
                                              color: scheme.onSurface,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          color: fallbackColor,
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            color: scheme.onSurface,
                                          ),
                                        ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: TextStyle(
                                            fontFamily: 'Fraunces',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800,
                                            color: scheme.onSurface,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          product.farmer.name.isNotEmpty
                                              ? product.farmer.name
                                              : 'Local farmer',
                                          style: TextStyle(
                                            fontFamily: 'SpaceGrotesk',
                                            fontSize: 12,
                                            color: scheme.onSurface
                                                .withValues(alpha: 0.65),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          '${product.price.toStringAsFixed(2)} € / ${product.unit}',
                                          style: const TextStyle(
                                            fontFamily: 'ArchivoBlack',
                                            fontSize: 14,
                                            color: AppColors.accent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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

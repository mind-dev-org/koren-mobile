import 'package:flutter/material.dart';
import 'package:koren_mobile/widgets/app_background.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../theme/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                    Text(
                      'Cart',
                      style: TextStyle(
                        fontFamily: 'Fraunces',
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: cart.items.isEmpty
                    ? Center(
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(
                            fontFamily: 'Fraunces',
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurface,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          final product = item.product;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: borderColor,
                                width: 1.2,
                              ),
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
                                        const SizedBox(height: 8),
                                        Text(
                                          '${product.price.toStringAsFixed(2)} € / ${product.unit}',
                                          style: const TextStyle(
                                            fontFamily: 'ArchivoBlack',
                                            fontSize: 14,
                                            color: AppColors.accent,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<CartProvider>()
                                                    .decrementQuantity(
                                                      product.id,
                                                    );
                                              },
                                              child: Container(
                                                width: 28,
                                                height: 28,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: borderColor,
                                                  ),
                                                ),
                                                child: Text(
                                                  '-',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: scheme.onSurface,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              '${item.quantity}',
                                              style: TextStyle(
                                                fontFamily: 'ArchivoBlack',
                                                fontSize: 14,
                                                color: scheme.onSurface,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<CartProvider>()
                                                    .incrementQuantity(
                                                      product.id,
                                                    );
                                              },
                                              child: Container(
                                                width: 28,
                                                height: 28,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: borderColor,
                                                  ),
                                                ),
                                                child: Text(
                                                  '+',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: scheme.onSurface,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<CartProvider>()
                                        .removeByProductId(product.id);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: scheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              if (cart.items.isNotEmpty)
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: borderColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL',
                            style: TextStyle(
                              fontFamily: 'ArchivoBlack',
                              fontSize: 14,
                              color: scheme.onSurface,
                            ),
                          ),
                          Text(
                            '${cart.totalPrice.toStringAsFixed(2)} €',
                            style: const TextStyle(
                              fontFamily: 'ArchivoBlack',
                              fontSize: 18,
                              color: AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Checkout coming soon'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isDark ? AppColors.accent : AppColors.black,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: const Text(
                            'CHECKOUT',
                            style: TextStyle(
                              fontFamily: 'ArchivoBlack',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

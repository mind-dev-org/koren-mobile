import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:koren_mobile/config/app_config.dart';
import 'package:koren_mobile/widgets/app_background.dart';
import 'package:provider/provider.dart';
import '../features/payments/data/services/payment_service.dart';
import '../providers/cart_provider.dart';
import '../theme/app_colors.dart';
import 'package:koren_mobile/features/products/presentation/widgets/product_image.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor =
        isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF4F1EA);

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
                                  child: ProductImage(
                                    imageUrl: product.imageUrl,
                                    width: 110,
                                    height: 110,
                                    fit: BoxFit.cover,
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
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            final cart = context.read<CartProvider>();
                            final paymentService = PaymentService();

                            try {
                              final items = cart.items.map((item) {
                                return {
                                  'product_id': item.product.id,
                                  'qty': item.quantity,
                                };
                              }).toList();

                              final dio = Dio(
                                BaseOptions(
                                  baseUrl: AppConfig.baseUrl,
                                  connectTimeout: const Duration(seconds: 20),
                                  receiveTimeout: const Duration(seconds: 20),
                                  sendTimeout: const Duration(seconds: 20),
                                ),
                              );

                              final orderResp = await dio.post(
                                'orders',
                                data: {
                                  'buyer': {
                                    'name': 'Test User',
                                    'phone': '+380501234567',
                                    'email': 'test@example.com',
                                  },
                                  'items': items,
                                  'delivery_address': {
                                    'city': 'Kyiv',
                                    'street': 'Khreshchatyk 1',
                                    'lat': 50.4501,
                                    'lng': 30.5234,
                                  },
                                  'delivery_slot_id': 1,
                                  'note': 'test order',
                                },
                              );

                              final orderId =
                                  orderResp.data['data']['order_id'];

                              await paymentService.pay(orderId);

                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Payment success')),
                              );
                            } catch (e) {
                              if (!context.mounted) return;

                              if (e is StripeException) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Payment cancelled'),
                                  ),
                                );
                                return;
                              }

                              if (e is DioException) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Checkout error ${e.response?.statusCode}: ${e.response?.data}',
                                    ),
                                  ),
                                );
                                return;
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Checkout error: $e')),
                              );
                            }
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

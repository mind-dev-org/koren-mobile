import 'package:dio/dio.dart';
import 'package:koren_mobile/config/app_config.dart';
import 'package:koren_mobile/features/cart/models/cart_item_model.dart';

class OrderService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
    ),
  );

  Future<int> createOrder({
    required List<CartItemModel> items,
  }) async {
    final resp = await _dio.post(
      '/orders',
      data: {
        'buyer': {
          'name': 'Pavlo Bereziuk',
          'phone': '+380501234567',
          'email': 'pavlobereza@gmail.com',
        },
        'items': items
            .map(
              (item) => {
                'product_id': item.product.id,
                'qty': item.quantity,
              },
            )
            .toList(),
        'delivery_address': {
          'city': 'Kyiv',
          'street': 'Khreshchatyk 1',
          'lat': 50.4501,
          'lng': 30.5234,
        },
        'delivery_slot_id': 12,
        'note': 'Call me 30 minutes before delivery',
      },
    );

    final data = resp.data['data'] as Map<String, dynamic>;
    return (data['order_id'] as num).toInt();
  }
}

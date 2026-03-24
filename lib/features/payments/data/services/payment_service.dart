import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:koren_mobile/config/app_config.dart';

class PaymentService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
    ),
  );

  Future<void> pay(int orderId) async {
    final resp = await _dio.post(
      '/payments/create-intent',
      data: {'order_id': orderId},
    );

    final data = resp.data['data'] as Map<String, dynamic>;
    final clientSecret = data['client_secret'] as String;

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Koren',
      ),
    );

    await Stripe.instance.presentPaymentSheet();
    await Future.delayed(const Duration(milliseconds: 300));
  }
}

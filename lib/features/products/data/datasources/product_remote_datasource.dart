import 'package:dio/dio.dart';
import '../models/product_model.dart';
import 'product_datasource.dart';
import 'package:flutter/foundation.dart';

class ProductRemoteDatasource implements ProductDatasource {
  final Dio dio;
  final String baseUrl;

  ProductRemoteDatasource({
    required this.dio,
    required this.baseUrl,
  });

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get('$baseUrl/products');

      if (kDebugMode) {
        debugPrint('PRODUCTS response: ${response.data}');
      }

      final List<dynamic> items =
          (response.data['data'] as List<dynamic>? ?? []);

      return items
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('Dio error: ${e.message}');
      }
      throw Exception('Failed to load products');
    }
  }

  @override
  Future<ProductModel> getFeaturedProduct() async {
    try {
      final response = await dio.get('$baseUrl/products/featured');

      final data = response.data['data'];

      if (data == null) {
        throw Exception('Featured product not found');
      }

      return ProductModel.fromJson(data as Map<String, dynamic>);
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.message}');
      throw Exception('Failed to load featured product');
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await dio.get('$baseUrl/products/$id');

      final data = response.data['data'];

      if (data == null) {
        throw Exception('Product not found');
      }

      return ProductModel.fromJson(data as Map<String, dynamic>);
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.message}');
      throw Exception('Failed to load product');
    }
  }
}

import 'package:dio/dio.dart';

import '../models/product_model.dart';
import 'product_datasource.dart';

class ProductRemoteDatasource implements ProductDatasource {
  final Dio dio;
  final String baseUrl;

  ProductRemoteDatasource({
    required this.dio,
    required this.baseUrl,
  });

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get('$baseUrl/products');

    print('PRODUCTS response: ${response.data}');

    final List<dynamic> items = response.data['data'] as List<dynamic>;

    return items
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ProductModel> getFeaturedProduct() async {
    final response = await dio.get('$baseUrl/products/featured');

    return ProductModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    final response = await dio.get('$baseUrl/products/$id');

    return ProductModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }
}

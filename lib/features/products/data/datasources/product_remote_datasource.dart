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
    throw UnimplementedError('Remote API is not connected yet');
  }

  @override
  Future<ProductModel> getFeaturedProduct() async {
    throw UnimplementedError('Remote API is not connected yet');
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    throw UnimplementedError('Remote API is not connected yet');
  }
}

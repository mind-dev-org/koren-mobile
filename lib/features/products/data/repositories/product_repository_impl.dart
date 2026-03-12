import 'package:dio/dio.dart';

import '../datasources/product_datasource.dart';
import '../datasources/product_mock_datasource.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl {
  late final ProductDatasource _datasource;

  static const bool useMock = true;

  ProductRepositoryImpl() {
    if (useMock) {
      _datasource = ProductMockDatasource();
    } else {
      _datasource = ProductRemoteDatasource(
        dio: Dio(),
        baseUrl: 'https://api.koren.market',
      );
    }
  }

  Future<List<ProductModel>> getProducts() {
    return _datasource.getProducts();
  }

  Future<ProductModel> getFeaturedProduct() {
    return _datasource.getFeaturedProduct();
  }

  Future<ProductModel> getProductById(int id) {
    return _datasource.getProductById(id);
  }
}

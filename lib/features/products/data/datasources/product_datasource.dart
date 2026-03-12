import '../models/product_model.dart';

abstract class ProductDatasource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getFeaturedProduct();
  Future<ProductModel> getProductById(int id);
}

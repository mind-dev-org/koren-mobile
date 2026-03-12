import '../models/product_model.dart';
import 'product_datasource.dart';

class ProductMockDatasource implements ProductDatasource {
  final List<ProductModel> _products = const [
    ProductModel(
      id: 1,
      name: 'Organic Eggs',
      price: 4.5,
      imageUrl: 'https://images.unsplash.com/photo-1589927986089-35812388d1f4',
      unit: 'pcs',
      isFeatured: true,
    ),
    ProductModel(
      id: 2,
      name: 'Fresh Carrots',
      price: 2.3,
      imageUrl: 'https://images.unsplash.com/photo-1447175008436-054170c2e979',
      unit: 'kg',
      isFeatured: false,
    ),
    ProductModel(
      id: 3,
      name: 'Green Apples',
      price: 3.2,
      imageUrl: 'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce',
      unit: 'kg',
      isFeatured: false,
    ),
  ];

  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _products;
  }

  @override
  Future<ProductModel> getFeaturedProduct() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _products.firstWhere((p) => p.isFeatured);
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _products.firstWhere((p) => p.id == id);
  }
}

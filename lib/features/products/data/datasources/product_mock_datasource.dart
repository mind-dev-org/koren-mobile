import '../models/product_model.dart';
import 'product_datasource.dart';

class ProductMockDatasource implements ProductDatasource {
  final List<ProductModel> _products = const [
    ProductModel(
      id: 1,
      name: 'Organic Eggs',
      slug: 'organic-eggs',
      description: 'Fresh organic eggs from free range chickens.',
      price: 4.5,
      unit: 'pcs',
      stockQty: 120,
      imageUrl: 'https://images.unsplash.com/photo-1589927986089-35812388d1f4',
      tags: ['organic', 'eggs'],
      isFeatured: true,
      harvestedAt: '2025-03-10',
      availableInAutoDelivery: true,
      category: ProductCategoryModel(
        id: 1,
        slug: 'eggs',
        name: 'Eggs',
      ),
      farmer: ProductFarmerModel(
        id: 1,
        name: 'Green Valley Farm',
        region: 'Lviv region',
        avatarUrl: '',
      ),
    ),
    ProductModel(
      id: 2,
      name: 'Fresh Carrots',
      slug: 'fresh-carrots',
      description: 'Sweet seasonal carrots from local farms.',
      price: 2.3,
      unit: 'kg',
      stockQty: 80,
      imageUrl: 'https://images.unsplash.com/photo-1447175008436-054170c2e979',
      tags: ['vegetables'],
      isFeatured: false,
      harvestedAt: '2025-03-11',
      availableInAutoDelivery: false,
      category: ProductCategoryModel(
        id: 2,
        slug: 'vegetables',
        name: 'Vegetables',
      ),
      farmer: ProductFarmerModel(
        id: 2,
        name: 'Sunny Farm',
        region: 'Ivano-Frankivsk region',
        avatarUrl: '',
      ),
    ),
    ProductModel(
      id: 3,
      name: 'Green Apples',
      slug: 'green-apples',
      description: 'Crisp green apples with natural sweetness.',
      price: 3.2,
      unit: 'kg',
      stockQty: 50,
      imageUrl: 'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce',
      tags: ['fruit'],
      isFeatured: false,
      harvestedAt: '2025-03-12',
      availableInAutoDelivery: true,
      category: ProductCategoryModel(
        id: 3,
        slug: 'fruits',
        name: 'Fruits',
      ),
      farmer: ProductFarmerModel(
        id: 3,
        name: 'Apple Garden',
        region: 'Zakarpattia',
        avatarUrl: '',
      ),
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

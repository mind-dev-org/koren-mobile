class ProductModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final double price;
  final String unit;
  final int stockQty;
  final String imageUrl;
  final List<String> tags;
  final bool isFeatured;
  final String harvestedAt;
  final bool availableInAutoDelivery;
  final ProductCategoryModel category;
  final ProductFarmerModel farmer;

  const ProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.unit,
    required this.stockQty,
    required this.imageUrl,
    required this.tags,
    required this.isFeatured,
    required this.harvestedAt,
    required this.availableInAutoDelivery,
    required this.category,
    required this.farmer,
  });

  static String _normalizeImageUrl(String? raw) {
    if (raw == null || raw.isEmpty) {
      return 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6';
    }

    if (raw.startsWith('http://') || raw.startsWith('https://')) {
      return raw;
    }

    return 'https://koren-api.onrender.com$raw';
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit']?.toString() ?? '',
      stockQty: (json['stock_qty'] as num?)?.toInt() ?? 0,
      imageUrl: _normalizeImageUrl(json['image_url']?.toString()),
      tags: (json['tags'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      isFeatured: json['is_featured'] as bool? ?? false,
      harvestedAt: json['harvested_at']?.toString() ?? '',
      availableInAutoDelivery:
          json['available_in_auto_delivery'] as bool? ?? false,
      category: ProductCategoryModel.fromJson(
        json['category'] as Map<String, dynamic>? ?? {},
      ),
      farmer: ProductFarmerModel.fromJson(
        json['farmer'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class ProductCategoryModel {
  final int id;
  final String slug;
  final String name;

  const ProductCategoryModel({
    required this.id,
    required this.slug,
    required this.name,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      slug: json['slug']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}

class ProductFarmerModel {
  final int id;
  final String name;
  final String region;
  final String avatarUrl;

  const ProductFarmerModel({
    required this.id,
    required this.name,
    required this.region,
    required this.avatarUrl,
  });

  factory ProductFarmerModel.fromJson(Map<String, dynamic> json) {
    return ProductFarmerModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      region: json['region']?.toString() ?? '',
      avatarUrl: json['avatar_url']?.toString() ?? '',
    );
  }
}

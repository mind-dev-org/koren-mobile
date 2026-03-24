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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit']?.toString() ?? '',
      stockQty: (json['stock_qty'] as num?)?.toInt() ?? 0,
      imageUrl: json['image_url']?.toString() ?? '',
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'price': price,
      'unit': unit,
      'stock_qty': stockQty,
      'image_url': imageUrl,
      'tags': tags,
      'is_featured': isFeatured,
      'harvested_at': harvestedAt,
      'available_in_auto_delivery': availableInAutoDelivery,
      'category': category.toJson(),
      'farmer': farmer.toJson(),
    };
  }

  ProductModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    double? price,
    String? unit,
    int? stockQty,
    String? imageUrl,
    List<String>? tags,
    bool? isFeatured,
    String? harvestedAt,
    bool? availableInAutoDelivery,
    ProductCategoryModel? category,
    ProductFarmerModel? farmer,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      stockQty: stockQty ?? this.stockQty,
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags ?? this.tags,
      isFeatured: isFeatured ?? this.isFeatured,
      harvestedAt: harvestedAt ?? this.harvestedAt,
      availableInAutoDelivery:
          availableInAutoDelivery ?? this.availableInAutoDelivery,
      category: category ?? this.category,
      farmer: farmer ?? this.farmer,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
    };
  }

  ProductCategoryModel copyWith({
    int? id,
    String? slug,
    String? name,
  }) {
    return ProductCategoryModel(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'region': region,
      'avatar_url': avatarUrl,
    };
  }

  ProductFarmerModel copyWith({
    int? id,
    String? name,
    String? region,
    String? avatarUrl,
  }) {
    return ProductFarmerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      region: region ?? this.region,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

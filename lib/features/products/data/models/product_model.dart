class ProductModel {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String unit;
  final bool isFeatured;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.unit,
    required this.isFeatured,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url'] as String? ?? '',
      unit: json['unit'] as String? ?? '',
      isFeatured: json['is_featured'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image_url': imageUrl,
      'unit': unit,
      'is_featured': isFeatured,
    };
  }

  ProductModel copyWith({
    int? id,
    String? name,
    double? price,
    String? imageUrl,
    String? unit,
    bool? isFeatured,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      unit: unit ?? this.unit,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}

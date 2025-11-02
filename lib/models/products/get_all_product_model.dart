class GetAllProductModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final int price;
  final int stock;
  final String unit;
  final bool isActive;
  final int lowStockLimit;
  final String imageUrl;
  final String ownerId;

  GetAllProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.stock,
    required this.unit,
    required this.isActive,
    required this.lowStockLimit,
    required this.imageUrl,
    required this.ownerId,
  });

  static int _parseToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  factory GetAllProductModel.fromJson(Map<String, dynamic> json) {
    return GetAllProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      price: _parseToInt(json['price']),
      stock: _parseToInt(json['stock']),
      unit: json['unit'] ?? '',
      isActive: json['is_active'] ?? false,
      lowStockLimit: _parseToInt(json['low_stock_limit']),
      imageUrl: json['image_url'] ?? '',
      ownerId: json['owner_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'stock': stock,
      'unit': unit,
      'is_active': isActive,
      'low_stock_limit': lowStockLimit,
      'image_url': imageUrl,
      'owner_id': ownerId,
    };
  }
}

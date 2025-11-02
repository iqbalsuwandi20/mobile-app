import 'dart:convert';

class AddProductModel {
  final String name;
  final String category;
  final String? description;
  final int price;
  final int stock;
  final String unit;
  final bool isActive;
  final int lowStockLimit;

  AddProductModel({
    required this.name,
    required this.category,
    this.description,
    required this.price,
    required this.stock,
    required this.unit,
    required this.isActive,
    required this.lowStockLimit,
  });

  factory AddProductModel.fromJson(Map<String, dynamic> json) {
    int parseToInt(dynamic value) {
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return AddProductModel(
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'],
      price: parseToInt(json['price']),
      stock: parseToInt(json['stock']),
      unit: json['unit'] ?? '',
      isActive: json['is_active'] ?? false,
      lowStockLimit: parseToInt(json['low_stock_limit']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'stock': stock,
      'unit': unit,
      'is_active': isActive,
      'low_stock_limit': lowStockLimit,
    };
  }

  String toFormDataJson() {
    return jsonEncode(toJson());
  }
}

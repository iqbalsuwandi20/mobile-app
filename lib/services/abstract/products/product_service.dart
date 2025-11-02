import 'dart:io';

import '../../../models/products/add_product_model.dart';
import '../../../models/products/get_all_product_model.dart';

abstract class ProductService {
  Future<AddProductModel> addProduct({
    required AddProductModel product,
    required File image,
  }) async {
    throw UnimplementedError();
  }

  Future<List<GetAllProductModel>> getAllProducts() async {
    throw UnimplementedError();
  }

  Future<GetAllProductModel> updateProduct({
    required String id,
    Map<String, dynamic>? data,
    File? image,
  }) async {
    throw UnimplementedError();
  }

  Future<String> deleteProduct({required String id}) async {
    throw UnimplementedError();
  }
}

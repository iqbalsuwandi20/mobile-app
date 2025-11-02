import 'dart:io';

import '../../models/products/add_product_model.dart';
import '../../models/products/get_all_product_model.dart';
import '../../services/abstract/products/product_service.dart';

class ProductRepository {
  final ProductService _remoteProductService;

  ProductRepository({required ProductService remoteProductService})
    : _remoteProductService = remoteProductService;

  Future<AddProductModel> addProduct({
    required AddProductModel product,
    required File image,
  }) async {
    return await _remoteProductService.addProduct(
      product: product,
      image: image,
    );
  }

  Future<List<GetAllProductModel>> getAllProducts() async {
    return await _remoteProductService.getAllProducts();
  }

  Future<GetAllProductModel> updateProduct({
    required String id,
    Map<String, dynamic>? data,
    File? image,
  }) async {
    return await _remoteProductService.updateProduct(
      id: id,
      data: data,
      image: image,
    );
  }

  Future<String> deleteProduct({required String id}) async {
    return await _remoteProductService.deleteProduct(id: id);
  }
}

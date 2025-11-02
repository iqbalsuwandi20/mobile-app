import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/products/add_product_model.dart';
import '../../models/products/get_all_product_model.dart';
import '../../repositories/products/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository;

  ProductViewModel({required ProductRepository productRepository})
    : _repository = productRepository;

  bool _isLoading = false;
  String? _errorMessage;
  AddProductModel? _addedProduct;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  AddProductModel? get addedProduct => _addedProduct;

  List<GetAllProductModel> _products = [];
  bool _isFetching = false;

  List<GetAllProductModel> get products => _products;
  bool get isFetching => _isFetching;

  bool _disposed = false;

  Future<void> addProduct({
    required AddProductModel product,
    required File image,
    Function(AddProductModel)? onSuccess,
    Function(String)? onError,
  }) async {
    debugPrint('[ProductViewModel] Tambah produk: ${product.name}');

    _isLoading = true;
    _errorMessage = null;
    safeNotify();

    try {
      final result = await _repository.addProduct(
        product: product,
        image: image,
      );
      _addedProduct = result;
      debugPrint('[ProductViewModel] ✅ Produk berhasil ditambahkan!');
      onSuccess?.call(result);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('[ProductViewModel] ❌ Error: $e');
      onError?.call(_errorMessage!);
    } finally {
      _isLoading = false;
      safeNotify();
      debugPrint('[ProductViewModel] Proses tambah produk selesai.');
    }
  }

  Future<void> getAllProducts({
    Function(List<GetAllProductModel>)? onSuccess,
    Function(String)? onError,
  }) async {
    debugPrint('[ProductViewModel] Ambil semua produk dari server...');

    _isFetching = true;
    _errorMessage = null;
    safeNotify();

    try {
      final result = await _repository.getAllProducts();
      _products = result;
      debugPrint('[ProductViewModel] ✅ Berhasil ambil ${result.length} produk');
      onSuccess?.call(result);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('[ProductViewModel] ❌ Gagal ambil produk: $e');
      onError?.call(_errorMessage!);
    } finally {
      _isFetching = false;
      safeNotify();
    }
  }

  Future<void> updateProduct({
    required String id,
    Map<String, dynamic>? data,
    File? image,
    Function(GetAllProductModel)? onSuccess,
    Function(String)? onError,
  }) async {
    debugPrint('[ProductViewModel] Update produk ID: $id');

    _isLoading = true;
    _errorMessage = null;
    safeNotify();

    try {
      final updatedProduct = await _repository.updateProduct(
        id: id,
        data: data,
        image: image,
      );

      final index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        _products[index] = updatedProduct;
      }

      debugPrint('[ProductViewModel] ✅ Produk berhasil diupdate!');
      onSuccess?.call(updatedProduct);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('[ProductViewModel] ❌ Gagal update produk: $e');
      onError?.call(_errorMessage!);
    } finally {
      _isLoading = false;
      safeNotify();
    }
  }

  Future<void> deleteProduct({
    required String id,
    Function(String)? onSuccess,
    Function(String)? onError,
  }) async {
    debugPrint('[ProductViewModel] Hapus produk dengan ID: $id');

    _isLoading = true;
    _errorMessage = null;
    safeNotify();

    try {
      final message = await _repository.deleteProduct(id: id);
      debugPrint('[ProductViewModel] ✅ $message');

      _products.removeWhere((p) => p.id == id);

      onSuccess?.call(message);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('[ProductViewModel] ❌ Error hapus produk: $e');
      onError?.call(_errorMessage!);
    } finally {
      _isLoading = false;
      safeNotify();
      debugPrint('[ProductViewModel] Proses hapus produk selesai.');
    }
  }

  void clearProductData() {
    debugPrint('[ProductViewModel] Clearing added product data...');
    _addedProduct = null;
    _errorMessage = null;
    safeNotify();
  }

  void safeNotify() {
    if (!_disposed) {
      notifyListeners();
    } else {
      debugPrint('[ProductViewModel] Skipped notify — ViewModel disposed.');
    }
  }

  @override
  void dispose() {
    debugPrint('[ProductViewModel] Disposing...');
    _disposed = true;
    super.dispose();
  }
}

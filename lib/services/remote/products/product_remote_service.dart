import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../core/constant/constant.dart';
import '../../../core/local/shared_pref_helper.dart';
import '../../../models/products/add_product_model.dart';
import '../../../models/products/get_all_product_model.dart';
import '../../abstract/products/product_service.dart';

class ProductRemoteService extends ProductService {
  final String baseUrl = Constant.baseUrl;

  @override
  Future<AddProductModel> addProduct({
    required AddProductModel product,
    required File image,
  }) async {
    final url = Uri.parse('$baseUrl/products/api/v1/products/');
    log('🔵 [ADD PRODUCT] Request ke: $url');

    try {
      final token = await SharedPrefHelper.getToken();
      if (token == null) {
        throw Exception('Token tidak ditemukan. Silakan login ulang.');
      }
      log('[SharedPrefHelper] Token ditemukan (panjang: ${token.length})');

      final request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      final jsonData = jsonEncode(product.toJson());
      request.fields['data'] = jsonData;

      if (image.path.isNotEmpty) {
        final ext = image.path.split('.').last.toLowerCase();
        final mimeType = (ext == 'png')
            ? MediaType('image', 'png')
            : MediaType('image', 'jpeg');

        final multipartFile = await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: mimeType,
        );

        request.files.add(multipartFile);

        log('🟢 [ADD PRODUCT] File diupload: ${image.path.split('/').last}');
        log(
          '🟢 [ADD PRODUCT] Content-Type: ${mimeType.type}/${mimeType.subtype}',
        );
      } else {
        log('⚠️ [ADD PRODUCT] Tidak ada file gambar yang dipilih.');
      }

      log('🟢 [ADD PRODUCT] Payload JSON: $jsonData');
      log('🟢 [ADD PRODUCT] Headers: ${request.headers}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('🟣 [ADD PRODUCT] Status Code: ${response.statusCode}');
      log('🟣 [ADD PRODUCT] Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        log('✅ [ADD PRODUCT] Produk berhasil ditambahkan!');
        return AddProductModel.fromJson(data);
      } else if (response.statusCode == 401) {
        throw Exception('Token invalid atau kadaluarsa. Silakan login ulang.');
      } else {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final message =
            body['detail'] ??
            body['message'] ??
            'Terjadi kesalahan tidak diketahui';
        throw Exception(
          'Gagal menambahkan produk (${response.statusCode}): $message',
        );
      }
    } catch (e, stackTrace) {
      log('⚠️ [ADD PRODUCT] Exception: $e');
      log(stackTrace.toString());
      rethrow;
    }
  }

  @override
  Future<List<GetAllProductModel>> getAllProducts() async {
    final url = Uri.parse('$baseUrl/products/api/v1/products/');
    log('🔵 [GET ALL PRODUCTS] Request ke: $url');

    try {
      final token = await SharedPrefHelper.getToken();
      if (token == null) {
        throw Exception('Token tidak ditemukan. Silakan login ulang.');
      }

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('🟣 [GET ALL PRODUCTS] Status Code: ${response.statusCode}');
      log('🟣 [GET ALL PRODUCTS] Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final products = data
            .map((json) => GetAllProductModel.fromJson(json))
            .toList();
        log('✅ [GET ALL PRODUCTS] Berhasil ambil ${products.length} produk');
        return products;
      } else if (response.statusCode == 401) {
        throw Exception('Token invalid atau kadaluarsa. Silakan login ulang.');
      } else {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final message =
            body['detail'] ??
            body['message'] ??
            'Terjadi kesalahan tidak diketahui';
        throw Exception(
          'Gagal mengambil produk (${response.statusCode}): $message',
        );
      }
    } catch (e, stackTrace) {
      log('⚠️ [GET ALL PRODUCTS] Exception: $e');
      log(stackTrace.toString());
      rethrow;
    }
  }

  @override
  Future<GetAllProductModel> updateProduct({
    required String id,
    Map<String, dynamic>? data,
    File? image,
  }) async {
    final url = Uri.parse('$baseUrl/products/api/v1/products/$id');
    log('🟦 [UPDATE PRODUCT] Request ke: $url');

    try {
      final token = await SharedPrefHelper.getToken();
      if (token == null) {
        throw Exception('Token tidak ditemukan. Silakan login ulang.');
      }

      final request = http.MultipartRequest('PUT', url);
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      if (data != null && data.isNotEmpty) {
        final jsonData = jsonEncode(data);
        request.fields['data'] = jsonData;
        log('🟢 [UPDATE PRODUCT] Payload: $jsonData');
      }

      if (image != null && image.path.isNotEmpty) {
        final ext = image.path.split('.').last.toLowerCase();
        final mimeType = (ext == 'png')
            ? MediaType('image', 'png')
            : MediaType('image', 'jpeg');

        final multipartFile = await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: mimeType,
        );
        request.files.add(multipartFile);
        log('🟢 [UPDATE PRODUCT] Upload image: ${image.path.split('/').last}');
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('🟣 [UPDATE PRODUCT] Status: ${response.statusCode}');
      log('🟣 [UPDATE PRODUCT] Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return GetAllProductModel.fromJson(data);
      } else if (response.statusCode == 401) {
        throw Exception('Token invalid atau kadaluarsa.');
      } else {
        final body = jsonDecode(response.body);
        final message =
            body['detail'] ?? body['message'] ?? 'Gagal mengupdate produk';
        throw Exception('(${response.statusCode}) $message');
      }
    } catch (e) {
      log('⚠️ [UPDATE PRODUCT] Exception: $e');
      rethrow;
    }
  }

  @override
  Future<String> deleteProduct({required String id}) async {
    final url = Uri.parse('$baseUrl/products/api/v1/products/$id');
    log('🗑️ [DELETE PRODUCT] Request ke: $url');

    try {
      final token = await SharedPrefHelper.getToken();
      if (token == null) {
        throw Exception('Token tidak ditemukan. Silakan login ulang.');
      }

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('🟣 [DELETE PRODUCT] Status Code: ${response.statusCode}');
      log('🟣 [DELETE PRODUCT] Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        log('✅ [DELETE PRODUCT] Produk berhasil dihapus.');
        return 'Produk berhasil dihapus.';
      } else if (response.statusCode == 404) {
        throw Exception('Produk tidak ditemukan.');
      } else if (response.statusCode == 401) {
        throw Exception('Token invalid atau kadaluarsa. Silakan login ulang.');
      } else {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final message =
            body['detail'] ?? body['message'] ?? 'Gagal menghapus produk.';
        throw Exception('(${response.statusCode}) $message');
      }
    } catch (e, stackTrace) {
      log('⚠️ [DELETE PRODUCT] Exception: $e');
      log(stackTrace.toString());
      rethrow;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:ecommerce/models/product.dart';

class ProductService {
  static const String baseUrl = 'https://dummyjson.com';
  static const String productsEndpoint = '/products';
  final Dio _dio;

  ProductService() : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<ProductResponse> getProducts({int limit = 10, int skip = 0}) async {
    try {
      final response = await _dio.get(
        productsEndpoint,
        queryParameters: {
          'limit': limit,
          'skip': skip,
          'select': 'title,price,images',
        },
      );
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<int> getTotalProducts() async {
    try {
      final response = await _dio.get(productsEndpoint);
      if (response.statusCode == 200) {
        return response.data['total'] as int;
      } else {
        throw Exception('Failed to get total: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching total: $e');
    }
  }
}
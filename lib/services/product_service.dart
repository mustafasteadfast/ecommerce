import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/product.dart';

class ProductService {
  static const String baseUrl = 'https://dummyjson.com';
  static const String productsEndpoint = '/products';

  Future<ProductResponse> getProducts({int limit = 10, int skip = 0}) async {
    final url = Uri.parse(
        '$baseUrl$productsEndpoint?limit=$limit&skip=$skip&select=title,price,images');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<int> getTotalProducts() async {
    final url = Uri.parse('$baseUrl$productsEndpoint');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['total'] as int;
      } else {
        throw Exception('Failed to get total: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching total: $e');
    }
  }
}
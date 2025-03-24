import 'package:ecommerce/services/dio_client.dart';
import 'package:ecommerce/models/category.dart';

class CategoryService {
  static const String categoriesEndpoint = '/api/v1/categories';

  Future<CategoryResponse> getCategories() async {
    try {
      final response = await DioClient.instance.dio.get(categoriesEndpoint);
      if (response.statusCode == 200) {
        return CategoryResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}
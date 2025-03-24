class Category {
  final int id;
  final String? name; // Nullable
  final String? slug; // Nullable
  final String? image; // Nullable
  final String? status; // Nullable

  Category({
    required this.id,
    this.name,
    this.slug,
    this.image,
    this.status,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String?, // Safe cast, allows null
      slug: json['slug'] as String?, // Safe cast, allows null
      image: json['image'] as String?, // Safe cast, allows null
      status: json['status'] as String?, // Safe cast, allows null
    );
  }
}

class CategoryResponse {
  final String? message; // Nullable in case API omits it
  final List<Category> categories;

  CategoryResponse({
    this.message,
    required this.categories,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      message: json['message'] as String?,
      categories: (json['data'] as List)
          .map((item) => Category.fromJson(item))
          .toList(),
    );
  }
}
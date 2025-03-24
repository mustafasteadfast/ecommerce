class Product {
  final String? id; // Made optional since not in select
  final String name; // Maps to "title"
  final String description;
  final double price;
  final double discountPercentage;
  final String imageUrl; // Uses first image from "images"
  final String categoryId;
  final String shopId;
  final bool isFavorite;
  final double rating;
  final int reviewCount;

  const Product({
    this.id, // Nullable
    required this.name,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.imageUrl,
    required this.categoryId,
    required this.shopId,
    this.isFavorite = false,
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString(), // Optional, null if not present
      name: json['title'],
      description: '',
      price: (json['price'] as num).toDouble(),
      discountPercentage: 0.0,
      imageUrl: (json['images'] as List).isNotEmpty ? json['images'][0] : '',
      categoryId: '',
      shopId: '',
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? discountPercentage,
    String? imageUrl,
    String? categoryId,
    String? shopId,
    bool? isFavorite,
    double? rating,
    int? reviewCount,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      shopId: shopId ?? this.shopId,
      isFavorite: isFavorite ?? this.isFavorite,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }
}

class ProductResponse {
  final List<Product> products;
  final int total;
  final int skip; // Added total, skip, limit since not in filtered response

  ProductResponse({
    required this.products,
    required this.total,
    required this.skip,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      products: (json['products'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
      total: json['total'] as int,
      skip: json['skip'] as int,
    );
  }
}
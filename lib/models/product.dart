class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double discountPercentage;
  final String imageUrl;
  final String categoryId;
  final String shopId;
  final bool isFavorite;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
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

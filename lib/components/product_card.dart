import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String oldPrice;
  final String rating;
  final String reviews;
  final String imagePath;
  final double fontSize;
  final double priceFontSize;
  final double ratingFontSize;
  final String? fontFamily;
  final bool isNetworkImage;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.reviews,
    required this.imagePath,
    this.fontSize = 14,
    this.priceFontSize = 16,
    this.ratingFontSize = 12,
    this.fontFamily,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color customGreen = const Color(0xFF00B795);
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox( // Replaced Expanded with SizedBox
            height: 120, // Fixed height for image
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: isNetworkImage
                          ? NetworkImage(imagePath)
                          : AssetImage(imagePath) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: customGreen,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Free Delivery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    fontFamily: fontFamily,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: customGreen,
                        fontSize: priceFontSize,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontFamily,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      oldPrice,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: ratingFontSize,
                        decoration: TextDecoration.lineThrough,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFD700),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: TextStyle(
                        fontSize: ratingFontSize,
                        fontWeight: FontWeight.w500,
                        fontFamily: fontFamily,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      reviews,
                      style: TextStyle(
                        fontSize: ratingFontSize,
                        color: Colors.grey[600],
                        fontFamily: fontFamily,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
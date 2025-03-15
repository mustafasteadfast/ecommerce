import 'package:flutter/material.dart';
import 'product_card.dart';
import 'horizontal_scroll_section.dart';
import 'grid_section.dart';

class ProductSection extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Color? seeAllColor;
  final Color? backgroundColor;
  final double height;
  final bool isGrid;
  final int itemCount;
  final String imagePrefix;

  const ProductSection({
    super.key,
    required this.title,
    this.titleColor = Colors.black,
    this.seeAllColor,
    this.backgroundColor,
    required this.height,
    this.isGrid = false,
    required this.itemCount,
    required this.imagePrefix,
  });

  @override
  Widget build(BuildContext context) {
    final productCard = ProductCard(
      title: 'UnSplash Premium\nunicorn Cotton Tshirt',
      price: '৳900',
      oldPrice: '৳780',
      rating: '4.8',
      reviews: '(120)',
      imagePath: '$imagePrefix\${index + 1}.png', 
      fontFamily: 'Onest',
      fontSize: isGrid ? 12 : 14,
      priceFontSize: isGrid ? 14 : 16,
      ratingFontSize: isGrid ? 10 : 12,
    );

    final items = List.generate(
      itemCount,
      (index) => Container(
        margin: const EdgeInsets.only(right: 8),
        child: ProductCard(
          title: productCard.title,
          price: productCard.price,
          oldPrice: productCard.oldPrice,
          rating: productCard.rating,
          reviews: productCard.reviews,
          imagePath: imagePrefix.replaceAll('\${index + 1}', '${index + 1}'),
          fontFamily: productCard.fontFamily,
          fontSize: productCard.fontSize,
          priceFontSize: productCard.priceFontSize,
          ratingFontSize: productCard.ratingFontSize,
        ),
      ),
    );

    if (isGrid) {
      return GridSection(
        title: title,
        items: items.map((item) => item.child as ProductCard).toList(),
      );
    } else {
      return Container(
        decoration: backgroundColor != null
            ? BoxDecoration(color: backgroundColor)
            : null,
        child: HorizontalScrollSection(
          title: title,
          titleColor: titleColor,
          seeAllColor: seeAllColor ?? Colors.black,
          items: items,
          height: height,
        ),
      );
    }
  }
}
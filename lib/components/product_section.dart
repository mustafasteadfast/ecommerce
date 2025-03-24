import 'package:ecommerce/blocs/combine/combine_state.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/blocs/product/product_bloc.dart';
import 'package:ecommerce/blocs/product/product_event.dart';
import 'package:ecommerce/blocs/product/product_state.dart';
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
  final String? imagePrefix;
  final VoidCallback? onSeeAll;

  const ProductSection({
    super.key,
    required this.title,
    this.titleColor = Colors.black,
    this.seeAllColor,
    this.backgroundColor,
    required this.height,
    this.isGrid = false,
    required this.itemCount,
    this.imagePrefix,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePrefix != null) {
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
        isNetworkImage: false, // Static assets
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
            imagePath: imagePrefix!.replaceAll('\${index + 1}', '${index + 1}'),
            fontFamily: productCard.fontFamily,
            fontSize: productCard.fontSize,
            priceFontSize: productCard.priceFontSize,
            ratingFontSize: productCard.ratingFontSize,
            isNetworkImage: false, // Static assets
          ),
        ),
      );

      if (isGrid) {
        return GridSection(
          title: title,
          items: items.map((item) => item.child as ProductCard).toList(),
          seeAllColor: seeAllColor,
          onSeeAll: onSeeAll,
        );
      } else {
        return Container(
          decoration: backgroundColor != null
              ? BoxDecoration(color: backgroundColor)
              : null,
          child: HorizontalScrollSection(
            title: title,
            titleColor: titleColor,
            seeAllColor: seeAllColor ?? const Color(0xFF00B795),
            items: items,
            height: height,
            onSeeAll: onSeeAll,
          ),
        );
      }
    }

    return BlocBuilder<ProductBloc, CombineState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CombineError) {
          return Center(child: Text(state.message));
        }

        if (state is CombineLoaded<ProductResponse>) {
          final products = state.response.products.take(itemCount).toList();
          final items = products
              .map(
                (product) => Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: ProductCard(
                    title: product.name,
                    price: '৳${product.price}',
                    oldPrice: '',
                    rating: product.rating.toString(),
                    reviews: '(${product.reviewCount})',
                    imagePath: product.imageUrl,
                    fontFamily: 'Onest',
                    fontSize: isGrid ? 12 : 14,
                    priceFontSize: isGrid ? 14 : 16,
                    ratingFontSize: isGrid ? 10 : 12,
                    isNetworkImage: true, // API-driven network images
                  ),
                ),
              )
              .toList();

          if (isGrid) {
            return GridSection(
              title: title,
              items: items.map((item) => item.child as ProductCard).toList(),
              seeAllColor: seeAllColor,
              onSeeAll: onSeeAll,
            );
          } else {
            return Container(
              decoration: backgroundColor != null
                  ? BoxDecoration(color: backgroundColor)
                  : null,
              child: HorizontalScrollSection(
                title: title,
                titleColor: titleColor,
                seeAllColor: seeAllColor ?? const Color(0xFF00B795),
                items: items,
                height: height,
                onSeeAll: onSeeAll,
              ),
            );
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

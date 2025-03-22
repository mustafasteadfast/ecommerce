import 'package:flutter/material.dart';
import 'section_header.dart';

class HorizontalScrollSection extends StatelessWidget {
  final String title;
  final List<Widget> items;
  final Color titleColor;
  final Color seeAllColor;
  final Color backgroundColor;
  final EdgeInsets padding;
  final double height;
  final VoidCallback? onSeeAll; // Updated name

  const HorizontalScrollSection({
    super.key,
    required this.title,
    required this.items,
    this.titleColor = Colors.black,
    this.seeAllColor = const Color(0xFF00B795),
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.height = 150,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            SectionHeader(
              title: title,
              titleColor: titleColor,
              seeAllColor: seeAllColor,
              onSeeAll: onSeeAll, // Pass to SectionHeader
            ),
          SizedBox(
            height: height,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: padding,
                child: Row(
                  children: items,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
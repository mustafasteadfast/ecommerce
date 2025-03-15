import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Color seeAllColor;
  final VoidCallback? onSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.titleColor = Colors.black,
    this.seeAllColor = const Color(0xFF00B795),
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: titleColor,
              fontFamily: 'Onest', // Applied Onest font
            ),
          ),
          TextButton(
            onPressed: onSeeAll ?? () {},
            child: Text(
              'See All',
              style: TextStyle(
                color: seeAllColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Onest', // Applied Onest font
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    // Explicitly type the list as List<Map<String, dynamic>>
    final List<Map<String, dynamic>> quickActions = [
      {'image': 'assets/free_shipping_card.png', 'label': '', 'width': 150.0, 'height': 80.0},
      {'image': 'assets/big_sale.png', 'label': 'Big Sale', 'width': 80.0, 'height': 80.0},
      {'image': 'assets/fashion_deals.png', 'label': 'Fashion', 'width': 80.0, 'height': 80.0},
      {'image': 'assets/save_more.png', 'label': 'Save More', 'width': 80.0, 'height': 80.0},
      {'image': 'assets/buy_one_get_one.png', 'label': 'Buy 1 Get 1', 'width': 80.0, 'height': 80.0},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: quickActions.map((action) {
          // Safely cast 'label' to String and check isEmpty
          final String label = action['label'] as String;
          return Expanded(
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisAlignment: label.isEmpty
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  Container(
                    height: action['height'] as double,
                    alignment: label.isEmpty ? null : Alignment.center,
                    child: Image.asset(
                      action['image'] as String, // Cast to String
                      width: action['width'] as double,
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (label.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Onest',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList().expand((widget) => [widget, const SizedBox(width: 8)]).toList()
          ..removeLast(), // Remove trailing SizedBox
      ),
    );
  }
}
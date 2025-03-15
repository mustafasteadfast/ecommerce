import 'package:flutter/material.dart';

class FlashSaleHeader extends StatelessWidget {
  final Color customGreen;

  const FlashSaleHeader({super.key, required this.customGreen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              // Image.asset(
              //   'assets/electricity.png',
              //   width: 24,
              //   height: 24,
              //   color: Colors.white,
              // ),
              SizedBox(width: 8),
              Text(
                '⚡ Flash Sale',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Onest',
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Ends in: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Onest',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '12:45:26',
                  style: TextStyle(
                    color: Color(0xFFF67317),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Onest',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
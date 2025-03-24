import 'package:flutter/material.dart';
import 'components/promotional_banner.dart';
import 'components/quick_actions_row.dart';
import 'components/flash_sale_header.dart';
import 'components/product_section.dart';
import 'components/horizontal_scroll_section.dart';
import 'components/snap_sale_section.dart';
import 'components/quick_action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  final Color customGreen = const Color(0xFF00B795);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Future.delayed(const Duration(seconds: 1), () {
      _startAutoSlide();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      _startAutoSlide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey, size: 20),
          onPressed: null,
        ),
        title: Container(
          width: 295,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for anything...',
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontFamily: 'Onest',
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/search_icon.png',
                  width: 20,
                  height: 20,
                ),
              ),
              suffixIcon: IconButton(
                icon: Image.asset(
                  'assets/camera_icon.png',
                  width: 20,
                  height: 20,
                  color: Colors.grey[600],
                ),
                padding: EdgeInsets.zero,
                onPressed: () {},
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/cart_icon.png',
                  width: 32,
                  height: 32,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: customGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Onest',
                    ),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Image.asset(
              'assets/menu_icon.png',
              width: 20,
              height: 20,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PromotionalBanner(
              sliderType: 'Slider Shop',
              height: 180,
            ),
            const QuickActionsRow(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/flash_sale_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  FlashSaleHeader(customGreen: customGreen),
                  const SizedBox(height: 16),
                  HorizontalScrollSection(
                    title: '',
                    titleColor: Colors.white,
                    items: List.generate(
                      3,
                      (index) => Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/flash_sale_${index + 1}.png',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: customGreen,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  '৳520',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Onest',
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: customGreen,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  '-52%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Onest',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    height: 150,
                  ),
                ],
              ),
            ),
            HorizontalScrollSection(
              title: 'Categories',
              seeAllColor: customGreen,
              items: [
                for (var category in [
                  {'icon': 'assets/mens_fashion.png', 'name': "Men's\nFashion"},
                  {
                    'icon': 'assets/womens_fashion.png',
                    'name': "Women's\nFashion"
                  },
                  {
                    'icon': 'assets/home_appliances.png',
                    'name': 'Home\nAppliances'
                  },
                  {'icon': 'assets/home_wears.png', 'name': 'Home\nWears'},
                  {'icon': 'assets/furniture.png', 'name': 'Furniture'},
                ])
                  Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                category['icon']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category['name']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.2,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Onest',
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
              height: 120,
              onSeeAll: () {
                Navigator.pushNamed(context, '/categories');
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/cleaning_banner.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const ProductSection(
              title: 'New Arrivals',
              height: 280,
              itemCount: 4,
              imagePrefix: 'assets/new_arrival_\${index + 1}',
            ),
            const SizedBox(height: 16),
            HorizontalScrollSection(
              title: 'Popular Shops',
              backgroundColor: Colors.white,
              items: [
                for (var shop in [
                  {'name': 'BMW Moto', 'logo': 'bmw'},
                  {'name': 'Envato Market', 'logo': 'envato'},
                  {'name': 'Huawei Official', 'logo': 'huawei'},
                  {'name': 'Dell Official', 'logo': 'dell'},
                  {'name': 'Intel Shop', 'logo': 'intel'},
                ])
                  Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/${shop['logo']}_logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          shop['name']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Onest',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.people_outline,
                              size: 12,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '1.2k',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                                fontFamily: 'Onest',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
              height: 120,
            ),
            const SnapSaleSection(),
            Container(
              width: 547,
              height: 350,
              child: const ProductSection(
                title: '💥 Best selling products',
                titleColor: Colors.white,
                seeAllColor: Colors.white,
                backgroundColor: Color(0xFF0F172A),
                height: 280,
                itemCount: 3,
                imagePrefix: 'assets/best_selling_\${index + 1}',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QuickActionButton(
                  icon: 'assets/free_shipping_icon.png',
                  label: 'Free Shipping',
                  onTap: () {},
                  fontFamily: 'Onest',
                ),
                QuickActionButton(
                  icon: 'assets/big_sale_icon.png',
                  label: 'Big Sale',
                  onTap: () {},
                  fontFamily: 'Onest',
                ),
                QuickActionButton(
                  icon: 'assets/fashion_deals_icon.png',
                  label: 'Fashion Deals',
                  onTap: () {},
                  fontFamily: 'Onest',
                ),
              ],
            ),
            const SizedBox(height: 16),
            ProductSection(
              title: 'Featured Products',
              height: 0,
              isGrid: true,
              itemCount: 4,
              onSeeAll: () {
                Navigator.pushNamed(context, '/all-products');
              },
            ),
          ],
        ),
      ),
    );
  }
}
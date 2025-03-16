import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providers/home_provider.dart';
import 'package:ecommerce/screens/home/widgets/flash_sale_section.dart';
import 'package:ecommerce/components/horizontal_scroll_section.dart';
import 'package:ecommerce/components/promotional_banner.dart';
import 'package:ecommerce/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load home data when screen initializes
    Future.microtask(
      () => Provider.of<HomeProvider>(context, listen: false).loadHomeData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                await provider.loadHomeData();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Main Promotional Banner (Slider Root)
                    const PromotionalBanner(
                      sliderType: 'Slider Root',
                      height: 180,
                    ),

                    // Flash Sale Section
                    if (provider.flashSaleProducts.isNotEmpty)
                      FlashSaleSection(
                        products: provider.flashSaleProducts,
                      ),

                    // Secondary Promotional Banner (Slider Shop)
                    const PromotionalBanner(
                      sliderType: 'Slider Shop',
                      height: 150,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),

                    // Featured Products Section
                    if (provider.featuredProducts.isNotEmpty)
                      HorizontalScrollSection(
                        title: 'Featured Products',
                        height: 200,
                        items: provider.featuredProducts.map((product) {
                          return SizedBox(
                            width: 160,
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    product.imageUrl,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '৳${product.price}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                    // New Arrivals Section
                    if (provider.newArrivals.isNotEmpty)
                      HorizontalScrollSection(
                        title: 'New Arrivals',
                        height: 200,
                        items: provider.newArrivals.map((product) {
                          return SizedBox(
                            width: 160,
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    product.imageUrl,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '৳${product.price}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

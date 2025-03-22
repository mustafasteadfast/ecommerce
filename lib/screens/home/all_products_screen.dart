import 'dart:developer';

import 'package:ecommerce/blocs/combine/combine_event.dart';
import 'package:ecommerce/blocs/combine/combine_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/blocs/product/product_bloc.dart';
import 'package:ecommerce/blocs/product/product_event.dart';
import 'package:ecommerce/blocs/product/product_state.dart';
import 'package:ecommerce/components/product_card.dart';
import 'package:ecommerce/models/product.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Product> _products = [];
  int _skip = 0;
  static const int _limit = 10;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    log('AllProductsScreen: Initializing screen');
    _scrollController.addListener(_onScroll);
    _loadMoreProducts();
  }

  void _loadMoreProducts() {
    log('AllProductsScreen: Attempting to load more products');
    log('Current state - isLoadingMore: $_isLoadingMore, hasMore: $_hasMore, skip: $_skip');

    if (!_isLoadingMore && _hasMore) {
      _isLoadingMore = true;
      log('AllProductsScreen: Fetching products with limit: $_limit, skip: $_skip');
      context
          .read<ProductBloc>()
          .add(FetchResponseWithArgs({'limit': _limit, 'skip': _skip}));
    } else {
      log('AllProductsScreen: Skipping load more - isLoadingMore: $_isLoadingMore, hasMore: $_hasMore');
    }
  }

  void _onScroll() {
    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final shouldLoadMore = currentScroll >= maxScroll - 800;

    log('AllProductsScreen: Scroll position - current: $currentScroll, max: $maxScroll, shouldLoadMore: $shouldLoadMore');

    if (shouldLoadMore && !_isLoadingMore && _hasMore) {
      log('AllProductsScreen: Triggering load more products');
      _loadMoreProducts();
    }

    final shouldShowFab = currentScroll > 100;
    if (shouldShowFab != _showFab) {
      log('AllProductsScreen: Updating FAB visibility - show: $shouldShowFab');
      setState(() => _showFab = shouldShowFab);
    }
  }

  void _scrollToTop() {
    log('AllProductsScreen: Scrolling to top');
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    log('AllProductsScreen: Disposing screen');
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('AllProductsScreen: Building screen - products count: ${_products.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Featured Products',
          style: TextStyle(fontFamily: 'Onest'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<ProductBloc, CombineState>(
        listener: (context, state) {
          log('AllProductsScreen: State changed - ${state.runtimeType}');

          if (state is CombineLoaded<ProductResponse>) {
            final newProducts = state.response.products;
            log('AllProductsScreen: Received ${newProducts.length} new products');
            log('Total products in response: ${state.response.total}');

            _products.addAll(newProducts);
            _skip = _products.length;
            _isLoadingMore = false;
            _hasMore = _products.length < state.response.total;

            log('Updated state - products: ${_products.length}, skip: $_skip, hasMore: $_hasMore');
          } else if (state is CombineError) {
            log('AllProductsScreen: Error state received - ${state.message}');
            _isLoadingMore = false;
          }
        },
        builder: (context, state) {
          log('AllProductsScreen: Building UI for state - ${state.runtimeType}');

          if (state is CombineLoading && _products.isEmpty) {
            log('AllProductsScreen: Showing initial loading state');
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CombineError && _products.isEmpty) {
            log('AllProductsScreen: Showing error state - ${state.message}');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: _loadMoreProducts,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (_products.isEmpty) {
            log('AllProductsScreen: No products available');
            return const Center(child: Text('No products loaded yet'));
          }

          log('AllProductsScreen: Building product grid with ${_products.length} products');
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == _products.length && _hasMore) {
                        log('AllProductsScreen: Building loading indicator at index $index');
                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _isLoadingMore ? 1.0 : 0.0,
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(
                                color: Color(0xFF00B795),
                              ),
                            ),
                          ),
                        );
                      }
                      final product = _products[index];
                      log('AllProductsScreen: Building product card for ${product.name} at index $index');
                      return Hero(
                        tag: 'product_${product.id}',
                        child: Material(
                          color: Colors.transparent,
                          child: ProductCard(
                            title: product.name,
                            price: '৳${product.price}',
                            oldPrice: '',
                            rating: product.rating.toString(),
                            reviews: '(${product.reviewCount})',
                            imagePath: product.imageUrl,
                            fontFamily: 'Onest',
                            fontSize: 12,
                            priceFontSize: 14,
                            ratingFontSize: 10,
                            isNetworkImage: true,
                          ),
                        ),
                      );
                    },
                    childCount: _products.length + (_hasMore ? 1 : 0),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _showFab ? 1.0 : 0.0,
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          backgroundColor: const Color(0xFF00B795),
          child: const Icon(Icons.arrow_upward, color: Colors.white),
        ),
      ),
    );
  }
}

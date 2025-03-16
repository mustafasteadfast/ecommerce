import 'package:flutter/material.dart';
import 'package:ecommerce/models/product.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Product> _flashSaleProducts = [];
  List<Product> _featuredProducts = [];
  List<Product> _newArrivals = [];

  bool get isLoading => _isLoading;
  List<Product> get flashSaleProducts => _flashSaleProducts;
  List<Product> get featuredProducts => _featuredProducts;
  List<Product> get newArrivals => _newArrivals;

  Future<void> loadHomeData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock flash sale products
      _flashSaleProducts = [
        Product(
          id: '1',
          name: 'Nike Air Max',
          description: 'Nike Air Max Running Shoes',
          price: 199.99,
          discountPercentage: 20,
          imageUrl: 'assets/flash_sale_1.png',
          categoryId: '1',
          shopId: '1',
        ),
        Product(
          id: '2',
          name: 'Samsung Watch',
          description: 'Samsung Galaxy Watch 5',
          price: 299.99,
          discountPercentage: 15,
          imageUrl: 'assets/flash_sale_2.png',
          categoryId: '2',
          shopId: '2',
        ),
        Product(
          id: '3',
          name: 'Wireless Earbuds',
          description: 'Premium Wireless Earbuds',
          price: 149.99,
          discountPercentage: 25,
          imageUrl: 'assets/flash_sale_3.png',
          categoryId: '3',
          shopId: '3',
        ),
      ];

      // Mock featured products
      _featuredProducts = [
        Product(
          id: '4',
          name: 'Smart TV',
          description: '55" 4K Smart TV',
          price: 699.99,
          discountPercentage: 10,
          imageUrl: 'assets/featured_1.png',
          categoryId: '4',
          shopId: '4',
        ),
        Product(
          id: '5',
          name: 'Gaming Console',
          description: 'Next-gen Gaming Console',
          price: 499.99,
          discountPercentage: 5,
          imageUrl: 'assets/featured_2.png',
          categoryId: '5',
          shopId: '5',
        ),
        Product(
          id: '6',
          name: 'Laptop Pro',
          description: 'Professional Laptop',
          price: 1299.99,
          discountPercentage: 15,
          imageUrl: 'assets/featured_3.png',
          categoryId: '6',
          shopId: '6',
        ),
      ];

      // Mock new arrivals
      _newArrivals = [
        Product(
          id: '7',
          name: 'Smart Speaker',
          description: 'AI-powered Smart Speaker',
          price: 99.99,
          discountPercentage: 0,
          imageUrl: 'assets/new_arrival_1.png',
          categoryId: '7',
          shopId: '7',
        ),
        Product(
          id: '8',
          name: 'Fitness Tracker',
          description: 'Advanced Fitness Tracker',
          price: 79.99,
          discountPercentage: 0,
          imageUrl: 'assets/new_arrival_2.png',
          categoryId: '8',
          shopId: '8',
        ),
      ];

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}

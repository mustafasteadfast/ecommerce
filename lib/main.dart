import 'package:ecommerce/blocs/category/categories_bloc.dart';
import 'package:ecommerce/blocs/combine/combine_event.dart';
import 'package:ecommerce/screens/categories_screen.dart';
import 'package:ecommerce/screens/home/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/blocs/slider/slider_bloc.dart';
import 'package:ecommerce/blocs/product/product_bloc.dart';
import 'package:ecommerce/services/slider_service.dart';
import 'package:ecommerce/services/product_service.dart';
import 'package:ecommerce/services/category_service.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SliderBloc(SliderService())..add(FetchResponse()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductService()),
        ),
        BlocProvider(
          create: (context) =>
              CategoriesBloc(CategoryService())..add(FetchResponse()),
        ),
      ],
      child: MaterialApp(
        title: 'E-Commerce App',
        theme: ThemeData(
          primaryColor: const Color(0xFF00B795),
          scaffoldBackgroundColor: const Color(0xFFF1F5F9),
          fontFamily: 'Onest',
        ),
        home: HomeScreen(),
        routes: {
          '/all-products': (context) => const AllProductsScreen(),
          '/categories': (context) => const CategoriesScreen(),
        },
      ),
    );
  }
}
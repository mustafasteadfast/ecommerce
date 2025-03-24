import 'dart:developer';
import 'package:ecommerce/blocs/category/categories_bloc.dart';
import 'package:ecommerce/blocs/combine/combine_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/blocs/combine/combine_state.dart';
import 'package:ecommerce/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(fontFamily: 'Onest'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<CategoriesBloc, CombineState>(
        listener: (context, state) {
          log('CategoriesScreen: State changed - ${state.runtimeType}');
          if (state is CombineError) {
            log('CategoriesScreen: Error - ${state.message}');
          }
        },
        builder: (context, state) {
          log('CategoriesScreen: Building UI for state - ${state.runtimeType}');

          if (state is CombineLoading) {
            log('CategoriesScreen: Showing loading state');
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CombineError) {
            log('CategoriesScreen: Showing error state - ${state.message}');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<CategoriesBloc>().add(FetchResponse()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CombineLoaded<CategoryResponse>) {
            final categories = state.response.categories;
            log('CategoriesScreen: Building grid with ${categories.length} categories');

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final category = categories[index];
                        log('CategoriesScreen: Building category card for ${category.name ?? "Unnamed"}');
                        return Material(
                          color: Colors.transparent,
                          child: Card(
                            elevation: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: category.image != null
                                      ? Image.network(
                                          category.image!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(Icons.error),
                                        )
                                      : const Icon(Icons.image_not_supported,
                                          size: 50),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    category.name ?? 'Unnamed Category',
                                    style: const TextStyle(
                                      fontFamily: 'Onest',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: categories.length,
                    ),
                  ),
                ),
              ],
            );
          }

          log('CategoriesScreen: Showing default loading state');
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

import 'package:ecommerce/blocs/combine/combine_event.dart';
import 'package:ecommerce/blocs/combine/combine_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/services/category_service.dart';

class CategoriesBloc extends Bloc<CombineEvent, CombineState> {
  final CategoryService _categoryService;

  CategoriesBloc(this._categoryService) : super(CombineInitial()) {
    on<FetchResponse>(_onFetchCategories);
    add(FetchResponse());
  }

  Future<void> _onFetchCategories(
      CombineEvent event, Emitter<CombineState> emit) async {
    emit(CombineLoading());
    try {
      final categoryResponse = await _categoryService.getCategories();
      print(
          'Fetched ${categoryResponse.categories.length} categories: ${categoryResponse.categories.map((c) => c.name)}');
      emit(CombineLoaded(categoryResponse));
    } catch (e) {
      print('Error fetching categories: $e');
      emit(CombineError('Failed to load categories: $e'));
    }
  }
}

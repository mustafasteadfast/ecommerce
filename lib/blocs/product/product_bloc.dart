import 'package:ecommerce/blocs/combine/combine_event.dart';
import 'package:ecommerce/blocs/combine/combine_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/services/product_service.dart';


class ProductBloc extends Bloc<CombineEvent, CombineState> {
  final ProductService _productService;
  ProductService get productService => _productService;

  ProductBloc(this._productService) : super(CombineInitial()) {
    on<FetchResponseWithArgs>(_onFetchProducts);
    add(const FetchResponseWithArgs({
      'limit': 10,
      'skip': 0,
    })); // Initial fetch
  }

  Future<void> _onFetchProducts(
      CombineEvent event, Emitter<CombineState> emit) async {
    emit(CombineLoading());
    try {
      if (event is FetchResponseWithArgs) {
        final productResponse = await _productService.getProducts(
          limit: event.args['limit'] ?? 10,
          skip: event.args['skip'] ?? 0,
        );
        print(
            'Fetched ${productResponse.products.length} products: ${productResponse.products.map((p) => p.name)}'); // Debug
        emit(CombineLoaded(productResponse));
      }
    } catch (e) {
      print('Error fetching products: $e'); // Debug
      emit(CombineError('Failed to load products: $e'));
    }
  }
}

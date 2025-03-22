import 'package:ecommerce/blocs/combine/combine_event.dart';
import 'package:ecommerce/blocs/combine/combine_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/services/slider_service.dart';

class SliderBloc extends Bloc<CombineEvent, CombineState> {
  final SliderService _sliderService;

  SliderBloc(this._sliderService) : super(CombineInitial()) {
    on<FetchResponse>(_onFetchSliders);
  }

  Future<void> _onFetchSliders(
      CombineEvent event, Emitter<CombineState> emit) async {
    emit(CombineLoading());
    try {
      final sliderResponse = await _sliderService.getSliders();
      emit(CombineLoaded(sliderResponse));
    } catch (e) {
      emit(CombineError('Failed to load sliders: $e'));
    }
  }
}
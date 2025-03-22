import 'package:equatable/equatable.dart';
import 'package:ecommerce/models/slider.dart';

abstract class SliderState extends Equatable {
  const SliderState();

  @override
  List<Object?> get props => [];
}

class SliderInitial extends SliderState {}

class SliderLoading extends SliderState {}

class SliderLoaded extends SliderState {
  final SliderResponse sliderResponse;

  const SliderLoaded(this.sliderResponse);

  @override
  List<Object?> get props => [sliderResponse];
}

class SliderError extends SliderState {
  final String message;

  const SliderError(this.message);

  @override
  List<Object?> get props => [message];
}
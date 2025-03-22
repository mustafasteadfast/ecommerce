import 'package:equatable/equatable.dart';

abstract class CombineState extends Equatable {
  const CombineState();

  @override
  List<Object?> get props => [];
}


class CombineInitial extends CombineState {}

class CombineLoading extends CombineState {}

class CombineLoaded<T> extends CombineState {
  final T response;

  const CombineLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class CombineError extends CombineState {
  final String message;

  const CombineError(this.message);

  @override
  List<Object?> get props => [message];
}
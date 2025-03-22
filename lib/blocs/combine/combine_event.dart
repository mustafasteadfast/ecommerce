import 'package:equatable/equatable.dart';

abstract class CombineEvent extends Equatable {
  const CombineEvent();

  @override
  List<Object?> get props => [];
}

class FetchResponse extends CombineEvent {}

class FetchResponseWithArgs extends CombineEvent {
  final Map<String, dynamic> args;

  const FetchResponseWithArgs(this.args);

  @override
  List<Object?> get props => [args];
}

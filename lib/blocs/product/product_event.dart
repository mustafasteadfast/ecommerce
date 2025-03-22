
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class FetchProducts extends ProductEvent {
  final int limit;
  final int skip;

  const FetchProducts({this.limit = 10, this.skip = 0});

  @override
  List<Object?> get props => [limit, skip];
}
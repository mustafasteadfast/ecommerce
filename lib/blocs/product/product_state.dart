import 'package:equatable/equatable.dart';
import 'package:ecommerce/models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductResponse productResponse; // Simplified, no total/skip/limit
 
  const ProductLoaded({
    required this.productResponse,
   
  });

  @override
  List<Object?> get props => [productResponse];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
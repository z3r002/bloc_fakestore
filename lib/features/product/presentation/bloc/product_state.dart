import 'package:bloc_pet/features/product/data/dto/products_dto.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);
}
class ProductError extends ProductState {
  final String error;

  ProductError(this.error);
}
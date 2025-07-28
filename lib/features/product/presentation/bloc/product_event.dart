abstract class ProductEvent {
  const ProductEvent();
}

class GetProductsEvent extends ProductEvent {}

class GetProductEvent extends ProductEvent {
  final String id;
  const GetProductEvent({required this.id});
}
class LoadProducts extends ProductEvent {}

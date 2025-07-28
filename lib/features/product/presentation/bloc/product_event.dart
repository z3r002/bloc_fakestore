abstract class ProductEvent {
  const ProductEvent();
}

class GetProductsEvent extends ProductEvent {}

class GetProductEvent extends ProductEvent {
  final String id;
  const GetProductEvent({required this.id});
}
class LoadProducts extends ProductEvent {}

class FilterProducts extends ProductEvent {
  final String category;
  const FilterProducts({required this.category});
}
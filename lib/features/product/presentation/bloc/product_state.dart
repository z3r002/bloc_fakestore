import 'package:bloc_pet/features/product/data/dto/products_dto.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products; // Отфильтрованные продукты
  final List<Product> allProducts; // Полный список продуктов
  final List<String> category;
  final String selectedCategory;

  ProductLoaded(
      this.products,
      this.allProducts, // Добавляем поле для полного списка
      [this.category = const [], this.selectedCategory = 'Все']
      );
}
class ProductError extends ProductState {
  final String error;

  ProductError(this.error);
}
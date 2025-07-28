import 'package:bloc_pet/features/product/data/repository/product_repository.dart';
import 'package:bloc_pet/features/product/presentation/bloc/product_event.dart';
import 'package:bloc_pet/features/product/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc(this._productRepository) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<FilterProducts>(_filterByCategory);
  }

  Future<void> _onLoadProducts(
      LoadProducts event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.getProducts();
      emit(ProductLoaded(
        products,
        products, // полный список продуктов
        ['Все', ...products.map((e) => e.category).toSet()],
      ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _filterByCategory(
      FilterProducts event,
      Emitter<ProductState> emit,
      ) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final allProducts = currentState.allProducts; // Используем полный список

      // Фильтруем продукты на основе полного списка
      final filteredProducts = event.category == 'Все'
          ? allProducts
          : allProducts.where((product) => product.category == event.category).toList();

      emit(ProductLoaded(
        filteredProducts,
        allProducts, // Передаем полный список
        currentState.category,
        event.category,
      ));
    }
  }
}
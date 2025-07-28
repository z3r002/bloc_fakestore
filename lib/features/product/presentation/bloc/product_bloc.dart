import 'package:bloc_pet/features/product/data/repository/product_repository.dart';
import 'package:bloc_pet/features/product/presentation/bloc/product_event.dart';
import 'package:bloc_pet/features/product/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>{
  final ProductRepository _productRepository;
  ProductBloc(this._productRepository) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
  }
  Future<void> _onLoadProducts(
      LoadProducts event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoading());
    try {

      final products = await _productRepository.getProducts();

      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
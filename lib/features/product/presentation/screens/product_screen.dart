import 'package:auto_route/auto_route.dart';
import 'package:bloc_pet/core/utils/di.dart';
import 'package:bloc_pet/features/product/presentation/bloc/product_bloc.dart';
import 'package:bloc_pet/features/product/presentation/bloc/product_event.dart';
import 'package:bloc_pet/features/product/presentation/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductBloc _productBloc= getIt<ProductBloc>();

  @override
  void initState() {
    super.initState();
    // Получаем экземпляр ProductBloc через getIt
    // Загружаем продукты при инициализации экрана
    _productBloc.add(LoadProducts());
  }

  @override
  void dispose() {
    _productBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _productBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Продукты'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return switch (state) {
              ProductInitial() || ProductLoading() =>
                const Center(child: CircularProgressIndicator()),
              ProductLoaded(products: final products) => ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    leading: Image.network(
                      products[index].image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error_outline, size: 50),
                    ),
                    title: Text(products[index].title),
                    subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
                    onTap: () {
                      // Обработка нажатия на продукт
                    },
                  ),
                ),
              ),
              ProductError(error: final error) =>
                Center(child: Text('Ошибка загрузки: $error')),
              _ => const Center(child: Text('Неизвестное состояние')),
            };
          },
        ),
      ),
    );
  }
}
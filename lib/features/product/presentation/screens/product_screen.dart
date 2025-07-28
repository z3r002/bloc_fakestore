import 'package:auto_route/auto_route.dart';
import 'package:bloc_pet/core/utils/di.dart';
import 'package:bloc_pet/features/product/presentation/bloc/product_bloc.dart';
import 'package:bloc_pet/features/product/presentation/bloc/product_event.dart';
import 'package:bloc_pet/features/product/presentation/bloc/product_state.dart';
import 'package:bloc_pet/features/product/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductBloc _productBloc = getIt<ProductBloc>();

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
              ProductInitial() ||
              ProductLoading() =>
              const Center(child: CircularProgressIndicator()),
              ProductLoaded(
              products: final products,
              category: final category
              ) =>
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          scrollDirection: Axis.horizontal,
                          itemCount: category.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                              _productBloc.add(FilterProducts(category: category[index]));
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: state.selectedCategory == category[index] ? Colors.black : Colors.cyan),
                                height: 30,
                                child: Text(
                                  category[index],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return ProductCard(product: products[index]);
                          },
                        ),
                      ),
                    ],
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

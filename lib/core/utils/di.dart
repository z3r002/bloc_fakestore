import 'package:bloc_pet/features/product/data/repository/product_repository.dart';
import 'package:bloc_pet/features/product/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

/// Функция для настройки всех зависимостей приложения
/// Вызывается один раз при запуске приложения
void setupServiceLocator() {
  // Регистрируем репозиторий как singleton
  // Singleton означает, что будет создан только один экземпляр
  // и он будет переиспользоваться во всем приложении
  getIt.registerSingleton<ProductRepository>(ProductRepository());

  // Регистрируем BLoC как factory
  // Factory означает, что каждый раз при запросе будет создаваться новый экземпляр
  // Это полезно для BLoC, так как каждый экран может иметь свой собственный BLoC
  getIt.registerFactory<ProductBloc>(
        () => ProductBloc(getIt<ProductRepository>()),
  );
}

/// Функция для очистки всех зависимостей
/// Полезна для тестирования или при необходимости сброса состояния
void resetServiceLocator() {
  getIt.reset();
}

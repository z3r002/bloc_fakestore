import 'package:bloc_pet/features/login/data/repository/auth_repository.dart';
import 'package:bloc_pet/features/login/presentation/bloc/auth_bloc.dart';
import 'package:bloc_pet/features/product/data/repository/product_repository.dart';
import 'package:bloc_pet/features/product/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

/// Функция для настройки всех зависимостей приложения
/// Вызывается один раз при запуске приложения
void setupServiceLocator() {
  // Регистрируем репозитории как singleton
  getIt.registerSingleton<AuthRepository>(AuthRepository());
  getIt.registerSingleton<ProductRepository>(ProductRepository());

  // Регистрируем BLoCs как factory
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(getIt<AuthRepository>()),
  );
  
  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(getIt<ProductRepository>()),
  );
}

/// Функция для очистки всех зависимостей
/// Полезна для тестирования или при необходимости сброса состояния
void resetServiceLocator() {
  getIt.reset();
}

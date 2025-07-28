import 'package:bloc_pet/core/data/api/api_client.dart';
import 'package:bloc_pet/features/product/data/dto/products_dto.dart';
import 'package:dio/dio.dart';

class ProductRepository {
  final ApiClient _apiClient;

  ProductRepository() : _apiClient = ApiClient.instance();

  Future<List<Product>> getProducts() async {
    try {
      final products = await _apiClient.getProducts();
      return products;
    } on DioException catch (e) {
      print('Ошибка при получении продуктов: ${e.message}');
      rethrow;
    } catch (e) {
      print('Неизвестная ошибка: $e');
      rethrow;
    }
  }
}
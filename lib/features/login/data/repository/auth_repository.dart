import 'package:bloc_pet/core/data/api/api_client.dart';
import 'package:bloc_pet/features/login/data/dto/auth_dto.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository() : _apiClient = ApiClient.instance();

  Future authUser() async {
    try {
      final token = await _apiClient.login( AuthRequest(username: '', password: ''));
      return token;
    } on DioException catch (e) {
      print('Ошибка при получении продуктов: ${e.message}');
      rethrow;
    } catch (e) {
      print('Неизвестная ошибка: $e');
      rethrow;
    }
  }
}
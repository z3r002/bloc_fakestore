import 'package:bloc_pet/core/data/api/api_client.dart';
import 'package:bloc_pet/features/login/data/dto/auth_dto.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository() : _apiClient = ApiClient.instance();

  Future<String> authUser(String username, String password) async {
    try {
      final response = await _apiClient.login(AuthRequest(username: username, password: password));
      if (response is Map<String, dynamic> && response.containsKey('token')) {
        return response['token'] as String;
      } else if (response is String) {
        return response;
      } else {
        throw Exception('Invalid response format from server');
      }
    } on DioException catch (e) {
      print('Ошибка при аутентификации: ${e.message}');
      rethrow;
    } catch (e) {
      print('Неизвестная ошибка: $e');
      rethrow;
    }
  }
}
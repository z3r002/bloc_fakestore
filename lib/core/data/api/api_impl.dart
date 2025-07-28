import 'package:bloc_pet/core/data/api/api_client.dart';
import 'package:get_it/get_it.dart';

abstract class ApiImpl {
  late final ApiClient apiClient;

  ApiImpl() {
    apiClient = GetIt.I.get<ApiClient>();
  }
}
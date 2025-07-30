import 'package:bloc_pet/features/login/data/dto/auth_dto.dart';
import 'package:bloc_pet/features/product/data/dto/products_dto.dart';
import 'package:bloc_pet/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  static Future? refreshTokenFuture;
  static bool tokenExpired = false;

  static instance() {
    final dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        // await refreshHandler(options);
        print('PATH: ${options.path} REQUEST: ${options.data}');

        return handler.next(options);
      }, onResponse:
          (Response response, ResponseInterceptorHandler handler) async {
        print(
            'PATH: ${response.requestOptions.path} RESPONSE: ${response.data}');
        return handler.next(response);
      }, onError: (DioException err, ErrorInterceptorHandler handler) async {
        print(
            'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');


        showDialog(
            context: appRouter.navigatorKey.currentState!.context,
            builder: (ctx) => AlertDialog(
              title: Text('Ошибка!'),
              content: Text(err.response!.data.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(
                          appRouter.navigatorKey.currentState!.context)
                          .pop();
                    },
                    child: Text('ОК'))
              ],
            )).then((value) => handler.next(err));
      }),
    );

    return ApiClient(dio, baseUrl: 'https://fakestoreapi.com');
  }

  @GET("/products")
  Future<List<Product>> getProducts();

  @POST("/auth/login")
  Future login(@Body() AuthRequest request);


}
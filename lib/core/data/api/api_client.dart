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
              content: Text(err.response!.data['message'].toString()),
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

  // @GET("/v1/mo/{mo_id}/district")
  // Future<GetDistrictResponse> getDistrict(@Path("mo_id") int moId);
  //
  // @GET("/v1/mo/{mo_id}/district/{district}/street")
  // Future<GetStreetsResponse> getStreet(
  //     @Path("mo_id") int moId, @Path("district") String street);
  //
  // @GET("/v1/mo/{mo_id}/district/{district}/street/{street}/house")
  // Future<GetHouseResponse> getHouse(@Path("mo_id") int moId,
  //     @Path("district") String district, @Path("street") String street);
  //
  // @GET("/v1/mo/{mo_id}/district/{district}/street/{street}/house/{house}/flat")
  // Future<GetFlatsResponse> getFlats(
  //     @Path("mo_id") int moId,
  //     @Path("district") String district,
  //     @Path("street") String street,
  //     @Path("house") String house);
  //
  // @GET("/v1/type-values")
  // Future<GetTypeValues> getTypeValues();
  //
  // @POST("/v1/update-gas-status")
  // Future sendGasTrue(@Body() GasTrueRequest request);
  //
  // @POST("/v1/add")
  // Future addAddress(@Body() GasTrueRequest request);
  //
  // @POST("/v1/upload")
  // Future uploadAddress(@Body() UploadAddressRequest request);
  //
  // @POST("/v1/auth/login")
  // Future sendLogin(@Body() RequestLogin request);


}